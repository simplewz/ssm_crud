<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<!-- 引入jQuery -->
	<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.2.1.js"></script>
	<!-- 引入bootstrap -->
	<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题行 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM_CRUD</h1>
			</div>
		</div>
			
		<!-- 按钮行-->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button type="button" class="btn btn-primary">新增</button>
				<button type="button" class="btn btn-danger">删除</button>
			</div>
		</div>
			
		<!-- 显示表格数据行-->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>emp_id</th>
						<th>emp_name</th>
						<th>gender</th>
						<th>email</th>
						<th>dept_name</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageinfo.list }" var="emp">
						<tr>
						<th>${emp.empId }</th>
						<th>${emp.empName}</th>
						<th>${emp.gender}</th>
						<th>${emp.email}</th>
						<th>${emp.department.deptName }</th>
						<th>
							<button type="button" class="btn btn-primary btn-sm">
								 <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑
							</button>
							<button type="button" class="btn btn-danger btn-sm">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
							</button>
						</th>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>	
		<!-- 分页行-->
		<div class="row">
			<!-- 显示分页信息 -->
			<div class="col-md-6">
				当前第：${pageinfo.pageNum }页，总共${pageinfo.pages }页，总共${pageinfo.total }条记录
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
					  <ul class="pagination">
					  	<li><a href="${APP_PATH }/emps?pn=1">首页</a></li>
					  	<c:if test="${pageinfo.hasPreviousPage }">
					  		<li>
					      <a href="${APP_PATH }/emps?pn=${pageinfo.pageNum-1 }" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					     </li>
					  	</c:if>
					    <c:forEach items="${pageinfo.navigatepageNums }" var="page_Num">
					    	<c:if test="${page_Num==pageinfo.pageNum }">
					    		<li class="active"><a href="#">${page_Num }</a></li>
					    	</c:if>
					    	<c:if test="${page_Num!=pageinfo.pageNum}">
					    		<li><a href="${APP_PATH }/emps?pn=${page_Num }">${page_Num }</a></li>
					    	</c:if>
					    </c:forEach>
					    <c:if test="${pageinfo.hasNextPage }">
					    	<li>
					      <a href="${APP_PATH }/emps?pn=${pageinfo.pageNum+1 }" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
					    </c:if>
					    <li><a href="${APP_PATH }/emps?pn=${pageinfo.pages }">末页</a></li>
					  </ul>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>