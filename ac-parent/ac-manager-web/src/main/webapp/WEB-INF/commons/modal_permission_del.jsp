<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="permissionDelModal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">尚筹网系统消息</h4>
			</div>
			<div id="permissionDelModalBody" class="modal-body"></div>
			<div class="modal-footer">
				<button id="okBtn" type="button" class="btn btn-default">OK</button>
				
				<script type="text/javascript">
					$(function(){
						$("#cancelBtn").click(function(){
							$("#confirmModal").modal("hide");
						});
					});
				</script>
				<button id="cancelBtn" type="button" class="btn btn-primary">Cancel</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->