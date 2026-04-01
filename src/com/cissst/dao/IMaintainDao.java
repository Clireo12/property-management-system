package com.cissst.dao;

import java.util.List;

import com.cissst.entity.Maintain;

public interface IMaintainDao {
	List<Maintain> getAllMaintain();
	void save(Maintain a); 
	Maintain getMaintainById(String id);
	List<Maintain> getMaintainByMaintainer(String maintainer);
	void update(Maintain a);
	void delete(String id);
	List<Maintain> searchByUser(String username, String keyword);
	List<Maintain> searchMaintainsByUser(String maintainer, String keyword);
	List<Maintain> searchMaintains(String keyword);
}
