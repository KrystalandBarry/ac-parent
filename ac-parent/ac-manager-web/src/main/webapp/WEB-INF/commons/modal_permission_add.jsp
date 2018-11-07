<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="permissionAddModal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">尚筹网系统消息</h4>
			</div>
			<div class="modal-body">
				<form id="permissionAddForm" role="form">
					<div class="form-group">
						<label for="exampleInputPassword1">许可名称</label>
						<input id=""
							name="name" type="text" class="form-control"
							placeholder="请输入许可名称">
					</div>
					<div class="form-group">
						<input type="radio" name="icon" value="glyphicon glyphicon-th-list"/><i class="glyphicon glyphicon-th-list"></i>
						<input type="radio" name="icon" value="glyphicon glyphicon-dashboard"/><i class="glyphicon glyphicon-dashboard"></i>
						<input type="radio" name="icon" value="glyphicon glyphicon glyphicon-tasks"/><i class="glyphicon glyphicon-tasks"></i>
						<input type="radio" name="icon" value="glyphicon glyphicon-user"/><i class="glyphicon glyphicon-user"></i>
						<input type="radio" name="icon" value="glyphicon glyphicon-king"/><i class="glyphicon glyphicon-king"></i>
						<input type="radio" name="icon" value="glyphicon glyphicon-lock"/><i class="glyphicon glyphicon-lock"></i>
					</div>
					<div class="form-group">
						<label for="exampleInputPassword1">许可地址</label>
						<input
							name="url" type="text" class="form-control"
							placeholder="请输入许可地址">
					</div>
					<!-- 将表单提交按钮中的type="button"去掉，否则点这个按钮无法提交表单 -->
					<button id="permissionAddSubmitBtn" type="button" class="btn btn-success">
						<i class="glyphicon glyphicon-plus"></i> 新增
					</button>
					<button id="permissionAddResetBtn" type="reset" class="btn btn-danger">
						<i class="glyphicon glyphicon-refresh"></i> 重置
					</button>
				</form>
			</div>
		</div>
	</div>
</div>
