package com.atguigu.ac.services;

import java.util.List;

import com.atguigu.ac.entities.Role;

public interface RoleService {

	int removeByPrimaryKey(Integer id);

	int save(Role record);

	Role getByPrimaryKey(Integer id);

	List<Role> getAll();

	int updateRole(Role record);

	List<Role> queryForPage(Integer pageNo,String keyword);

	List<Role> getRoleListByRoleIdList(List<Integer> roleIdList);

	void removeRoleListByRoleIdList(List<Integer> roleIdList);

	List<Integer> getRoleIdListByUserId(Integer userId);

	void updateRelationShip(List<Integer> roleIdList, Integer userId);
}
