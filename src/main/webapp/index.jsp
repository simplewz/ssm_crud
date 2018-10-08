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
   <!--员工信息修改模态框  -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">员工修改</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal">
		  <div class="form-group">
		    <label class="col-sm-4 control-label">姓名</label>
		    <div class="col-sm-6">
		    <input type="text" name="empName" class="form-control" id="empName_update_input" placeholder="empName">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-4 control-label">email</label>
		    <div class="col-sm-6">
		      <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@163.com">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-4 control-label">性别</label>
		    <div class="col-sm-6">
		      	<label class="radio-inline">
  					<input type="radio" name="gender" id="gender1_update_input" value="男" checked="checked"> 男
				</label>
				<label class="radio-inline">
				  <input type="radio" name="gender" id="gender2_update_input" value="女"> 女
				</label>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-4 control-label">部门</label>
		    <div class="col-sm-4">
		      	<select class="form-control" name="dId" id="dept_add_select">
				 
				</select>
		    </div>
		  </div>
	</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
      </div>
    </div>
  </div>
</div>

	<!-- 员工添加模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal">
		  <div class="form-group">
		    <label class="col-sm-4 control-label">姓名</label>
		    <div class="col-sm-6">
		      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-4 control-label">email</label>
		    <div class="col-sm-6">
		      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@163.com">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-4 control-label">性别</label>
		    <div class="col-sm-6">
		      	<label class="radio-inline">
  					<input type="radio" name="gender" id="gender1_add_input" value="男" checked="checked"> 男
				</label>
				<label class="radio-inline">
				  <input type="radio" name="gender" id="gender2_add_input" value="女"> 女
				</label>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-4 control-label">部门</label>
		    <div class="col-sm-4">
		      	<select class="form-control" name="dId" id="dept_add_select">
				 
				</select>
		    </div>
		  </div>
	</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
      </div>
    </div>
  </div>
</div>
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
				<button type="button" class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button type="button" class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
			
		<!-- 显示表格数据行-->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all"/>
							</th>
							<th>emp_id</th>
							<th>emp_name</th>
							<th>gender</th>
							<th>email</th>
							<th>dept_name</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>	
		<!-- 分页行-->
		<div class="row">
			<!-- 显示分页信息 -->
			<div class="col-md-6" id="page_info_area">
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area">

			</div>
		</div>
	</div>
	<script type="text/javascript">
		//总记录数
		var totalRecord;
		//当前页面
		var currentPage;
		//1.页面加载完成以后，直接发送ajax请求，得到分页数据
		$(function(){
			to_page(1);
		});
		
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					//console.log(result);
					//1.解析并显示员工数据
					build_emps_table(result);
					//2.解析并显示分页信息
					 build_page_info(result);
					//3.解析分页导航栏
					build_page_nav(result)
				}
			});
		}
		//解析显示员工信息
		function build_emps_table(result){
			$("#emps_table tbody").empty();
			var emps=result.extend.pageinfo.list;
			$.each(emps,function(index,item){
				var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
				var empIdTd=$("<td></td>").append(item.empId);
				var empNameTd=$("<td></td>").append(item.empName);
				var genderTd=$("<td></td>").append(item.gender);
				var emailTd=$("<td></td>").append(item.email);
				var deptNameTd=$("<td></td>").append(item.department.deptName);
				var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
							.append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
							.append("编辑");
				//为编辑按钮添加一个自定义的属性，表示当前员工的id，便于更改当前员工的信息
				editBtn.attr("edit-id",item.empId);
				var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
							.append($("<span></span>").addClass("glyphicon glyphicon-trash"))
							.append("删除");
				//为删除按钮添加一个自定义属性，表示当前员工id，便于选择单个员工的删除
				delBtn.attr("del-id",item.empId);
				var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
				$("<tr></tr>").append(checkBoxTd)
								.append(empIdTd)
								.append(empNameTd)
								.append(genderTd)
								.append(emailTd)
								.append(deptNameTd)
								.append(btnTd)
								.appendTo("#emps_table tbody");
			});
		}
		//解析显示分页信息
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前第"+result.extend.pageinfo.pageNum+"页，总共"+
					result.extend.pageinfo.pages+"页，总共"+
					result.extend.pageinfo.total+"条记录");
			totalRecord=result.extend.pageinfo.total;
			currentPage=result.extend.pageinfo.pageNum;
		}
		//解析分页导航条
		function build_page_nav(result){
			$("#page_nav_area").empty();
			var ul=$("<ul></ul>").addClass("pagination");
			var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
			if(result.extend.pageinfo.hasPreviousPage==false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				firstPageLi.click(function (){
					to_page(1);
				});
				prePageLi.click(function (){
					to_page(result.extend.pageinfo.pageNum-1);
				});
			}
			var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			if(result.extend.pageinfo.hasNextPage==false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				nextPageLi.click(function (){
					to_page(result.extend.pageinfo.pageNum+1);
				});
				lastPageLi.click(function (){
					to_page(result.extend.pageinfo.pages);
				});
			}
			ul.append(firstPageLi).append(prePageLi);
			$.each(result.extend.pageinfo.navigatepageNums,function(index,item){
				var pageNumLi=$("<li></li>").append($("<a></a>").append(item));
				if(result.extend.pageinfo.pageNum==item){
					pageNumLi.addClass("active");
				}
				pageNumLi.click(function(){
					to_page(item);
				});
				ul.append(pageNumLi);
			});
			ul.append(nextPageLi).append(lastPageLi);
			var navEle=$("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		//清空表单样式及内容
		function reset_form(ele){
			//重置表单内容
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-success has-error");
			//清除表单辅助标识的内容
			$(ele).find(".help-block").text("");
		}
		//点击新增按钮，弹出添加员工信息对话框
		$("#emp_add_modal_btn").click(function(){
			//弹出模态框之前清除表单数据和样式（表单重置）
			//$("#empAddModal form")[0].reset();
			reset_form("#empAddModal form");
			//发送ajax请求，查出部门信息，显示在下拉列表中
			getDepts("#empAddModal select");
			//弹出模态框
			$("#empAddModal").modal({
				backdrop:"static"
			});
		});
		//查出部门信息，显示在下拉列表中
		function getDepts(ele){
			//先清空之前下拉列表的值
			$(ele).empty();
			//发送ajax请求查询部门信息
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					//console.log(result);
					$.each(result.extend.depts,function(){
						var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		
		//校验表单数据的方法
		function validate_add_form(){
			//1.先拿到填入的数据，使用正则表达式进行校验
			var empName=$("#empName_add_input").val();
			var regName=/(^[a-zA_Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			//姓名校验
			if(!regName.test(empName)){
				//alert("用户名可以是2-5个汉字组合或者是6-16位英文字母和数字的组合");
				show_validate_msg("#empName_add_input","error","用户名可以是2-5个汉字组合或者是6-16位英文字母和数字的组合");
				//$("#empName_add_input").parent().addClass("has-error");
				//$("#empName_add_input").next("span").text("用户名可以是2-5个汉字组合或者是6-16位英文字母和数字的组合");
				return false;
			}
			else{
				show_validate_msg("#empName_add_input","success","");
				//$("#empName_add_input").parent().addClass("has-succuss");
				//$("#empName_add_input").next("span").text("");
			}
			var email=$("#email_add_input").val();
			var regEmail=/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			//邮箱校验
			if(!regEmail.test(email)){
				//alert("邮箱格式不正确！");
				show_validate_msg("#email_add_input","error","邮箱格式不正确！");
				//$("#email_add_input").parent().addClass("has-error");
				//$("#email_add_input").next("span").text("邮箱格式不正确！");
				return false;
			}
			else{
				show_validate_msg("#email_add_input","success","");
				//$("#email_add_input").parent().addClass("has-succuss");
				//$("#email_add_input").next("span").text("");
			}
			return true;
		}
		//显示检验结果的提示信息
		function show_validate_msg(ele,status,msg){
			//在做校验之前应该清除当前元素的校验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			//校验表单输入
			if("success"==status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}
			else if("error"==status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		//校验用户名是否可用
		$("#empName_add_input").change(function(){
			//发送ajax请求校验用户名是否可用
			var empName=this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					if(result.code==100){
						show_validate_msg("#empName_add_input","success","用户名可用！");
						$("#emp_save_btn").attr("ajax-va","success");
					}
					else{
						show_validate_msg("#empName_add_input","error",result.extend.va_msg);
						$("#emp_save_btn").attr("ajax-va","error");
					}
				}
			});
		});
		
		$("#emp_save_btn").click(function (){
			//1.模态框中填写的表单数据交给服务器进行保存
			//先对需要提交给服务器的数据进行校验
			if(!validate_add_form()){
				return false;
			}
			//判断之前的ajax用户名校验是否成功，如果成功则可以进行保存，否则不能保存输入的员工信息
			if($(this).attr("ajax-va")=="error"){
				return false;
			}
			//alert($("#empAddModal form").serialize());
			//2再发送ajax请求保存员工信息
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					//alert(result.message);测试所用
					/*
					*员工信息保存成功
					*关闭模态框，发送ajax请求跳转到最后一页，显示刚才保存的信息
					*/
					if(result.code==100){
						$("#empAddModal").modal('hide');
						to_page(totalRecord);
					}
					else{
						//显示失败信息,有哪个字段错误就显示哪个字段的错误信息
						if(undefined!=result.extend.errorFields.email){
							//显示邮箱错误信息
							show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
						}
						if(undefined!=result.extend.errorFields.empName){
							//显示员工姓名错误信息
							show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
						}
					}
				}
			});
		});
		
		//为每个编辑按钮绑定事件，修改员工信息
		$(document).on("click",".edit_btn",function(){
			
			//1.查出部门信息并添加到修改员工信息模态框的下拉列表中显示
			getDepts("#empUpdateModal select")
			//2.查出员工信息，显示员工信息
			getEmp($(this).attr("edit-id"));
			//3.弹出模态框,把员工的id传递给模态框的更新按钮
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			$("#empUpdateModal").modal({
				backdrop:"static"
			});
		});
		
		//查询员工信息
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					//console.log(result);
					var empData=result.extend.emp;
					$("#empName_update_input").val(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}
			});
		}
		
		//更新员工信息
		$("#emp_update_btn").click(function(){
			
			//校验姓名信息是否合法
			var empName=$("#empName_update_input").val();
			var regName=/(^[a-zA_Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			//姓名校验
			if(!regName.test(empName)){
				//alert("用户名可以是2-5个汉字组合或者是6-16位英文字母和数字的组合");
				show_validate_msg("#empName_update_input","error","用户名可以是2-5个汉字组合或者是6-16位英文字母和数字的组合");
				//$("#empName_add_input").parent().addClass("has-error");
				//$("#empName_add_input").next("span").text("用户名可以是2-5个汉字组合或者是6-16位英文字母和数字的组合");
				return false;
			}
			else{
				show_validate_msg("#empName_update_input","success","");
				//$("#empName_add_input").parent().addClass("has-succuss");
				//$("#empName_add_input").next("span").text("");
			}
			//验证邮箱是否合法
			var email=$("#email_update_input").val();
			var regEmail=/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			//邮箱校验
			if(!regEmail.test(email)){
				//alert("邮箱格式不正确！");
				show_validate_msg("#email_update_input","error","邮箱格式不正确！");
				//$("#email_add_input").parent().addClass("has-error");
				//$("#email_add_input").next("span").text("邮箱格式不正确！");
				return false;
			}
			else{
				show_validate_msg("#email_update_input","success","");
				//$("#email_add_input").parent().addClass("has-succuss");
				//$("#email_add_input").next("span").text("");
			}
			
			//发送ajax请求，保存员工信息
			$.ajax({
				//url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				//type:"POST",
				//data:$("#empUpdateModal form").serialize()+"&_method=PUT",
				//success:function(){	
				url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(){
					//console.log(result);
					//关闭对话框
					$("#empUpdateModal").modal("hide");
					//回到本界面
					to_page(currentPage);
				}
			});
		});
		
		//员工单个删除
		$(document).on("click",".delete_btn",function(){
			//弹出确认删除度对话框
			var empName=$(this).parents("tr").find("td:eq(2)").text();
			var empId=$(this).attr("del-id");
			if(confirm("确认删除【"+empName+"】吗？")){
				//点击确认删除即可
				$.ajax({
					url:"${APP_PATH}/emp/"+empId,
					type:"DELETE",
					success:function(result){
							alert(result.message);
							to_page(currentPage);
						}
					});
				}
		});
		//完成全选和全不选
		$("#check_all").click(function(){
			//attr获取checked的值是undefined
			//对于原生的dom对象，attr获取自定义属性的值
			//使用prop修改和读取原生的dom对象的属性值
			$(this).prop("checked");
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		//为每个checkbox绑定事件
		$(document).on("click",".check_item",function(){
			//判断当前选择的元素是否是当前页面显示记录数的总和
			var flag=$(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked",flag);
		});
		//点击批量删除按钮，删除选定的员工信息
		$("#emp_delete_all_btn").click(function(){
			//员工姓名字符串
			var empNames="";
			//员工id字符串
			var del_idstr="";
			$.each($(".check_item:checked"),function(){
				//this
				//组装员工姓名字符串
				empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
				//组装员工id字符串
				del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-"
			});
			//去除多余的逗号
			empNames=empNames.substring(0,empNames.length-1);
			//去除多余的-
			del_idstr=del_idstr.substring(0,del_idstr.length-1);
			if(confirm("确认删除【"+empNames+"】吗？")){
				//发送Ajax请求
				$.ajax({
					url:"${APP_PATH}/emp/"+del_idstr,
					type:"DELETE",
					success:function(result){
						alert(result.message);
						to_page(currentPage);
					}
				});
			}
		});
	</script>
</body>
</html>