//给删除按钮绑定单击响应函数
function doPermissionDel(anchorEle) {
	// 显示删除模态框
	$("#permissionDelModal").modal("show");
	// 获取当前前端的id
	window.permissionid = anchorEle.id;
	// 传入前端获取的id。发送ajax请求到后端，查询permission对象
	var urlAjax = window.contextPath + "/permission/getPermissionById.atguigu";
	var param = {
		"permissionid" : window.permissionid,
		"random" : Math.random()
	};
	var callBack = function(response) {
		// 获取permission 对象
		var permission = response.data;
		// 获取permission的name
		var name = permission.name;
		// 提示删除的信息
		$("#permissionDelModalBody").empty().append("你确定要删除【" + name + "】许可吗?");
	};
	var type = "json";
	$.post(urlAjax, param, callBack, type);
}

// 给更新按钮绑定单击函数
function showPermissionEditModal(anchorEle) {
	// 显示更新模态框
	$("#permissionEditModal").modal("show");
	// 获取当前permission 的id
	window.permissionid = anchorEle.id;
	// 向后端发送Ajax请求，根据传入的id查询permission对象
	var urlAjax = window.contextPath + "/permission/getPermissionById.atguigu";
	var param = {
		"permissionid" : window.permissionid,
		"random" : Math.random()
	};
	var callBack = function(response) {
		// 获取permission对象
		var permission = response.data;
		// 得到name，icon，url
		var name = permission.name;
		var icon = permission.icon;
		var url = permission.url;

		// 回显表单
		$("#permissionEditForm [name='name']").val(name);
		$("#permissionEditForm [name='url']").val(url);
		// value=""中间不能有空格
		$("#permissionEditForm [value='" + icon + "']").attr("checked", true);
	};
	var type = "json";
	$.post(urlAjax, param, callBack, type);
}

// 给添加按钮绑定单击响应函数
function showPermissionAddModal(anchorEle) {
	// 显示添加模态框
	$("#permissionAddModal").modal("show");
	// 获取当前permission的id作为父节点Id
	window.permissionPid = anchorEle.id;
	return false;
}

function refreshTree(handlerUrl, setting) {
	// zNodes是生成树形菜单的数据
	var zNodes = null;

	// 在页面初始化时通过Ajax请求获取zNodes数据
	// var url = contextPath+"/permission/getTree.atguigu";
	var param = {
		"random" : Math.random()
	};
	var callBack = function(response) {

		// 从响应数据中获取数据菜单的数据
		var zNodes = response.data;

		// 初始化树形菜单并在页面上显示
		// <ul id="treeDemo" class="ztree"></ul>
		$.fn.zTree.init($("#treeDemo"), setting, zNodes);

	};

	var type = "json";

	// 发送Ajax请求
	$.post(handlerUrl, param, callBack, type);
}

// 批量删除的异步请求，以及模态框内的role显示
function generateRoleConfirmTable() {
	var url = window.contextPath + "/role/listByIdList.atguigu";
	$
			.ajax({
				"url" : url,
				"type" : "post",
				"data" : JSON.stringify(window.roleIdArray),
				"dataType" : "json",
				"contentType" : "application/json;charset=UTF-8",
				"success" : function(response) {
					// 获取后端发送过来的roleList对象
					var roleList = response.data;
					$("#confirmModalBody")
							.empty()
							.append("<p>请确认是否要删除以下信息：</p>")
							.append(
									"<div class='table-responsive'><table class='table table-bordered'><thead><tr><th>角色ID</th><th>角色名称</th></tr></thead><tbody></tbody></table></div>");
					// 遍历list集合，显示每一条role数据
					for (var i = 0; i < roleList.length; i++) {
						var role = roleList[i];
						var roleId = role.id;
						var roleName = role.name;
						$("#confirmModalBody tbody").append(
								"<tr><td>" + roleId + "</td><td>" + roleName
										+ "</td></tr>");
					}
				}
			});
}

// 定义全局变量
function initRoleListPage(pageNo, keyword, contextPath) {
	window.pageNo = pageNo;
	window.keyword = keyword;
	window.contextPath = contextPath;
}

// 分页显示数据的异步请求
function getRolePageAndDisplay() {
	var url = window.contextPath + "/role/page.atguigu";
	var param = {
		"pageNo" : window.pageNo,
		"keyword" : window.keyword,
		"random" : Math.random()
	};
	var callBack = function(response) {
		var result = response.result;
		if (result == "FAILED") {
			var message = response.message;
			layer.msg(message);
			return;
		}
		// 获取后端传入的roleList对象
		var pageInfo = response.data;

		// 拼接表单
		generateRolePageTBody(pageInfo);

		// 导航条显示
		initPaginationRolePage(pageInfo);

	};
	var type = "json";
	// 发送异步请求
	$.post(url, param, callBack, type);
}

// 拼接表单
function generateRolePageTBody(pageInfo) {
	var list = pageInfo.list;
	var $tBody = $("#pageTable").empty();
	if (list == null || list.length == 0) {
		$tBody.append("<tr><td colspan='4'>没有任何的数据</td></tr>");
		return;
	}

	// 遍历roleList对象，拼接<tbody></tbody>
	for (var i = 0; i < list.length; i++) {
		var role = list[i];
		var roleId = role.id;
		var roleName = role.name;

		// index
		var indexTd = "<td>" + (i + 1) + "</td>";
		// 勾选框
		var checkBoxTd = "<td><input class='itemBox' type='checkBox' value='"
				+ roleId + "'/></td>";
		// roleName
		var roleNameTd = "<td>" + roleName + "</td>";

		// 操作中的三个选项
		var checkBtn = "<button id='"+roleId+"' type='button' class='btn btn-success btn-xs roleCheckBtn'><i class=' glyphicon glyphicon-check'></i></button>";
		var editBtn = "<button id='"+roleId+"' type='button' class='btn btn-primary btn-xs roleEditBtn'><i class=' glyphicon glyphicon-pencil'></i></button>";
		var removeBtn = "<button id='"+roleId+"' type='button' class='btn btn-danger btn-xs itemRemoveBtn'><i class=' glyphicon glyphicon-remove'></i></button>";
		var operationTd = "<td>" + checkBtn + editBtn + removeBtn + "</td>";

		$tBody.append("<tr>" + indexTd + checkBoxTd + roleNameTd + operationTd
				+ "</tr>");

	}

}

// 导航条初始化
function initPaginationRolePage(pageInfo) {
	// 初始化总记录数
	var totalRecordNum = pageInfo.total;

	// 这里使用的id值要和表格中负责显示导航条的div的id一致
	$("#Pagination").pagination(totalRecordNum, {
		num_edge_entries : 1, // 边缘页数
		num_display_entries : 2, // 主体页数
		callback : pageselectCallbackRolePage, // 在点击具体每一个页码时调用这个函数
		items_per_page : pageInfo.pageSize, // 每页显示数据记录数量
		prev_text : "上一页",
		next_text : "下一页",
		current_page : pageInfo.pageNum - 1
	// 给Pagination插件指定当前页的页码
	});
};

function pageselectCallbackRolePage(page_index, jq) {
	// 通过给全局变量中的pageNo赋值，设置pageNo
	window.pageNo = page_index + 1;

	// 再次调用分页显示的方法，重新显示分页数据
	getRolePageAndDisplay();
	return false;
}

function getUserListByUserIdList(userIdArray, contextPath) {
	// 将JSON数组转换为字符串作为请求体^_^！！！
	var requestBody = JSON.stringify(userIdArray);

	$.ajax({
		"url" : contextPath + "/user/getUserListByIdList.atguigu", // 请求的目标URL地址
		"type" : "POST", // 请求方式
		"contentType" : "application/json;charset=UTF-8", // 请求体的内容类型
		"data" : requestBody, // 请求体数据
		"dataType" : "json", // 服务器返回响应数据的解析方式
		"success" : function(response) { // 服务器成功返回响应后的回调函数，response是响应体数据
			console.log(response);

			var result = response.result;

			if (result == "SUCCESS") {
				// 显示模态框
				$("#confirmModal").modal("show");

				// 从响应数据中获取UserList部分
				var userList = response.data;

				// 向#confirmModalBody中追加表格
				var $table = $("<table class='table table-bordered'></table>")
						.append("<tr><th>账号</th><th>名称</th><th>邮箱</th></tr>");
				// $table.append("<tr><td>AAA</td><td>111</td><td>!!!</td></tr>");

				for (var i = 0; i < userList.length; i++) {

					// 从数组中获取具体user对象
					var user = userList[i];

					// 从user对象中获取需要显示的数据
					var loginacct = user.loginacct;
					var username = user.username;
					var email = user.email;

					// 拼装HTML代码
					var loginacctTd = "<td>" + loginacct + "</td>";
					var usernameTd = "<td>" + username + "</td>";
					var emailTd = "<td>" + email + "</td>";

					var tr = "<tr>" + loginacctTd + usernameTd + emailTd
							+ "</tr>";

					$table.append(tr);

				}

				$("#confirmModalBody").empty().append("<p>您确定要删除下列信息吗？</p>")
						.append($table);
			}

			if (result == "FAILED") {
				layer.msg("查询User列表失败！请重试！");
			}

		}
	});
}