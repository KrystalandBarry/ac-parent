<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="/WEB-INF/commons/head.jsp"%>
<script type="text/javascript">
	
	$(function(){
		//点击图标，右移role
		$("#toRight").click(function(){
			$("select:eq(0)>:selected").appendTo("select:eq(1)");
		});
		//点击图标，左移role
		$("#toLeft").click(function(){
			$("select:eq(1)>:selected").appendTo("select:eq(0)");
		});
		//点击分配按钮，选中右边所有的选项提交表单
		$("#submitBtn").click(function(){
			$("select:eq(1)>option").each(function(){
				this.selected = "selected";
			});
		});
	});
	
</script>
</head>

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
					<li><a href="user/page.html">数据列表</a></li>
					<li class="active">分配角色</li>
				</ol>
				<div class="panel panel-default">
					<div class="panel-body">
						<form action="assign/doAssignRole.html" method="post" role="form" class="form-inline">
						<!-- 后端传入的当前页面pageNo和userId，作为隐藏域 -->
							<input type="hidden" name="pageNo" value="${requestScope.pageNo }"/>
							<input type="hidden" name="userId" value="${requestScope.userId }"/>
							<div class="form-group">
								<label for="exampleInputPassword1">未分配角色列表</label><br>
								<select
									class="form-control" 
									multiple 
									size="10"
									style="width: 100px; overflow-y: auto;">
									<c:forEach items="${requestScope.unassignedRoleList }" var="role">
										<option value="${role.id }">${role.name }</option>
									</c:forEach>
								</select>
							</div>
							<div class="form-group">
								<ul>
									<li id="toRight" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
									<br/>
									<li id="toLeft" class="btn btn-default glyphicon glyphicon-chevron-left"
										style="margin-top: 20px;"></li>
								</ul>
							</div>
							<div class="form-group" style="margin-left: 40px;">
								<label for="exampleInputPassword1">已分配角色列表</label><br>
								<select
									name="assignedRoleId"
									class="form-control" multiple size="10"
									style="width: 100px; overflow-y: auto;">
									<c:forEach items="${requestScope.assignedRoleList }" var="role">
										<option value="${role.id }">${role.name }</option>
									</c:forEach>
								</select>
							</div>
							<br/>
							<br/>
							<button id="submitBtn" type="submit" id="assignBtn" class="btn btn-success">
								<i class="glyphicon glyphicon-pencil"></i> 分配
							</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>