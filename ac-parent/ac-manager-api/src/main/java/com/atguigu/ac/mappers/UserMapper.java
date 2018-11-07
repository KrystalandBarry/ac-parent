package com.atguigu.ac.mappers;

import com.atguigu.ac.entities.User;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface UserMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(User record);

	User selectByPrimaryKey(Integer id);

	List<User> selectAll();

	int updateByPrimaryKey(User record);

	User selectForLogin(User userForm);

	List<User> selectUserListByUserIdList(@Param("userIdList") List<Integer> userIdList);

	int batchDeleteUser(@Param("userIdList") List<Integer> userIdList);


	User selectUserByAcct(String loginacct);

	List<User> selectForSearch(String keyword);

	int selectLoginAcctCount(String loginacct);
}