package com.cissst.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.cissst.dao.IAdminDao;
import com.cissst.entity.Admin;
import com.cissst.util.DBUtil;

public class AdminDaoImpl implements IAdminDao {
	public List<Admin> getAllAdmin() {

		String sql = "select * from admin order by name";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<Admin> list = new ArrayList<>();

		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while (rs.next()) {
				Admin a = new Admin();
				a.setId(rs.getInt("id"));
				a.setName(rs.getString("name"));
				a.setPassword(rs.getString("password"));
				a.setAge(rs.getInt("age"));
				a.setSex(rs.getString("sex"));
				a.setTel(rs.getString("tel"));
				a.setPhone(rs.getString("phone"));
				a.setAddr(rs.getString("addr"));
				a.setMemo(rs.getString("memo"));
				list.add(a);
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

	public void save(Admin a) {

		String sql = "insert into admin(NAME,PASSWORD,SEX,AGE,TEL,PHONE,ADDR,MEMO) values(?,?,?,?,?,?,?,?)";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, a.getName());
			stmt.setString(2, a.getPassword());
			stmt.setString(3, a.getSex());
			stmt.setInt(4, (Integer) a.getAge());
			stmt.setString(5, a.getTel());
			stmt.setString(6, a.getPhone());
			stmt.setString(7, a.getAddr());
			stmt.setString(8, a.getMemo());
			stmt.executeUpdate();
			// 获取生成的GUID并转换为哈希码（模拟整型ID）
			rs = stmt.getGeneratedKeys();
			if (rs.next()) {
				a.setId(rs.getInt(1)); // 直接获取自增ID
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
			DBUtil.close(conn);
		}
	}

	public Admin getAdminById(String idStr) {
	    // 1. 校验参数合法性（避免空指针或非数字字符串）
	    if (idStr == null || idStr.trim().isEmpty()) {
	        System.out.println("ID参数不能为空");
	        return null;
	    }
	    
	    int id;
	    try {
	        // 2. 将String类型参数转换为int（与数据库类型匹配）
	        id = Integer.parseInt(idStr.trim());
	    } catch (NumberFormatException e) {
	        System.out.println("ID参数格式错误，必须是整数：" + idStr);
	        return null;
	    }
	    
	    String sql = "select * from admin where id = ?";
	    Connection conn = DBUtil.getConnection();
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    Admin admin = null;
	    
	    try {
	        stmt = conn.prepareStatement(sql);
	        // 3. 用int类型设置SQL参数（与数据库字段类型一致）
	        stmt.setInt(1, id);
	        rs = stmt.executeQuery();
	        
	        // 4. 用if而非while（ID是唯一主键，最多一条记录）
	        if (rs.next()) {
	            admin = new Admin();
	            admin.setId(rs.getInt("id"));       // 直接获取int类型的id
	            admin.setName(rs.getString("name"));
	            admin.setPassword(rs.getString("password"));
	            admin.setAge(rs.getInt("age"));
	            admin.setSex(rs.getString("sex"));
	            admin.setTel(rs.getString("tel"));
	            admin.setPhone(rs.getString("phone"));
	            admin.setAddr(rs.getString("addr"));
	            admin.setMemo(rs.getString("memo"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        // 5. 确保资源关闭
	        DBUtil.close(rs);
	        DBUtil.close(stmt);
	        DBUtil.close(conn);
	    }
	    
	    return admin;
	}

	public void update(Admin a) {
		String sql = " update admin  set  NAME = ?,PASSWORD = ?,SEX = ?,AGE = ?, TEL = ?,"
				+ "PHONE = ?,ADDR = ?,MEMO = ? where id = ? ";

		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, a.getName());
			stmt.setString(2, a.getPassword());
			stmt.setString(3, a.getSex());
			stmt.setInt(4, (Integer) a.getAge());
			stmt.setString(5, a.getTel());
			stmt.setString(6, a.getPhone());
			stmt.setString(7, a.getAddr());
			stmt.setString(8, a.getMemo());
			stmt.setInt(9, a.getId());

			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(stmt);
			DBUtil.close(conn);
		}
	}

	public void delete(String id) {
		String sql = "delete  from admin where id= ?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			stmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(stmt);
			DBUtil.close(conn);
		}
	}

	@Override
	public List<Admin> search(String keyword) {
		// 处理空关键字情况
		String searchParam = (keyword == null || keyword.trim().isEmpty()) ? "%%" : "%" + keyword + "%";

		String sql = "SELECT * FROM admin WHERE name LIKE ? ORDER BY name";
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<Admin> list = new ArrayList<>();

		try {
			conn = DBUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, searchParam);

			rs = stmt.executeQuery();
			while (rs.next()) {
				Admin admin = new Admin();
				admin.setId(rs.getInt("id"));
				admin.setName(rs.getString("name"));
				admin.setPassword(rs.getString("password"));
				admin.setAge(rs.getInt("age"));
				admin.setSex(rs.getString("sex"));
				admin.setTel(rs.getString("tel"));
				admin.setPhone(rs.getString("phone"));
				admin.setAddr(rs.getString("addr"));
				admin.setMemo(rs.getString("memo"));
				list.add(admin);
			}
		} catch (SQLException e) {
			System.err.println("执行管理员搜索时出错: " + e.getMessage());
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
			DBUtil.close(conn);
		}

		return list;
	}

	public Admin getAdminBynp(String name, String password) {
		String sql = "select * from admin where name = ? and password = ?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Admin a = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, name);
			stmt.setString(2, password);
			rs = stmt.executeQuery();
			while (rs.next()) {
				a = new Admin();
				a.setId(rs.getInt("id"));
				a.setName(rs.getString("name"));
				a.setPassword(rs.getString("password"));
				a.setAge(rs.getInt("age"));
				a.setSex(rs.getString("sex"));
				a.setTel(rs.getString("tel"));
				a.setPhone(rs.getString("phone"));
				a.setAddr(rs.getString("addr"));
				a.setMemo(rs.getString("memo"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
			DBUtil.close(conn);
		}
		return a;
	}
}
