package com.cissst.service;

import java.util.List;

import com.cissst.entity.Maintain;

public interface IMaintainService {
	List<Maintain> findAllMaintains();
	void save(Maintain a); 
	
	Maintain findById(String id);
	List<Maintain> findByMaintainer(String maintainer);
	
	void update(Maintain a);
	
	void delete(String id);
	List<Maintain> searchMaintainsByUser(String username, String keyword);
	
	
	List<Maintain> searchMaintains(String keyword);

}
