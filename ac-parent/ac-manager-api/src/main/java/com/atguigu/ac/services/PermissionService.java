package com.atguigu.ac.services;

import java.util.List;
import java.util.Map;

import com.atguigu.ac.entities.Permission;

public interface PermissionService {
	
	Permission getTreeByUserId(Integer userId);
	
	int removeByPrimaryKey(Integer id);

    int save(Permission record);

    Permission getByPrimaryKey(Integer id);

    List<Permission> getAll();

    int updateByPrimaryKey(Permission record);

	Permission getTreeChecked(Integer roleId);

	void updateRelationship(Map<String, List<Integer>> requestBodyMap);

}
