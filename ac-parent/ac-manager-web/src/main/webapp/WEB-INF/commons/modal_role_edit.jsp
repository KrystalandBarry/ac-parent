<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="roleEidtModal" class="modal fade" tabindex="-1" role="dialog">
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
				<form role="form">
					<div class="form-group">
						<label for="exampleInputPassword1">角色名称</label>
						<input id="roleEditInput"
							name="name" type="text" class="form-control"
							placeholder="请输入角色名称">
					</div>
					<button type="button" id="roleEditSubmitBtn" class="btn btn-success">
						<i class="glyphicon glyphicon-pencil"></i> 更新
					</button>
					<button type="reset" class="btn btn-danger">
						<i class="glyphicon glyphicon-refresh"></i> 重置
					</button>
				</form>
			</div>
			
		</div>
	</div>
</div>