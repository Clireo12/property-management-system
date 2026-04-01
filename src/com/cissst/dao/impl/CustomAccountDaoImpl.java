package com.cissst.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cissst.dao.ICustomAccountDao;
import com.cissst.entity.CustomAccount;
import com.cissst.util.DBUtil;

public class CustomAccountDaoImpl implements ICustomAccountDao {
	public List<CustomAccount> getALLcustomAccount() {
		String sql = "select * from custom_account order by username";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;

		List<CustomAccount> list = new ArrayList<CustomAccount>();
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while (rs.next()) {
				CustomAccount c = new CustomAccount();
				c.setAccountid(rs.getInt("accountid"));
				c.setUsername(rs.getString("username"));
				c.setPassword(rs.getString("password"));
				c.setOwnerid(rs.getString("ownerid"));
				c.setCarid(rs.getString("carid"));
				c.setOwner_image(rs.getString("owner_image"));
				list.add(c);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
			DBUtil.close(conn);
		}
		return list;
	}

	public void save(CustomAccount c) {

		String sql = "insert into custom_account(USERNAME,PASSWORD,OWNERID,CARID,OWNER_IMAGE) " + "values(?,?,?,?,?) ";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, c.getUsername());
			stmt.setString(2, c.getPassword());
			stmt.setString(3, c.getOwnerid());
			stmt.setString(4, c.getCarid());
			stmt.setString(5, c.getOwner_image());
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(stmt);
			DBUtil.close(conn);
		}
	}

	public CustomAccount getCustomAccountById(String accountid) {

		String sql = "select * from custom_account where accountid = ?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		CustomAccount c = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, accountid);
			rs = stmt.executeQuery();
			while (rs.next()) {
				c = new CustomAccount();
				c.setAccountid(rs.getInt("accountid"));
				c.setUsername(rs.getString("username"));
				c.setPassword(rs.getString("password"));
				c.setOwnerid(rs.getString("ownerid"));
				c.setCarid(rs.getString("carid"));
				c.setOwner_image(rs.getString("owner_image"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
			DBUtil.close(conn);
		}
		return c;
	}

	public void update(CustomAccount c) {
		String sql = " update custom_account  set  USERNAME=?,PASSWORD=?,OWNERID=?,CARID=? ,OWNER_IMAGE=? where accountid = ?";

		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, c.getUsername());
			stmt.setString(2, c.getPassword());
			stmt.setString(3, c.getOwnerid());
			stmt.setString(4, c.getCarid());
			stmt.setString(5, c.getOwner_image());
			stmt.setInt(6, c.getAccountid());

			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(stmt);
			DBUtil.close(conn);
		}
	}

	public void delete(String accountid) {
		String sql = "delete  from CUSTOM_ACCOUNT where ACCOUNTID= ?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, accountid);
			stmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(stmt);
			DBUtil.close(conn);
		}
	}

	@Override
	public List<CustomAccount> searchCustomAccounts(String keyword) {
		String sql = "SELECT * FROM custom_account WHERE " + "username LIKE ? OR " + "ownerid LIKE ? OR "
				+ "carid LIKE ?";

		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<CustomAccount> list = new ArrayList<>();

		try {
			stmt = conn.prepareStatement(sql);
			String searchPattern = "%" + keyword + "%";
			stmt.setString(1, searchPattern);
			stmt.setString(2, searchPattern);
			stmt.setString(3, searchPattern);

			rs = stmt.executeQuery();
			while (rs.next()) {
				CustomAccount c = new CustomAccount();
				c.setAccountid(rs.getInt("accountid"));
				c.setUsername(rs.getString("username"));
				c.setPassword(rs.getString("password"));
				c.setOwnerid(rs.getString("ownerid"));
				c.setCarid(rs.getString("carid"));
				c.setOwner_image(rs.getString("owner_image"));
				list.add(c);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
			DBUtil.close(conn);
		}
		return list;
	}

	public CustomAccount getCustomAccountBynp(String username, String password) {

		String sql = "select * from custom_account where username = ? and password= ?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		CustomAccount c = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, username);
			stmt.setString(2, password);
			rs = stmt.executeQuery();
			while (rs.next()) {
				c = new CustomAccount();
				c.setAccountid(rs.getInt("accountid"));
				c.setUsername(rs.getString("username"));
				c.setPassword(rs.getString("password"));
				c.setOwnerid(rs.getString("ownerid"));
				c.setCarid(rs.getString("carid"));
				c.setOwner_image(rs.getString("owner_image"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
			DBUtil.close(conn);
		}
		return c;
	}
}
