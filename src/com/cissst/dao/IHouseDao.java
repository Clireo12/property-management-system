package com.cissst.dao;

import java.util.List;

import com.cissst.entity.House;

public interface IHouseDao {
	List<House> getAllHouse();
	void add(House h);
	void update(House h);
	void delete(int id);

	House findById(String id);
	List<House> searchHourses(String keyword);
	List<House> getHouseByOwnerid(String oid);
}
