<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="/WEB-INF/commons/head.jsp"%>
</head>

<body>

	<%@include file="/WEB-INF/commons/navigator.jsp"%>
	<div class="container-fluid">
		<div class="row">
			<%@include file="/WEB-INF/commons/sidebar.jsp"%>

			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

				<!-- 面包屑 -->
				<ol class="breadcrumb">
					<li><a href="user/main.html">首页</a></li>
					<li><a href="user/page.html">数据列表</a></li>
					<li class="active">修改</li>
				</ol>
				<!-- 每个页面的专属内容 -->
				<div class="panel panel-default">
					<div class="panel-heading">
						表单数据
						<div style="float: right; cursor: pointer;" data-toggle="modal"
							data-target="#myModal">
							<i class="glyphicon glyphicon-question-sign"></i>
						</div>
					</div>
					<div class="panel-body">
						<form:form action="user/update.html" method="post"
							modelAttribute="user">
							<!-- SpringMVC表单标签的path属性相当于HTML标签的name属性 -->
							<form:hidden path="id" />

							<!-- 对于pageNo这样不属于模型对象的属性，不能使用SpringMVC标签 -->
							<%-- <form:hidden path="pageNo"/> --%>
							<input type="hidden" name="pageNo"
								value="${requestScope.pageNo }" />

							<div class="form-group">
								<label for="exampleInputPassword1">登录账号</label>
								<form:input path="loginacct" cssClass="form-control" />
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">用户名称</label>
								<form:input path="username" cssClass="form-control" />
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">邮箱地址</label>
								<form:input path="email" cssClass="form-control" />
							</div>
							<button type="submit" class="btn btn-success">
								<i class="glyphicon glyphicon-edit"></i> 修改
							</button>
							<button type="reset" class="btn btn-danger">
								<i class="glyphicon glyphicon-refresh"></i> 重置
							</button>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>