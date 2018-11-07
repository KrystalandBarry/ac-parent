package com.atguigu.ac.mappers;

import com.atguigu.ac.entities.Permission;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface PermissionMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Permission record);

    Permission selectByPrimaryKey(Integer id);

    List<Permission> selectAll();

    int updateByPrimaryKey(Permission record);

	List<Integer> selectPermissionIdByRoleId(Integer roleId);

	void deleteRelationshipByRoleId(Integer id);

	void insertRelationship(@Param("roleId") Integer roleId,@Param("permissionIdList") List<Integer> permissionIdList);
	
	List<Permission> selectTreeByUserId(Integer userId);
}