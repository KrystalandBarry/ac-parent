<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="/WEB-INF/commons/head.jsp"%>
<link rel="stylesheet" href="css/pagination.css">
<script type="text/javascript" src="layer/layer.js"></script>
<script type="text/javascript" src="script/atcrowdfunding.js"></script>
<script type="text/javascript" src="script/jquery.pagination.js"></script>
<script type="text/javascript">
	$(function() {
		function initPagination() {
			var totalRecordNum  = ${requestScope.pageInfo.total};
			// 创建分页
			$("#Pagination").pagination(totalRecordNum, {
				num_edge_entries : 3, //边缘页数
				num_display_entries : 4, //主体页数
				callback : pageselectCallback, //在点击具体页面时调用这个函数
				items_per_page:${requestScope.pageInfo.pageSize },//每页显示的数据总量
				prev_text:"上一页",
				next_text:"下一页",
				current_page:${requestScope.pageInfo.pageNum - 1} //给Pageination指定当前页的页码
			});
		};
		
		//初始化分页代码
		initPagination();

		function pageselectCallback(page_index, jq) {
			var pageNo = page_index + 1;
			window.location.href = "${pageContext.request.contextPath}/user/page.html?pageNo="+pageNo+"&keyword=${sessionScope.KEYWORD}";
			return false;
		}
		
		
		//给单个删除按钮绑定单击响应函数
		$(".itemRemoveBtn").click(function() {

			//this代表当前被点击的按钮
			//this.id访问DOM对象的id属性
			var userId = this.id;

			//将userId存入userIdArray
			window.userIdArray = new Array();

			//将当前要删除的userId存入全局变量userIdArray
			userIdArray.push(userId);

			//显示模态框并组装表格数据
			var contextPath = "${pageContext.request.contextPath}";
			getUserListByUserIdList(userIdArray, contextPath);
		});

		//全选/全不选
		$("#summaryBox").click(function() {

			//1.获取#summaryBox自身的选中状态
			//<input id="summaryBox" type="checkbox">
			var checkStatus = this.checked;

			//2.使用jQuery选择器选中其他所有checkbox，然后统一设置checked属性
			//<input id="summaryBox" type="checkbox">
			//如果使用attr()函数，那么只能生效一次，因为这个函数不支持动态操作DOM元素
			//使用prop()函数没有这个问题
			$(".itemBox").prop("checked", checkStatus);

		});

		//点击模态框OK按钮，执行批量删除
		$("#okBtn")
				.click(
						function() {

							var userIdArray = window.userIdArray;
							var requestBody = JSON.stringify(userIdArray);

							$
									.ajax({
										"url" : "${pageContext.request.contextPath}/user/batchRemoveUser.atguigu",
										"contentType" : "application/json;charset=UTF-8",
										"type" : "POST",
										"data" : requestBody,
										"dataType" : "json",
										"success" : function(response) {
											var result = response.result;
											if (result == "SUCCESS") {

												//传入一个回调函数，回调函数会在消息显示完成后执行
												layer
														.msg(
																"删除成功！",
																function() {
																	window.location.href = "${pageContext.request.contextPath}/user/page.html?pageNo=${requestScope.pageInfo.pageNum}&keyword=${sessionScope.KEYWORD}";                                             
																});

											}
											if (result == "FAILED") {
												var message = response.message;
												layer.msg("删除失败！" + message);

												$("#confirmModal")
														.modal("hide");
											}
										}
									});

						});

		//给批量删除按钮绑定单击响应函数
		$("#batchRemoveBtn").click(
				function() {

					//创建数组对象
					//window对象代表浏览器窗口，给window对象的属性赋值，相当于给全局变量赋值
					//赋值给全局变量后，其他函数就可以使用数据了
					window.userIdArray = new Array();

					//在用户信息中收集选中的多选框
					//:checkbox选择多选框
					//:checked选择被选中的多选框
					$(".itemBox:checked").each(function() {

						//this：当前遍历得到的多选框，它是一个DOM对象
						//this.value：访问DOM对象的value属性
						var userId = this.value;

						userIdArray.push(userId);
					});

					console.log(userIdArray);

					//检测userIdArray数组长度
					if (userIdArray.length == 0) {
						layer.msg("您没有选择任何一条记录！请选择后再执行删除操作！");
						return;
					}

					getUserListByUserIdList(userIdArray,
							"${pageContext.request.contextPath}");
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
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="glyphicon glyphicon-th"></i> 数据列表
						</h3>
					</div>
					<div class="panel-body">
						<form action="user/page.html" method="post" class="form-inline"
							role="form" style="float: left;">
							<div class="form-group has-feedback">
								<div class="input-group">
									<div class="input-group-addon">查询条件</div>
									<input name="keyword" class="form-control has-success"
										type="text" placeholder="请输入查询条件">
								</div>
							</div>
							<button type="submit" class="btn btn-warning">
								<i class="glyphicon glyphicon-search"></i> 查询
							</button>
						</form>
						<button id="batchRemoveBtn" type="button" class="btn btn-danger"
							style="float: right; margin-left: 10px;">
							<i class=" glyphicon glyphicon-remove"></i> 删除
						</button>
						<a href="user/toAddPage.html" class="btn btn-primary"
							style="float: right;"> <i class="glyphicon glyphicon-plus"></i>
							新增
						</a> <br>
						<hr style="clear: both;">
						<div class="table-responsive">
							<table class="table table-bordered">
								<c:if test="${empty requestScope.pageInfo.list }">
									<tr>
										<td>没有查询到数据！</td>
									</tr>
								</c:if>
								<c:if test="${!empty requestScope.pageInfo.list }">
									<thead>
										<tr>
											<th width="30">#</th>
											<th width="30"><input id="summaryBox" type="checkbox"></th>
											<th>账号</th>
											<th>名称</th>
											<th>邮箱地址</th>
											<th width="100">操作</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${requestScope.pageInfo.list }" var="user"
											varStatus="userStatus">
											<tr>
												<!-- 为了隐藏用户id，使用迭代状态对象获取当前遍历过程中的数量值 -->
												<td>${userStatus.count }</td>
												<td><input class="itemBox" type="checkbox"
													value="${user.id }"></td>
												<td>${user.loginacct }</td>
												<td>${user.username }</td>
												<td>${user.email }</td>
												<td>
													<a href="assign/toAssignRolePage.html?userId=${user.id }&pageNo=${requestScope.pageInfo.pageNum}"
														class="btn btn-success btn-xs"> 
														<i class=" glyphicon glyphicon-check"></i>
													</a>
													<a href="user/toEditPage.html?userId=${user.id }&pageNo=${requestScope.pageInfo.pageNum}"
													class="btn btn-primary btn-xs"> <i
														class=" glyphicon glyphicon-pencil"></i>
												</a>
													<button id="${user.id }" type="button"
														class="btn btn-danger btn-xs itemRemoveBtn">
														<i class=" glyphicon glyphicon-remove"></i>
													</button>
												</td>
											</tr>
										</c:forEach>
									</tbody>
									<tfoot>
										<tr>
											<td colspan="6" align="center">
												<div id="Pagination" class="pagination">
													<!-- 这里显示分页页码导航条 -->
												</div>
											</td>
										</tr>

									</tfoot>
								</c:if>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@include file="/WEB-INF/commons/modal.jsp"%>

</body>
</html>