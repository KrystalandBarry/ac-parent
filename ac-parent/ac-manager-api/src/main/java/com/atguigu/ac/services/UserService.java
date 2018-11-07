package com.atguigu.ac.services;

import java.util.List;

import com.atguigu.ac.entities.Role;
import com.atguigu.ac.entities.User;

public interface UserService {

	User queryForLogin(User userForm);

	List<User> getAll();

	void saveUser(User user);

	List<User> getUserListByUserIdList(List<Integer> userIdList);

	int batchRemove(List<Integer> userIdList);

	User selectUserById(Integer userId);

	void updateUser(User userForm);

	List<User> queryForPage(Integer pageNo);

	List<User> queryForPage(Integer pageNo, String keyword);
	
	

}
