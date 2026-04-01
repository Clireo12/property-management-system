package com.cissst.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cissst.dao.IHouseDao;
import com.cissst.entity.House;
import com.cissst.util.DBUtil;

public class HouseDaoImpl implements IHouseDao {

	public List<House> getAllHouse() {

		String sql = "select * from house order by dep";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;

		List<House> list = new ArrayList<House>();
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while (rs.next()) {
				House h = new House();
				h.setId(rs.getInt("id"));
				h.setNum(rs.getString("num"));
				h.setDep(rs.getString("dep"));
				h.setKind(rs.getString("kind"));
				h.setArea(rs.getString("area"));
				h.setSell(rs.getString("sell"));
				h.setUnit(rs.getString("unit"));
				h.setFloor(rs.getString("floor"));
				h.setDirection(rs.getString("direction"));
				h.setMemo(rs.getString("memo"));
				h.setOwnerid(rs.getString("ownerid"));
				list.add(h);
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


	public void add(House h) {
	    System.out.println("add - 准备添加房产: " + h); // 使用 println 确保完整输出
	    
	    String sql = "insert into house(num,dep,kind,area,sell,unit,floor,direction,memo,ownerid) " +
	                 "values(?,?,?,?,?,?,?,?,?,?)";
	    
	    Connection conn = DBUtil.getConnection();
	    PreparedStatement stmt = null;
	    
	    try {
	        stmt = conn.prepareStatement(sql);
	        stmt.setString(1, h.getNum());
	        stmt.setString(2, h.getDep());
	        stmt.setString(3, h.getKind());
	        stmt.setString(4, h.getArea());
	        stmt.setString(5, h.getSell());
	        stmt.setString(6, h.getUnit());
	        stmt.setString(7, h.getFloor()); // 修改为 setInt，与数据库字段类型匹配
	        stmt.setString(8, h.getDirection());
	        stmt.setString(9, h.getMemo());
	        stmt.setString(10, h.getOwnerid());
	        
	        int rows = stmt.executeUpdate();
	        System.out.println("add - 成功插入 " + rows + " 条记录");
	        
	    } catch (SQLException e) {
	        System.err.println("add - SQL执行异常: " + e.getMessage());
	        e.printStackTrace();
	    } finally {
	        DBUtil.close(stmt);
	        DBUtil.close(conn);
	    }
	}
	public void update(House h) {
		String sql = "update house set " +
	             "num=?, dep=?, kind=?, area=?, sell=?, " +
	             "unit=?, floor=?, direction=?, memo=? ownerid=?" +
	             "where id = ?";

		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, h.getNum());
			stmt.setString(2, h.getDep());
			stmt.setString(3, h.getKind());
			stmt.setString(4, h.getArea());
			stmt.setString(5, h.getSell());
			stmt.setString(6, h.getUnit());
			stmt.setString(7, h.getFloor());
			stmt.setString(8, h.getDirection());
			stmt.setString(9, h.getMemo());
			stmt.setString(10, h.getOwnerid());
			stmt.setInt(11, h.getId()); // 条件ID（最后一个参数）
			stmt.executeUpdate();
			
		} catch (SQLException e) {
			System.err.println("更新房产信息失败: " + e.getMessage());
			e.printStackTrace();
		} finally {
			DBUtil.close(stmt);
			DBUtil.close(conn);
		}
	}

	@Override
	public void delete(int id) {
		String sql = "DELETE FROM house WHERE id = ?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;

		try {
	        stmt = conn.prepareStatement(sql);
	        stmt.setInt(1, id);
	        int affectedRows = stmt.executeUpdate();
	        if (affectedRows == 0) {
	            throw new RuntimeException("No house found with ID: " + id);
	        }
	    } catch (SQLException e) {
	        if (e.getSQLState().equals("23000")) { // Foreign key constraint
	            throw new RuntimeException("Cannot delete house: related records exist", e);
	        }
	        throw new RuntimeException("Delete failed", e);
	    } finally {
	        DBUtil.close(stmt);
	        DBUtil.close(conn);
	    }
	}

	public House findById(String id) {
		String sql = "select * from house where id = ?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		House h = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			rs = stmt.executeQuery();
			while (rs.next()) {
				h = new House();
				h.setId(rs.getInt("id"));
				h.setNum(rs.getString("num"));
				h.setDep(rs.getString("dep"));
				h.setKind(rs.getString("kind"));
				h.setArea(rs.getString("area"));
				h.setSell(rs.getString("sell"));
				h.setUnit(rs.getString("unit"));
				h.setFloor(rs.getString("floor"));
				h.setDirection(rs.getString("direction"));
				h.setMemo(rs.getString("memo"));
				h.setOwnerid(rs.getString("ownerid"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
			DBUtil.close(conn);
		}
		return h;
	}

	@Override
	public List<House> searchHourses(String keyword) {
		System.out.println("搜索关键字: " + keyword); // 改用 println 方便调试
	    
	    String sql = "SELECT * FROM house WHERE num LIKE ? OR dep LIKE ? OR memo LIKE ?";

	    Connection conn = DBUtil.getConnection();
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    List<House> list = new ArrayList<>();

	    try {
	        stmt = conn.prepareStatement(sql);
	        String searchPattern = "%" + keyword + "%"; // 模糊匹配（如 `%北京%`）
	        stmt.setString(1, searchPattern); // 对应 num LIKE ?
	        stmt.setString(2, searchPattern); // 对应 dep LIKE ?
	        stmt.setString(3, searchPattern); // 对应 memo LIKE ?
	        

	        rs = stmt.executeQuery();
	        while (rs.next()) {
	            House h = new House();
	            h.setId(rs.getInt("id"));
	            h.setNum(rs.getString("num"));
	            h.setDep(rs.getString("dep"));
	            h.setKind(rs.getString("kind"));
	            h.setArea(rs.getString("area"));
	            h.setSell(rs.getString("sell"));
	            h.setUnit(rs.getString("unit"));
	            h.setFloor(rs.getString("floor"));
	            h.setDirection(rs.getString("direction"));
	            h.setMemo(rs.getString("memo"));
	            h.setOwnerid(rs.getString("ownerid"));
	            list.add(h);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        DBUtil.close(rs);
	        DBUtil.close(stmt);
	        DBUtil.close(conn);
	    }
	    
	    System.out.println("查询结果数量: " + list.size()); // 打印结果数量
	    return list;
	}
	
	public List<House> getHouseByOwnerid(String oid) {
		String sql = "select * from house where ownerid = ?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;

		List list = new ArrayList();
		House h;
		try {
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, oid);
		rs = stmt.executeQuery();
		while(rs.next()){
		h = new House();
		h.setId(rs.getInt("id"));
		h.setNum(rs.getString("num"));
		h.setDep(rs.getString("dep"));
		h.setKind(rs.getString("kind"));
		h.setArea(rs.getString("area"));
		h.setSell(rs.getString("sell"));
		h.setUnit(rs.getString("unit"));
		h.setFloor(rs.getString("floor"));
		h.setDirection(rs.getString("direction"));
		h.setMemo(rs.getString("memo"));
		h.setOwnerid(rs.getString("ownerid"));
		list.add(h);
		}

		} catch (SQLException e) {
		e.printStackTrace();
		} finally{
		DBUtil.close(rs);
		DBUtil.close(stmt);
		DBUtil.close(conn);
		}
		return list;
		}

}
