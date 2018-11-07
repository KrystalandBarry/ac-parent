<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="/WEB-INF/commons/head.jsp"%>
<link rel="stylesheet" href="ztree/zTreeStyle.css" />
<script type="text/javascript" src="script/atcrowdfunding.js"></script>
<script type="text/javascript" src="layer/layer.js"></script>
<script type="text/javascript" src="ztree/jquery.ztree.all-3.5.min.js"></script>
</head>
<script type="text/javascript">
	window.contextPath = "${pageContext.request.contextPath}";

	$(function() {

		//树形菜单的相关设置
		var setting = {
				view : {
					addDiyDom : function(treeId, treeNode) {
						var iconId = treeNode.tId + "_ico";
						var iconObj = $("#" + iconId);
						if(treeNode.icon) {
							iconObj
								.removeClass("button ico_docu ico_open")
								.addClass(treeNode.icon)
								.css("background","");
						}
					}
				},
				check: {
					//让树形菜单节点前有多选框
					enable: true
				},
				data : {
					key : {
						url : "noExists"
					}
				}
			};
			//显示树形菜单
			refreshTree(window.contextPath+"/assign/getCheckedTree.atguigu?roleId=${requestScope.roleId}", setting);
			
			//给分配许可按钮绑定单击响应函数，发送ajax请求
			$("#checkPermission").click(function(){
				var roleId = "${requestScope.roleId}";

				//调用zTree提供的方法获取被勾选的节点，传入id时不加#
				var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
				var nodes = treeObj.getCheckedNodes(true);
				
				//因为传递的参数是"roleId，[permissionId1,permissionId2,permissionId3...]"的形式
				//我们用数组进行接收，（roleId也封装成数组的形式）
				var permissionIdArr = new Array();
				for(var i = 0; i < nodes.length; i ++){
					var node = nodes[i];
					var permissionId = node.id;
					permissionIdArr.push(permissionId);
				}
				var roleIdArr = new Array();
				roleIdArr.push(roleId);
				
				var requestBody = {
					"roleId":roleIdArr,
					"permissionIdArr":permissionIdArr
				};
				
				$.ajax({
					"url":window.contextPath+"/assign/doPermissionAssign.atguigu",
					"type":"post",
					"data":JSON.stringify(requestBody),
					"contentType":"application/json;charset=UTF-8",
					"dataType":"json",
					"success":function(response){
						var result = response.result;
						if(result == "SUCCESS") {
							layer.msg("操作成功！");
						}else{
							layer.msg("操作失败！"+response.message);
						}
					}
				});
			});
			
	});
</script>
<body>
	${requestScope.roleId }
	<%@include file="/WEB-INF/commons/navigator.jsp"%>
	<div class="container-fluid">
		<div class="row">
			<%@include file="/WEB-INF/commons/sidebar.jsp"%>

			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<!-- 每个页面的专属内容 -->
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="glyphicon glyphicon-th-list"></i> 权限分配列表
						<div style="float: right; cursor: pointer;" data-toggle="modal"
							data-target="#myModal">
							<i class="glyphicon glyphicon-question-sign"></i>
						</div>
					</div>
					<div class="panel-body">
						<button id="checkPermission" class="btn btn-success">分配许可</button>
						<br> <br>
						<ul id="treeDemo" class="ztree"></ul>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>