package com.atguigu.ac.component.handlers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.atguigu.ac.entities.ResultEntity;
import com.atguigu.ac.entities.Role;
import com.atguigu.ac.services.RoleService;
import com.github.pagehelper.PageInfo;

@RestController
public class RoleHandler {

	@Autowired
	private RoleService roleService;

	/**
	 * 分页显示数据
	 * @param pageNo	当前页面，默认值为1
	 * @param keyword 	关键字，默认值为空字符串
	 * @return
	 */
	@RequestMapping("/role/page.atguigu")
	public ResultEntity<PageInfo<Role>> queryForPageByKeyword(
			@RequestParam(value = "pageNo", defaultValue = "1") Integer pageNo,
			@RequestParam(value = "keyword", defaultValue = "") String keyword) {
		ResultEntity<PageInfo<Role>> resultEntity = new ResultEntity<>();
		try {
			//通过关键字查询roleList对象
			List<Role> list = roleService.queryForPage(pageNo, keyword);
			//封装到PageInfo对象中
			PageInfo<Role> info = new PageInfo<>(list);
			
			resultEntity.setResult(ResultEntity.SUCCESS);
			resultEntity.setData(info);
		} catch (Exception e) {
			e.printStackTrace();
			resultEntity.setResult(ResultEntity.FAILED);
			resultEntity.setMessage(e.getMessage());
		}
		return resultEntity;
	}

	/**
	 * 新增用户
	 * @param roleName	传入前端输入的roleName
	 * @return
	 */
	@RequestMapping("/role/saveRole.atguigu")
	public ResultEntity<String> saveRole(@RequestParam("roleName") String roleName) {
		ResultEntity<String> resultEntity = new ResultEntity<>();
		try {
			roleService.save(new Role(null, roleName));
			resultEntity.setResult(ResultEntity.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			resultEntity.setResult(ResultEntity.FAILED);
			resultEntity.setMessage(e.getMessage());
		}
		return resultEntity;
	}

	/**
	 * 更新用户
	 * @param role
	 * @return
	 */
	@RequestMapping("/role/updateRole.atguigu")
	public ResultEntity<String> updateRole(Role role) {
		ResultEntity<String> resultEntity = new ResultEntity<>();
		try {
			roleService.updateRole(role);
			resultEntity.setResult(ResultEntity.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			resultEntity.setResult(ResultEntity.FAILED);
			resultEntity.setMessage(e.getMessage());
		}
		return resultEntity;
	}

	/**
	 * 通过roleIdList的值查询role对象
	 * @param roleIdList	前端页面传入的roleIdList数组的值
	 * @return
	 */
	@RequestMapping("/role/listByIdList.atguigu")
	public ResultEntity<List<Role>> getRoleByIds(@RequestBody List<Integer> roleIdList) {
		ResultEntity<List<Role>> resultEntity = new ResultEntity<>();

		try {

			List<Role> roleList = roleService.getRoleListByRoleIdList(roleIdList);
			resultEntity.setData(roleList);

			resultEntity.setResult(ResultEntity.SUCCESS);

		} catch (Exception e) {
			e.printStackTrace();
			resultEntity.setResult(ResultEntity.FAILED);
			resultEntity.setMessage(e.getMessage());
		}

		return resultEntity;
	}
	
	/**
	 * 批量删除role对象
	 * @param roleIdList 前端传入的roleIdList数组的值
	 * @return
	 * 
	 * @RequestBody	一般用于处理前端发送的固定格式的数据如application/json或xml数据
	 */
	@RequestMapping("/role/removeByIdList.atguigu")
	public ResultEntity<String> removeRoleByRoleIdList(@RequestBody List<Integer> roleIdList){
		ResultEntity<String> resultEntity = new ResultEntity<>();
		try {
			roleService.removeRoleListByRoleIdList(roleIdList);
			resultEntity.setResult(ResultEntity.SUCCESS);
			resultEntity.setData(ResultEntity.NO_DATA);
		} catch (Exception e) {
			e.printStackTrace();
			resultEntity.setResult(ResultEntity.FAILED);
			resultEntity.setMessage(e.getMessage());
		}
		return resultEntity;
	}
}









