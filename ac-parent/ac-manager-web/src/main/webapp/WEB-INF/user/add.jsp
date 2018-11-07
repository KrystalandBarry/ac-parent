<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="/WEB-INF/commons/head.jsp"%>
</head>
<script type="text/javascript" src="layer/layer.js"></script>
<script type="text/javascript">

	$(function(){
		
		//1.给表单的提交按钮绑定单击响应函数
		$("#submitBtn").click(function(){
			
			//2.收集表单项中用户填写的数据
			//$.trim()是jQuery提供的一个函数，用来去掉字符串的前后空格
			var loginacct = $.trim($("[name='loginacct']").val());
			var userpswd = $.trim($("[name='userpswd']").val());
			var confirmPsw = $.trim($("[name='confirmPsw']").val());
			var username = $.trim($("[name='username']").val());
			var email = $.trim($("[name='email']").val());

			//3.逐个进行验证
			if(loginacct == "") {
				layer.msg("登录账号不能为空！");
				return false;
			}
			if(userpswd == "") {
				layer.msg("登录密码不能为空！");
				return false;
			}
			if(confirmPsw == "") {
				layer.msg("确认密码不能为空！");
				return false;
			}
			
			//4.检查密码和确认密码是否一致
			if(userpswd != confirmPsw) {
				layer.msg("密码和确认密码必须一致");
				return false;
			}
			if(username == "") {
				layer.msg("用户名称不能为空！");
				return false;
			}
			if(email == "") {
				layer.msg("邮箱地址不能为空！");
				return false;
			}
			
		});
		
	});
	
</script>
<body>

	<%@include file="/WEB-INF/commons/navigator.jsp"%>
	<div class="container-fluid">
		<div class="row">
			<%@include file="/WEB-INF/commons/sidebar.jsp"%>

			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<!-- 每个页面的专属内容 -->

				<!-- 面包屑 -->
				<ol class="breadcrumb">
					<li><a href="user/main.html">首页</a></li>
					<li><a href="user/list.html">数据列表</a></li>
					<li class="active">新增</li>
				</ol>

				<!-- 新增表单 -->
				<div class="panel panel-default">
					<div class="panel-heading">
						表单数据
						<div style="float: right; cursor: pointer;" data-toggle="modal"
							data-target="#myModal">
							<i class="glyphicon glyphicon-question-sign"></i>
						</div>
					</div>
					<div class="panel-body">
						<form action="user/save.html" method="post" role="form">
							<div class="form-group">
								<label for="exampleInputPassword1">登录账号</label>
								<input name="loginacct"
									   type="text" 
									   class="form-control" 
									   placeholder="请输入登录账号">
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">登录密码</label>
								<input name="userpswd"
									   type="password" 
									   class="form-control" 
									   placeholder="请输入登录密码">
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">确认密码</label>
								<input name="confirmPsw"
									   type="password" 
									   class="form-control" 
									   placeholder="请确认登录密码">
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">用户名称</label>
								<input name="username"
									   type="text" 
									   class="form-control" 
									   placeholder="请输入用户名称">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">邮箱地址</label>
								<input name="email"
									   type="email" 
									   class="form-control" 
									   placeholder="请输入邮箱地址">
								<p class="help-block label label-warning">请输入合法的邮箱地址, 格式为：
									xxxx@xxxx.com</p>
							</div>
							<!-- 将表单提交按钮中的type="button"去掉，否则点这个按钮无法提交表单 -->
							<button id="submitBtn" class="btn btn-success">
								<i class="glyphicon glyphicon-plus"></i> 新增
							</button>
							<button type="button" class="btn btn-danger">
								<i class="glyphicon glyphicon-refresh"></i> 重置
							</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>