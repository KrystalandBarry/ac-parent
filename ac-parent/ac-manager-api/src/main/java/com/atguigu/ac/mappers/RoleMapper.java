package com.atguigu.ac.mappers;

import com.atguigu.ac.entities.Role;
import com.atguigu.ac.entities.User;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface RoleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Role record);

    Role selectByPrimaryKey(Integer id);

    List<Role> selectAll();

    int updateByPrimaryKey(Role record);
    
    List<Role> selectForPage(String keyword);

	List<Role> selectRoleListByRoleIdList(@Param("roleIdList") List<Integer> roleIdList);

	void deleteRoleListByRoleIdList(@Param("roleIdList") List<Integer> roleIdList);

	List<Integer> selectRoleIdListByUserId(Integer userId);

	void deleteOldRelationship(Integer userId);

	void insertNewRelationship(@Param("roleIdList") List<Integer> roleIdList,@Param("userId") Integer userId);
}