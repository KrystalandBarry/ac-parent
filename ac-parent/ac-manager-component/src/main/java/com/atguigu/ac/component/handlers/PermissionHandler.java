package com.atguigu.ac.component.handlers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.ac.entities.Permission;
import com.atguigu.ac.entities.ResultEntity;
import com.atguigu.ac.services.PermissionService;

@Controller
public class PermissionHandler {

	@Autowired
	private PermissionService permissionService;

	// 根据前端传入的id删除指定的permission对象
	@ResponseBody
	@RequestMapping("/permission/deletePermission.atguigu")
	public ResultEntity<String> deletePermission(@RequestParam("id") Integer id) {
		ResultEntity<String> resultEntity = new ResultEntity<>();
		try {
			permissionService.removeByPrimaryKey(id);
			resultEntity.setResult(ResultEntity.SUCCESS);
			resultEntity.setData(ResultEntity.NO_DATA);
		} catch (Exception e) {
			e.printStackTrace();
			resultEntity.setResult(ResultEntity.FAILED);
			resultEntity.setMessage(e.getMessage());

		}
		return resultEntity;
	}

	// 更新permission对象，注意：PermissionMapper.xml中的更新需要删除pid的更新，因为这里默认是不更改父节点的id
	@ResponseBody
	@RequestMapping("/permission/update.atguigu")
	public ResultEntity<String> Update(Permission permission) {
		ResultEntity<String> resultEntity = new ResultEntity<>();
		try {
			permissionService.updateByPrimaryKey(permission);
			resultEntity.setResult(ResultEntity.SUCCESS);
			resultEntity.setData(ResultEntity.NO_DATA);
		} catch (Exception e) {
			e.printStackTrace();
			resultEntity.setResult(ResultEntity.FAILED);
			resultEntity.setMessage(e.getMessage());

		}
		return resultEntity;
	}

	// 通过前端传入的id获取permission对象
	@ResponseBody
	@RequestMapping("/permission/getPermissionById.atguigu")
	public ResultEntity<Permission> getPermissionById(@RequestParam("permissionid") Integer permissionid) {
		Permission permission = permissionService.getByPrimaryKey(permissionid);

		return new ResultEntity<Permission>(ResultEntity.SUCCESS, ResultEntity.NO_MSG, permission);

	}

	// 保存permission
	@ResponseBody
	@RequestMapping("/permission/save.atguigu")
	public ResultEntity<String> savePermission(Permission permission) {
		ResultEntity<String> resultEntity = new ResultEntity<>();
		try {
			permissionService.save(permission);
			resultEntity.setResult(ResultEntity.SUCCESS);
			resultEntity.setData(ResultEntity.NO_DATA);
		} catch (Exception e) {
			e.printStackTrace();
			resultEntity.setResult(ResultEntity.FAILED);
			resultEntity.setMessage(e.getMessage());
		}
		return resultEntity;
	}

	@ResponseBody
	@RequestMapping("/permission/getTree.atguigu")
	public ResultEntity<Permission> getPermissionTree() {
		// 获取所有的permission
		List<Permission> allPermission = permissionService.getAll();
		// 定义一个变量来存放根节点
		Permission rootPermission = null;
		Map<Integer, Permission> map = new HashMap<>();
		// 遍历集合
		for (Permission permission : allPermission) {
			// 获取id
			Integer id = permission.getId();
			// 存放到map中
			map.put(id, permission);
		}
		// 再次遍历集合
		// 两次并列的不嵌套循环
		for (Permission permission : allPermission) {
			// 获取父节点id
			Integer pid = permission.getPid();
			// 如果父节点Id不存在，则代表为根节点
			if (pid == null) {
				rootPermission = permission;
			} else {
				// 不为空，则通过父节点获取子节点，并加入到父节点中
				Permission permissionParent = map.get(pid);
				permissionParent.getChildren().add(permission);
			}
		}
		return new ResultEntity<Permission>(ResultEntity.SUCCESS, ResultEntity.NO_MSG, rootPermission);
	}
}
