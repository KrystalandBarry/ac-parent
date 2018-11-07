<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">

	<head>
		<%@include file="/WEB-INF/commons/head.jsp"%>
		<link rel="stylesheet" href="css/pagination.css">
		<script type="text/javascript" src="layer/layer.js"></script>
		<script type="text/javascript" src="script/atcrowdfunding.js"></script>
		<script type="text/javascript" src="script/jquery.pagination.js"></script>
	</head>
	<script type="text/javascript">
		$(function(){
			
			
			//初始化全局变量
			initRoleListPage(1,"","${pageContext.request.contextPath}");
			
			//给后端的handler方法发送请求分页显示数据
			getRolePageAndDisplay();
			
			//给查询按钮绑定单击事件
			$("#searchBtn").click(function(){
				//获取查询条件框的内容
				window.keyword = $.trim($("#keywordInput").val());
				//分页显示查询的数据
				getRolePageAndDisplay();
			});
			
			//给新增按钮添加单击函数，显示模态框
			$("#showAddModalBtn").click(function(){
				$("#roleAddModal").modal("show");
			});
			
			//给模态框的新增按钮绑定单击函数
			$("#roleAddSubmitBtn").click(function(){
				//获取输入框的内容
				var roleName = $.trim($(":text[name='name']").val());
				
				//获取异步请求参数
				var url = "${pageContext.request.contextPath}/role/saveRole.atguigu";
				var param = {
					"roleName":roleName,
					"random":Math.random()
					
				};
				var callBack = function(response){
					//无论成功失败都将模态框隐藏
					$("#roleAddModal").modal("hide");
					var result = response.result;
					if(result == "SUCCESS"){
						layer.msg("保存成功！");
						//保存成功后回到当前页面，分页显示数据
						getRolePageAndDisplay();
					}
					if(result == "FAILED"){
						//失败抛出异常
						var message = response.message;
						layer.msg(message);
						
					}
				};
				var type = "json";
				
				//发送异步请求
				$.post(url,param,callBack,type);
			});
			
			//动态生成的页面部分，无法直接使用click绑定单击函数，需要使用on来绑定
			$("#pageTable").on("click",'.roleEditBtn',function(){
				//显示更新模态框
				$("#roleEidtModal").modal("show");
				//获取输入框的roleName
				var roleName = $(this).parents("tr").children(":eq(2)").text();
				//回显roleName
				$("#roleEditInput").val(roleName);
				//同时将得到的roleId定义为全局变量
				window.roleId = this.id;
			});
					
			//给模态框的更新按钮绑定单击函数	
			$("#roleEditSubmitBtn").click(function(){
				//获取roleId
				var roleId = window.roleId;
				//获取输入框的roleName
				var roleName = $("#roleEditInput").val();
				//准备异步请求的参数
				var url = "${pageContext.request.contextPath}/role/updateRole.atguigu";
				var param = {
					//因为后段的roleService的updateRole的参数是role对象，所以需要封装成role对象，所以参数的key要对应role的属性
					"id":roleId,
					"name":roleName,
					"random":Math.random()
				};
				var callBack = function(response){
					//无论成功失败都隐藏模态框
					$("#roleEidtModal").modal("hide");
					var result = response.result;
					if(result == "SUCCESS"){
						//成功，则调用getRolePageAndDisplay()分页显示数据
						layer.msg("更新成功！");
						getRolePageAndDisplay();
					}
					if(result == "FAILED"){
						//失败抛出异常
						var message = response.message;
						layer.msg(message);
						
					}
				};
				
				var type = "json";
				//发送异步请求
				$.post(url,param,callBack,type);
			});
			
			//全选/全不选
			$("#summaryBox").click(function(){
				$(".itemBox").prop("checked",this.checked);
			});
			
			//给批量删除按钮绑定单击响应函数
			$("#batchRemoveBtn").click(function(){
				//创建全局数组变量
				window.roleIdArray = new Array();
				//通过被选择的checkBox获取对应的roleId，并保存到全局数组变量中
				$(".itemBox:checked").each(function(){
					window.roleIdArray.push(this.value);
				});
				//如果没有选择，则发出提示消息
				if(window.roleIdArray.length == 0){
					layer.msg("没有选择任何一条数据，请重试！");
					return ;
				}
				//显示模态框
				$("#confirmModal").modal("show");
				//发送异步请求
				generateRoleConfirmTable();
			});
			
			//给删除模态框的删除按钮绑定单击函数
			$("#okBtn").click(function(){
				//发送异步请求
				$.ajax({
					"url":window.contextPath+"/role/removeByIdList.atguigu",
					"type":"post",
					"data":JSON.stringify(window.roleIdArray),
					"dataType":"json",
					"contentType":"application/json;charset=UTF-8",
					"success":function(response){
						var result = response.result;
						if(result == "SUCCESS"){
							layer.msg("删除成功");
							getRolePageAndDisplay();
						}
						if(result == "FAILED"){
							layer.msg(response.message);
						}
						$("#confirmModal").modal("hide");
					}
				})
			});
			
			//给单个删除按钮绑定单击函数
			$("#pageTable").on("click",'.roleRemoveBtn',function(){
				window.roleIdArray = new Array();
				window.roleIdArray.push(this.id);
				$("#confirmModal").modal("show");
				generateRoleConfirmTable();
			})
			
			//给动态生成的按钮组中的分配按钮绑定单击响应函数
			$("#pageTable").on("click",".roleCheckBtn",function(){
				var roleId = this.id;
				window.location.href = "${pageContext.request.contextPath}/assign/toPermissionAssignPage.html?roleId="+roleId;
			});
			
			
			
		})
	</script>
	<style>
		.tree li {
			list-style-type: none;
			cursor: pointer;
		}
		
		table tbody tr:nth-child(odd) {
			background: #F4F4F4;
		}
		
		table tbody td:nth-child(even) {
			color: #C00;
		}
	</style>

	<body>

		<%@include file="/WEB-INF/commons/navigator.jsp"%>
		<div class="container-fluid">
			<div class="row">
				<%@include file="/WEB-INF/commons/sidebar.jsp"%>

				<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
					<!-- 每个页面的专属内容 -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
							<i class="glyphicon glyphicon-th"></i> 数据列表
						</h3>
						</div>
						<div class="panel-body">
							<form class="form-inline" role="form" style="float: left;">
								<div class="form-group has-feedback">
									<div class="input-group">
										<div class="input-group-addon">查询条件</div>
										<input id="keywordInput" class="form-control has-success" type="text" placeholder="请输入查询条件">
									</div>
								</div>
								<button id="searchBtn" type="button" class="btn btn-warning">
									<i class="glyphicon glyphicon-search"></i> 查询
								</button>
							</form>
							<button id="batchRemoveBtn" type="button" class="btn btn-danger" style="float: right; margin-left: 10px;">
								<i class=" glyphicon glyphicon-remove"></i> 删除
							</button>
							<button id="showAddModalBtn" type="button" class="btn btn-primary" style="float: right;">
								<i class="glyphicon glyphicon-plus"></i> 新增
							</button>
							<br>
							<hr style="clear: both;">
							<div class="table-responsive">
								<table class='table table-bordered'>
									<thead>
										<tr>
											<th width='30'>#</th>
											<th width='30'><input id="summaryBox" type='checkbox'></th>
											<th>名称</th>
											<th width='100'>操作</th>
										</tr>
									</thead>
									<tbody id="pageTable">
										
									</tbody>
									<tfoot>
										<tr>
											<td colspan='4' align='center'>
												<div id='Pagination' class='pagination'>
													<!-- 这里显示分页页码导航条 -->
												</div>
											</td>
										</tr>
									</tfoot>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<%@include file="/WEB-INF/commons/modal_role_add.jsp" %>
		<%@include file="/WEB-INF/commons/modal_role_edit.jsp" %>
		<%@include file="/WEB-INF/commons/modal.jsp" %>
		

	</body>

</html>