<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="col-sm-3 col-md-2 sidebar">
	<div class="tree">
	
		<!-- 判断树形结构数据是否存在 -->
		<c:if test="${empty sessionScope.USER_PERMISSION_TREE }">系统加载异常，未检测到功能菜单数据！请重试或联系客服人员！</c:if>
		<c:if test="${!empty sessionScope.USER_PERMISSION_TREE }">

			<!-- 生成树形菜单 -->
			<ul style="padding-left: 0px;" class="list-group">

				<!-- 遍历分支节点的List生成第一层菜单 -->
				<c:forEach items="${sessionScope.USER_PERMISSION_TREE.children }"
					var="permission">
					<li class="list-group-item tree-closed">
						<!-- 第一层菜单不点击 --> <span><i class="${permission.icon }"></i>
							${permission.name }</span>
						<ul style="margin-top: 10px; display: none;">

							<!-- 判断第二层菜单是否存在 -->
							<c:if test="${!empty permission.children }">

								<!-- 遍历叶子节点的list生成第二层菜单 -->
								<c:forEach items="${permission.children }" var="child">
									<li style="height: 30px;"><a href="${child.url }"><i
											class="${child.icon }"></i> ${child.name }</a></li>
								</c:forEach>
							</c:if>
						</ul>
					</li>
				</c:forEach>
			</ul>
		</c:if>
	</div>
</div>