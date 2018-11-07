package com.atguigu.ac.component.handlers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.ac.entities.Permission;
import com.atguigu.ac.entities.ResultEntity;
import com.atguigu.ac.entities.User;
import com.atguigu.ac.services.PermissionService;
import com.atguigu.ac.services.UserService;
import com.atguigu.ac.utils.ACConst;

@Controller
public class UserHandler {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private PermissionService permissionService;
	
	//将当前handler方法的返回值作为响应数据，不进行视图解析
	//如果handler方法返回值是String类型，那么字符串直接作为响应数据
	//如果handler方法返回值是Map、List、实体类类型等等则会转换为JSON数据，但要求引入jackson的jar包
	@ResponseBody
	@RequestMapping("/user/doAsynLogin.atguigu")
	public ResultEntity<String> doAsynLogin(User userForm, HttpSession session) {
		
		ResultEntity<String> resultEntity = new ResultEntity<>();
		
		//1.用户账号、密码验证
		User userDB = userService.queryForLogin(userForm);
		
		if(userDB == null) {
			
			//2.在登录失败时设置ResultEntity
			resultEntity.setResult(ResultEntity.FAILED);
			resultEntity.setMessage(ACConst.MESSAGE_LOGIN_FAILED);
			resultEntity.setData(ResultEntity.NO_DATA);
			
		} else {
			
			//3.在登录成功时设置ResultEntity
			resultEntity.setResult(ResultEntity.SUCCESS);
			resultEntity.setData(ResultEntity.NO_DATA);
			session.setAttribute(ACConst.LOGIN_USER, userDB);
			
			Integer userId = userDB.getId();
			Permission permission = permissionService.getTreeByUserId(userId);
			session.setAttribute(ACConst.USER_PERMISSION_TREE, permission);

			
		}
		
		//4.将封装了结果数据的ResultEntity作为响应数据返回
		return resultEntity;
	}
	
	@RequestMapping("/user/logout.html")
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/index.html";
	}
	
	@RequestMapping("/user/doLogin.html")
	public String doLogin(User userForm, Model model, HttpSession session) {
		
		//1.查询数据库尝试从数据库中获取User对象
		User userDB = userService.queryForLogin(userForm);
		
		//2.判断userDB是否为null
		if(userDB == null) {
			
			//3.说明数据库中没有对应的记录，登录失败
			model.addAttribute(ACConst.MESSAGE_ATTR_NAME, ACConst.MESSAGE_LOGIN_FAILED);
			
			//4.转发到登录页面
			return "user/login";
			
		}
		
		//5.说明数据库中有对应的记录，登录成功
		//※注意：存入Session域的User对象必须是从数据库中取出的，不能是那个从表单获取的
		session.setAttribute(ACConst.LOGIN_USER, userDB);
		
		return "main";
	}

}
