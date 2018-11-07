package com.atguigu.ac.component.services;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.management.RuntimeErrorException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.ac.entities.Role;
import com.atguigu.ac.entities.User;
import com.atguigu.ac.mappers.UserMapper;
import com.atguigu.ac.services.UserService;
import com.atguigu.ac.utils.ACConst;
import com.atguigu.ac.utils.StringUtils;
import com.github.pagehelper.PageHelper;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper;

	@Override
	public User queryForLogin(User userForm) {

		// 先执行加密，然后执行数据库查询
		String userpswd = userForm.getUserpswd();
		userpswd = StringUtils.md5(userpswd);
		userForm.setUserpswd(userpswd);

		// 根据密文查询数据库
		return userMapper.selectForLogin(userForm);
	}

	@Override
	public List<User> getAll() {
		return userMapper.selectAll();
	}

	@Override
	public void saveUser(User user) {
		// 1.保存user时先判断用户是否在数据库中存在
		String loginacct = user.getLoginacct();
		int count = userMapper.selectLoginAcctCount(loginacct);
		if(count > 0) {
			throw new RuntimeException(ACConst.MESSAGE_LOGIN_ACCT_ALREADY_EXISTS);
		}
		// 2.创建日期对象，作为用户的创建时间数据
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String createtime = format.format(date);

		// 3.将createtime设置到User对象中
		user.setCreatetime(createtime);

		// 4.将用户密码加密后存入数据库
		String userpswd = user.getUserpswd();
		String md5 = StringUtils.md5(userpswd);
		user.setUserpswd(md5);

		// 5.执行保存操作
		userMapper.insert(user);

	}

	@Override
	public List<User> getUserListByUserIdList(List<Integer> userIdList) {
		return userMapper.selectUserListByUserIdList(userIdList);
	}

	@Override
	public int batchRemove(List<Integer> userIdList) {
		return userMapper.batchDeleteUser(userIdList);
	}

	@Override
	public User selectUserById(Integer userId) {
		return userMapper.selectByPrimaryKey(userId);
	}

	@Override
	public void updateUser(User userForm) {
		// 1.从userForm中获取id和loginacct
		Integer id = userForm.getId();
		String loginacct = userForm.getLoginacct();

		// 2.根据loginacct查询User对象
		User userDB = userMapper.selectUserByAcct(loginacct);

		// 3.在userDB不为null且userDB的id和userForm的id不一致的情况下不能更新
		if (userDB != null && !userDB.getId().equals(id)) {
			throw new RuntimeException(ACConst.MESSAGE_LOGIN_ACCT_ALREADY_EXISTS);
		}

		// 4.其他情况可以更新
		userMapper.updateByPrimaryKey(userForm);

	}

	//使用PageHelper分页
	@Override
	public List<User> queryForPage(Integer pageNo) {
		PageHelper.startPage(pageNo, ACConst.PAGE_SIZE);
		return userMapper.selectAll();
	}

	//整合模糊查询的分页查询数据库user对象
	@Override
	public List<User> queryForPage(Integer pageNo, String keyword) {
		PageHelper.startPage(pageNo, ACConst.PAGE_SIZE);
		keyword = "%" + keyword + "%";
		return userMapper.selectForSearch(keyword);
	}

	

}
