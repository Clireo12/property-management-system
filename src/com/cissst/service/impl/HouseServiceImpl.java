package com.cissst.service.impl;

import java.util.List;

import com.cissst.dao.IHouseDao;
import com.cissst.dao.impl.HouseDaoImpl;
import com.cissst.entity.House;
import com.cissst.service.IHouseService;

public class HouseServiceImpl implements IHouseService{
	IHouseDao hdao=new HouseDaoImpl();
	public List<House> findAllHouse() {
		List<House> list =hdao.getAllHouse();
		return list;
	}
	public void add(House h) {
		hdao.add(h);
	}

	@Override
	public void delete(String id) {
	    try {
	        int houseId = Integer.parseInt(id);
	        hdao.delete(houseId);
	    } catch (NumberFormatException e) {
	        System.err.println("无效的房产ID格式: " + id);
	        throw new IllegalArgumentException("无效的房产ID", e);
	    } catch (Exception e) {
	        System.err.println("删除房产信息失败: " + e.getMessage());
	        throw new RuntimeException("删除房产信息失败", e);
	    }
	}
	
	@Override
	public void update(House h) {
	    try {
	        hdao.update(h);
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new RuntimeException("更新房产信息失败", e);
	    }
	}

	public House findById(String id) {
		return hdao.findById(id);
	}
	
	public List<House> searchHouses(String keyword) {
		System.out.print("HouseServiceImpl"+keyword);
		List<House> list =hdao.searchHourses(keyword);
		return list;
	}
	@Override
	public List<House> findByOwnerid(String oid) {
		List list =hdao.getHouseByOwnerid(oid);
		return list;
	}
	
}
