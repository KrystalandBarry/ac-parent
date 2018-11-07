package com.atguigu.ac.component.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.ac.entities.Role;
import com.atguigu.ac.mappers.RoleMapper;
import com.atguigu.ac.services.RoleService;
import com.atguigu.ac.utils.ACConst;
import com.github.pagehelper.PageHelper;

@Service
public class RoleServiceImpl implements RoleService{

	@Autowired
	RoleMapper roleMapper;
	
	@Override
	public int removeByPrimaryKey(Integer id) {
		return roleMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int save(Role record) {
		return roleMapper.insert(record);
	}

	@Override
	public Role getByPrimaryKey(Integer id) {
		return roleMapper.selectByPrimaryKey(id);
	}

	@Override
	public List<Role> getAll() {
		return roleMapper.selectAll();
	}

	@Override
	public int updateRole(Role record) {
		return roleMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<Role> queryForPage(Integer pageNo,String keyword) {
		PageHelper.startPage(pageNo, ACConst.PAGE_SIZE);
		keyword = "%" + keyword + "%";
		return roleMapper.selectForPage(keyword);
	}

	@Override
	public List<Role> getRoleListByRoleIdList(List<Integer> roleIdList) {
		return roleMapper.selectRoleListByRoleIdList(roleIdList);
	}

	@Override
	public void removeRoleListByRoleIdList(List<Integer> roleIdList) {
		roleMapper.deleteRoleListByRoleIdList(roleIdList);
	}

	@Override
	public List<Integer> getRoleIdListByUserId(Integer userId) {
		
		return roleMapper.selectRoleIdListByUserId(userId);
	}

	@Override
	public void updateRelationShip(List<Integer> roleIdList, Integer userId) {
		//首先根据传入的userId删除该user的所有role
		roleMapper.deleteOldRelationship(userId);
		//判断传入的roleIdList是否存在
		if (roleIdList!= null && roleIdList.size() > 0) {
			//存在，则重新把表单提交过来的所有roleId插入数据库
			roleMapper.insertNewRelationship(roleIdList,userId);
		}		
	}

	

	

}
