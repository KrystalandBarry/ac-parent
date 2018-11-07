package com.atguigu.ac.component.handlers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.ac.entities.ResultEntity;
import com.atguigu.ac.entities.User;
import com.atguigu.ac.services.UserService;
import com.atguigu.ac.utils.ACConst;
import com.github.pagehelper.PageInfo;

@Controller
public class UserCRUDHandler {
	
	@Autowired
	private UserService userService;
	
	/**
	 * 分页显示用户(整合模糊查询)
	 * @param pageNo 	当前页面 默认值为1
	 * @param keyword	关键字，默认为空字符串
	 * @param session	session域对象
	 * @param model
	 * @return
	 * 
	 * 将查询到的结果转换为PageInfo，该类封装了很多可以获取的对象
	 */
	@RequestMapping("/user/page.html")
	public String showUserPage(
			@RequestParam(value="pageNo",required=false,defaultValue="1") Integer pageNo,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
			HttpSession session,
			Model model) {
		session.setAttribute(ACConst.KEYWORD, keyword);
		List<User> userList = userService.queryForPage(pageNo,keyword);
		PageInfo<User> info = new PageInfo<>(userList);
		model.addAttribute("pageInfo", info);
		
		return "user/list";
	}
	
	/**
	 * 更新用户
	 * @param userForm 表单用户数据
	 * @param pageNo	当前页面
	 * @param session	session域对象
	 * @return			需要将pageNo和keyword作为请求参数传入请求地址
	 */
	@RequestMapping("/user/update.html")
	public String update(User userForm,@RequestParam("pageNo") Integer pageNo,HttpSession session) {
		userService.updateUser(userForm);
		//获取关键字
		String keyword = (String) session.getAttribute(ACConst.KEYWORD);
		return "redirect:/user/page.html?pageNo=" + pageNo + "&keyword=" + keyword;
	}
	
	/**
	 * 前往修改页面
	 * @param userId 通过Id查询到当前对象
	 * @param pageNo 当前页面（作为参数保存到session域对象中，页面中使用隐藏域获取当前页面pageNo）
	 * @param model
	 * @return
	 */
	@RequestMapping("/user/toEditPage.html")
	public String toEditPage(@RequestParam("userId") Integer userId,@RequestParam("pageNo") Integer pageNo,Model model) {
		User user = userService.selectUserById(userId);
		model.addAttribute("user", user);
		model.addAttribute("pageNo",pageNo);
		return "user/edit";
	}
	
	/**
	 * 通过ids删除对应的user对象
	 * @param userIdList 传入的userId数组
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/user/batchRemoveUser.atguigu")
	public ResultEntity<String> batchRemove(@RequestBody List<Integer> userIdList) {
		
		ResultEntity<String> resultEntity = new ResultEntity<>();
		
		try {
			int count = userService.batchRemove(userIdList);
			
			if(count == userIdList.size()) {
				resultEntity.setResult(ResultEntity.SUCCESS);
			}else{
				resultEntity.setResult(ResultEntity.FAILED);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resultEntity.setResult(ResultEntity.FAILED);
			resultEntity.setMessage(e.getMessage());
		}
		
		return resultEntity;
	}
	
	//@RequestBody一般用来处理前台发送的固定格式的数据如application/json或xml的数据，封装为javabean对象，一般作用于形参列表，
	//一般是前端的$.ajax请求映射到后端使用@RequestBody
	
	//@ResponseBody一般作用于方法，表示该方法的返回结果直接写入HTTP response body 中，一般在异步获取数据时使用（ajax）
	//比如异步获取json数据，加上@ResponseBody会直接返回json数据，而不会直接像@RequestMapping一样直接解析为跳转地址
	
	/**
	 * 通过ids获取对应的user对象（^_^前端发送ajax请求一般要这么处理^_^）
	 * @param userIdList 传入的userIds数组
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/user/getUserListByIdList.atguigu")
	public ResultEntity<List<User>> getUserListByIdList(@RequestBody List<Integer> userIdList) {
		
		ResultEntity<List<User>> entity = new ResultEntity<>();
		
		List<User> userList = userService.getUserListByUserIdList(userIdList);
		
		entity.setResult(ResultEntity.SUCCESS);
		entity.setData(userList);
		
		return entity;
	}
	
	//新增用户
	@RequestMapping("/user/save.html")
	public String saveUser(User user) {
		
		userService.saveUser(user);
		
		//重定向到列表显示页面，这样才能携带数据前往
		return "redirect:/user/page.html";
	}
	
}
