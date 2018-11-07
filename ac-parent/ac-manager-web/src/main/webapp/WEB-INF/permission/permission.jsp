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
<script type="text/javascript">
	$(function() {
		window.contextPath = "${pageContext.request.contextPath}";
		//设置zTree的相关属性
		var setting = {
				//设置树形菜单的视图显示效果
				view: {
					//设置自定义的树形菜单节点DOM元素
					//treeId：整个树形菜单所依附的HTML元素的id（这个HTML元素指的是页面上本来就有的元素）
					//treeNode：树形菜单生成过程中逐个生成每一个节点时当前的节点，对应Permission对象
					addDiyDom : function(treeId, treeNode) {
						
						//拼当前节点的图标元素的id值
						//treeNode.tId等于treeId_节点编号
						var iconId = treeNode.tId + "_ico";
						
						//使用jQuery选择器定位到这个元素
						var iconObj = $("#" + iconId);
						
						//判断当前节点上是否有图标
						//JavaScript中可以根据对象是否为null进行条件判断
						if(treeNode.icon) {
							
							//使用图标的jQuery对象移除默认的class值，添加新class值
							iconObj
								.removeClass("button ico_docu ico_open")
								
								//数据库中的图标效果直接拿来用就行，不能加"fa fa-fw " + 
								.addClass(treeNode.icon)
								.css("background","");
							
						}
						
					},
					addHoverDom : function(treeId, treeNode){
						//1.先判断当前节点后面是否已经追加过按钮组，如果已经追加过，就不追加了
						if($("#btnGroup"+treeNode.tId).length>0) {
							return ;
						}
						//2.创建span元素的DOM对象，在这个span中会包含其他所有按钮
						var spanObj = $("<span id='btnGroup"+treeNode.tId+"'></span>");
						
						//3.创建三个按钮对象
						var plus = $("<a id='"+treeNode.id+"' onclick='showPermissionAddModal(this)' class='btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;'>&nbsp;&nbsp;<i class='fa fa-fw fa-plus rbg '></i></a>");
						var edit = $("<a id='"+treeNode.id+"' onclick='showPermissionEditModal(this)' class='btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;' title='修改权限信息'>&nbsp;&nbsp;<i class='fa fa-fw fa-edit rbg '></i></a>");
						var del = $("<a id='"+treeNode.id+"' onclick='doPermissionDel(this)' class='btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;'>&nbsp;&nbsp;<i class='fa fa-fw fa-times rbg '></i></a>");
						
						//4.获取当前节点级别
						var level = treeNode.level;
						
						//5.根据当前节点级别判断需要放入按钮组的按钮组合
						if(level == 0) {
							//根节点，仅添加plus按钮
							spanObj.append(plus);
						}
						
						if(level == 1) {
							//分支节点，必然添加的是plus和edit
							spanObj.append(plus).append(edit);
							
							//如果没有子节点，可以添加del
							if(treeNode.children.length == 0) {
								spanObj.append(del);
							}
						}
						if(level == 2) {
							//叶子节点，添加edit，del
							spanObj.append(edit).append(del);
							
						}
						//6.拼当前菜单节点所在a元素的id值
						var anchorId = treeNode.tId + "_a";
						//7.根据a元素的id通过jQuery选择器定位到菜单节点
						$("#"+anchorId).after(spanObj);
					},
					removeHoverDom : function(treeId, treeNode){
						$("#btnGroup"+treeNode.tId).remove();
					}
				},
				//给数据绑定一个未知的地址，取消默认的跳转请求
				data : {
					key : {
						url : "noExists"
					}
				}
			};

			//刷行树形菜单页面
			refreshTree("${pageContext.request.contextPath}/permission/getTree.atguigu", setting);
			
			//给新增许可的表单的新增按钮绑定单击响应函数
			$("#permissionAddSubmitBtn").click(function(){
				
				//1.收集表单数据
				var name = $("#permissionAddForm [name='name']").val();
				var icon = $("#permissionAddForm :radio:checked").val();
				var url = $("#permissionAddForm [name='url']").val();
				
				//2.从全局变量获取父节点id
				var pid = window.permissionPid;
				
				//3.发送Ajax请求
				var urlAjax = "${pageContext.request.contextPath}/permission/save.atguigu";
				var param = {
					"name":name,
					"icon":icon,
					"url":url,
					"pid":pid,
					"random":Math.random()
				};
				var callBack = function(response){
					
					if(response.result == "FAILED") {
						layer.msg(response.message);
						return ;
					}
					
					//后续操作1：重置表单
					//相当于点击了reset按钮
					$("#permissionAddResetBtn").click();
					
					//后续操作2：关闭模态框
					$("#permissionAddModal").modal("hide");
					
					//后续操作3：刷新树形菜单
					refreshTree("${pageContext.request.contextPath}/permission/getTree.atguigu", setting);
					
				};
				var type = "json";
				
				$.post(urlAjax, param, callBack, type);
			});
			
			//给新增许可的表单的新增按钮绑定单击响应函数
			$("#permissionEditSubmitBtn").click(function(){
				
				//1.收集表单数据
				var name = $("#permissionEditForm [name='name']").val();
				var icon = $("#permissionEditForm :radio:checked").val();
				var url = $("#permissionEditForm [name='url']").val();
				
				//2.从全局变量获取父节点id
				var id = window.permissionid;
				
				//3.发送Ajax请求
				var urlAjax = "${pageContext.request.contextPath}/permission/update.atguigu";
				var param = {
					"name":name,
					"icon":icon,
					"url":url,
					"id":id,
					"random":Math.random()
				};
				var callBack = function(response){
					
					if(response.result == "FAILED") {
						layer.msg(response.message);
						return ;
					}
					
					//后续操作1：重置表单
					//相当于点击了reset按钮
					$("#permissionEditResetBtn").click();
					
					//后续操作2：关闭模态框
					$("#permissionEditModal").modal("hide");
					
					//后续操作3：刷新树形菜单
					refreshTree("${pageContext.request.contextPath}/permission/getTree.atguigu", setting);
					
				};
				var type = "json";
				
				$.post(urlAjax, param, callBack, type);
			});
			
			//给删除模拟态框的ok按钮绑定单击函数
			$("#okBtn").click(function name() {
				//无论成功还是失败，都关闭模态框
				$("#permissionDelModal").modal("hide");
				//设置ajax请求参数
				var urlAjax = window.contextPath + "/permission/deletePermission.atguigu";
				var param = {
						"id":window.permissionid,
						"random":Math.random()
				};
				var callBack = function(response){
					if(response.result == "SUCCESS"){
						//删除成功刷新树形菜单页面
						layer.msg("删除成功");
						refreshTree("${pageContext.request.contextPath}/permission/getTree.atguigu", setting);
					}
					if(response.result == "FAILED"){
						layer.msg("删除失败"+response.message);
					}
				};
				var type = "json";
				//发送Ajax 请求
				$.post(urlAjax,param,callBack,type);
			});
	})
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
						<i class="glyphicon glyphicon-th-list"></i> 权限菜单列表
						<div style="float: right; cursor: pointer;" data-toggle="modal"
							data-target="#myModal">
							<i class="glyphicon glyphicon-question-sign"></i>
						</div>
					</div>
					<div class="panel-body">
						<!-- 这里是zTree动态生成的DOM元素所在的位置 -->
						<ul id="treeDemo" class="ztree"></ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/commons/modal_permission_add.jsp"%>
	<%@include file="/WEB-INF/commons/modal_permission_del.jsp"%>
	<%@include file="/WEB-INF/commons/modal_permission_edit.jsp"%>
</body>
</html>