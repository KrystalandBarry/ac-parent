package com.atguigu.ac.component.services;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.ac.entities.Permission;
import com.atguigu.ac.mappers.PermissionMapper;
import com.atguigu.ac.services.PermissionService;

@Service
public class PermissionServiceImpl implements PermissionService {

	@Autowired
	PermissionMapper permissionMapper;

	@Override
	public int removeByPrimaryKey(Integer id) {
		return permissionMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int save(Permission record) {
		return permissionMapper.insert(record);
	}

	@Override
	public Permission getByPrimaryKey(Integer id) {
		return permissionMapper.selectByPrimaryKey(id);
	}

	@Override
	public List<Permission> getAll() {
		return permissionMapper.selectAll();
	}

	@Override
	public int updateByPrimaryKey(Permission record) {
		return permissionMapper.updateByPrimaryKey(record);
	}

	// 树形菜单的相关显示
	@Override
	public Permission getTreeChecked(Integer roleId) {
		List<Integer> permissionIdList = permissionMapper.selectPermissionIdByRoleId(roleId);

		List<Permission> allPermission = permissionMapper.selectAll();
		Permission rootPermission = null;
		Map<Integer, Permission> permissionMap = new HashMap<>();
		for (Permission permission : allPermission) {
			Integer id = permission.getId();
			permissionMap.put(id, permission);
		}
		for (Permission permission : allPermission) {
			Integer pid = permission.getPid();
			if (pid == null) {
				rootPermission = permission;
			} else {
				Permission permissionParent = permissionMap.get(pid);
				permissionParent.getChildren().add(permission);
			}
			Integer id = permission.getId();

			// 设置树形菜单前面的勾选框选中
			if (permissionIdList != null && permissionIdList.size() > 0 && permissionIdList.contains(id)) {
				permission.setChecked(true);
			}
		}
		return rootPermission;
	}

	@Override
	public void updateRelationship(Map<String, List<Integer>> requestBodyMap) {
		// 首先拿到前端传入的roleId
		Integer roleId = requestBodyMap.get("roleId").get(0);
		// 根据roleId删除该role的所有许可
		permissionMapper.deleteRelationshipByRoleId(roleId);
		// 然后拿到重新分配许可后的所有许可permissionIdList
		List<Integer> permissionIdList = requestBodyMap.get("permissionIdArr");
		if (permissionIdList != null && permissionIdList.size() > 0) {
			// 重新分配role的许可permission
			permissionMapper.insertRelationship(roleId, permissionIdList);
		}
	}

	@Override
	public Permission getTreeByUserId(Integer userId) {
		// 1.根据userId查询对应的Permission的List
		List<Permission> list = permissionMapper.selectTreeByUserId(userId);

		// 2.组装树形结构
		Permission rootPermission = null;

		Map<Integer, Permission> permissionMap = new HashMap<>();

		for (Permission permission : list) {
			Integer id = permission.getId();
			permissionMap.put(id, permission);
		}

		for (Permission permission : list) {

			Integer pid = permission.getPid();

			if (pid == null) {
				rootPermission = permission;
			} else {
				Permission parent = permissionMap.get(pid);
				parent.getChildren().add(permission);
			}

		}

		return rootPermission;

	}

}
