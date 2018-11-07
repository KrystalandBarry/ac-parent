package com.atguigu.ac.component.handlers;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.ac.entities.Permission;
import com.atguigu.ac.entities.ResultEntity;
import com.atguigu.ac.entities.Role;
import com.atguigu.ac.services.PermissionService;
import com.atguigu.ac.services.RoleService;

@Controller
public class AssignHandler {

	@Autowired
	private RoleService roleService;
	@Autowired
	private PermissionService permissionService;

	/**
	 * 显示许可的树形菜单，同时当前role拥有的许可，勾选框需被选中
	 * @param requestBodyMap	前端传入的键值对，封装到List中
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/assign/doPermissionAssign.atguigu")
	public ResultEntity<String> doPermissionAssign(@RequestBody Map<String, List<Integer>> requestBodyMap) {
		permissionService.updateRelationship(requestBodyMap);

		return new ResultEntity<String>(ResultEntity.SUCCESS, ResultEntity.NO_MSG, ResultEntity.NO_DATA);
	}

	//根据传入的roleId显示当前role拥有的许可，树形菜单显示
	@ResponseBody
	@RequestMapping("/assign/getCheckedTree.atguigu")
	public ResultEntity<Permission> getCheckTree(@RequestParam("roleId") Integer roleId) {
		Permission rootPermission = permissionService.getTreeChecked(roleId);
		return new ResultEntity<Permission>(ResultEntity.SUCCESS, ResultEntity.NO_MSG, rootPermission);
	}

	//跳转到分配许可的页面，将当前的roleId保存到request域中
	@RequestMapping("/assign/toPermissionAssignPage.html")
	public String toPermissionAssignPage(@RequestParam("roleId") Integer roleId, Model model) {
		model.addAttribute("roleId", roleId);
		return "assign/permission";
	}

	/**
	 * 更新user的role
	 * @param roleIdList	传入的表单所有role的id
	 * @param pageNo		当前页面，为了提交表单后能够跳转回当前页面
	 * @param userId		传入的u需要更新的user的userId
	 * @return
	 */
	@RequestMapping("/assign/doAssignRole.html")
	public String doAssignRole(@RequestParam(value = "assignedRoleId", required = false) List<Integer> roleIdList,
			@RequestParam("pageNo") Integer pageNo, @RequestParam("userId") Integer userId) {

		roleService.updateRelationShip(roleIdList, userId);

		return "redirect:/user/page.html?pageNo=" + pageNo;
	}

	@RequestMapping("/assign/toAssignRolePage.html")
	public String toAssignRolePage(@RequestParam("pageNo") Integer pageNo, @RequestParam("userId") Integer userId,
			Model model) {
		// 全部角色数据
		List<Role> allRoleList = roleService.getAll();

		// 已经给当前用户分配的角色的id的List
		List<Integer> roleIdList = roleService.getRoleIdListByUserId(userId);

		// 计算已分配角色List
		List<Role> assignedRoleList = new ArrayList<>();

		// 计算未分配角色List
		List<Role> unassignedRoleList = new ArrayList<>();

		for (Role role : allRoleList) {

			Integer id = role.getId();

			// 如果检测到当前角色的id是否在已分配集合中
			if (roleIdList != null && roleIdList.contains(id)) {
				// 如果在，则放入assignedRoleList
				assignedRoleList.add(role);
			} else {
				// 如果不在，则放入unassignedRoleList
				unassignedRoleList.add(role);
			}

		}

		model.addAttribute("assignedRoleList", assignedRoleList);
		model.addAttribute("unassignedRoleList", unassignedRoleList);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("userId", userId);

		return "assign/role";
	}
}
