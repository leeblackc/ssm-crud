<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户详情界面</title>


<script type="text/javascript"
	src="${path}/static/js/jquery-1.12.4.min.js"></script>
<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet"
	href="${path}/static/bootstrap/css/bootstrap.min.css">

<script src="${path }/static/bootstrap/js/bootstrap.min.js"></script>



<style>
.table th, .table td {
	text-align: center;
	vertical-align: middle !important;
}
</style>

</head>
<body>
	

	
	<!-- 顶部标题 -->
	<div class="row ">

		<div class=" col-md-offset-5 col-md-7">
			<h1>用户信息页</h1>
		</div>
	</div>

	<!-- 查询、删除等操作按钮条 -->
	<div class="row ">

		<div class=" col-md-offset-1 col-md-4">
			<button type="button" class="btn  btn-sx btn-info">
				<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询
			</button>

			<button type="button" class="btn  btn-sx btn-success"
				id="user_add_btn">
				<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>添加
			</button>

			<button type="button" class="btn  btn-sx btn-info"
				id="user_modify_btn">
				<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
			</button>

			<button type="button" class="btn  btn-sx btn-warning">
				<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
			</button>

		</div>
		<div class=" col-md-offset-3 col-md-4">
			<form class="form-inline">
				<div class="form-group">
					<label for="inputPassword2" class="sr-only">请输入用户名</label> <input
						type="text" class="form-control" id="searchInput"
						placeholder="请输入用户名">
				</div>
				<!-- 模糊查询 -->
				<button type="button" class="btn btn-default btn-info"
					onclick="fuzzy_search()">查询</button>
				<!-- 精确搜索 -->
				<button type="button" class="btn  btn-sx btn-info">
					<span class="glyphicon glyphicon-search" aria-hidden="true"></span>精确搜索
				</button>
			</form>
		</div>



	</div>

	<!--主体，用户信息详情  -->
	<!-- 显示表格数据 -->
	<div class="row">
		<div class=" col-md-offset-1 col-md-10">
			<table class="table table-hover" id="users_table">
				<thead>
					<tr>
						<th><input type="checkbox" id="check_all"></th>
						<th>用户编号</th>
						<th>用户名</th>
						<th>用户账号</th>
						<th>密码</th>
						<th>用户类别</th>
						<th>管理</th>
					</tr>
				</thead>
				<tbody>

				</tbody>

			</table>
		</div>
	</div>

	<!--显示全部数据信息 ，分页导航  -->
	<div class=" col-md-12">
		<!-- 总记录数等 -->
		<div class=" col-md-offset-1 col-md-4" id="page_info_area"></div>
		<!--  分页导航条-->
		<div class="col-md-6">
			<nav aria-label="Page navigation">
			<ul class="pagination" id="page_nav_area">

			</ul>
			</nav>
		</div>

	</div>

	<!-- 用户添加模态框 -->
	<div class="modal fade" tabindex="-1" role="dialog" id="userAddModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close" data-toggle="tooltip" data-placement="left" title="关闭">
						<span aria-hidden="true">&times;</span>
					</button>
		
					<h4 class="modal-title">用户新增</h4>
				</div>
				<div class="modal-body">
					<input type="hidden" value="" id="ajax_validate">
					<form class="form-horizontal" id="user_add_form">
						<div class="form-group"  id="username_input">
							<label for="username" class="col-sm-4 control-label">用户名</label>
							<div class="col-sm-6">
								<input type="text" class="form-control"  id="username"  name="username" placeholder="请输入用户名">
								<span id="username_check" class="help-block"></span>
							</div>
						</div>								
						<div class="form-group" id="account_input">
							<label for="account" class="col-sm-4 control-label">账户</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" id="account"  name="account"
									placeholder="请输入账户（6-12位英文或数字组合）" >
									<span id="account_check" class="help-block"></span>
							</div>
						</div>
						<div class="form-group" id="password_input">
							<label for=""password"" class="col-sm-4 control-label">密码</label>
							<div class="col-sm-6">
								<input type="password" class="form-control" id="password" name="password"
									placeholder="请输入密码（6-12位英文或数字组合）">
									<span id=""password"_check" class="help-block"></span>
							</div>
						</div>
						<div class="form-group" id="utype_input">
							<label for="utype" class="col-sm-4 control-label">用户类型</label>
							<div class="col-sm-6">
								<select class="form-control" id="type" name="type">
									 <option value="1">管理员</option>
									 <option value="2" selected="selected">普通用户</option>							 
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="user_save_btn">保存</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	<!-- ========================================================== -->
	<!-- 用户信息修改模块 -->
	<div class="modal fade" tabindex="-1" role="dialog"
		id="userModifyModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">用户信息修改</h4>
				</div>
				<div class="modal-body">
					
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" id="user_modify_modal_cancel_btn">取消</button>
					<button type="button" class="btn btn-primary" id="">确定</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

	<!-- ============================================================== -->
	<!-- 添加用户成功提示框 -->
	<!-- 用户添加模态框 -->
	<div class="modal fade" tabindex="-1" role="dialog"
		id="userSaveSuccessModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">添加用户</h4>
				</div>
				<div class="modal-body" id="confirm_message">
					<p>保存成功！</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="user_save_success_modal_btn">确定</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

	<!--分页js  -->
	<script type="text/javascript">
	var maxpage;
		$(document).ready(function() {
			//默认加载页面时展示第一页
			to_page(1);
		});

		function to_page(page) {
			$.ajax({

				url : "${path}/users",
				data : {
					"pn" : page
				},
				type : "GET",
				success : function(result) {
					console.log(result)
					//1、解析并显示用户数据
					build_users_table(result);
					//2、解析并显示分页信息
					build_page_info(result);
					//3、解析显示分页条数据
					build_page_nav(result);
				}
			});
		}
		//构建用户信息表格
		function build_users_table(result) {
			//清空table表格
			$("#users_table tbody").empty();
			var users = result.data.pageInfo.list;
			$
					.each(
							users,
							function(index, item) {
								var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
								var userIdTd = $("<td></td>").append(
										item.userid);
								var userNameTd = $("<td></td>").append(
										item.username);
								var accountTd = $("<td></td>").append(
										item.account);
								var passwordTd = $("<td></td>").append(
										item.password);
								var uTypeTd = $("<td></td>").append(
										item.type == "1" ? "管理员" : "普通用户");
								var manageTd = $("<td></td>")
										.append(
												"<a><span class=\"glyphicon glyphicon-pencil\" aria-hidden=\"true\"></span>编辑明细</a>")
										.append(
												"<a><span class=\"glyphicon glyphicon-pencil\" aria-hidden=\"true\"></span>修改密码</a>")
										.append(
												"<a><span class=\"glyphicon glyphicon-trash\" aria-hidden=\"true\"></span>删除</a>");
								//append方法执行完成以后还是返回原来的元素
								$("<tr></tr>").append(checkBoxTd).append(
										userIdTd).append(userNameTd).append(
										accountTd).append(passwordTd).append(
										uTypeTd).append(manageTd).appendTo(
										"#users_table tbody");
							});
		}
		//解析显示分页信息
		function build_page_info(result) {
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前" + result.data.pageInfo.pageNum + "页,总"
							+ result.data.pageInfo.pages + "页,总"
							+ result.data.pageInfo.total + "条记录");

		}
		//解析显示分页条，点击分页要能去下一页....
		function build_page_nav(result) {
			//page_nav_area
			$("#page_nav_area").empty();
			var ul = $("#page_nav_area");
			var navigatepageNums = result.data.pageInfo.navigatepageNums;
			maxpage = result.data.pageInfo.pages+1;
			//构建元素首页、下一页
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href",
							"javascript:void(0);"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;").attr("href",
							"javascript:void(0);"));
			//如果存在上一页，则为首页和上一页按钮添加点击事件，否则禁用这两个按钮
			if (result.data.pageInfo.hasPreviousPage) {
				//为元素添加点击翻页的事件
				firstPageLi.click(function() {
					to_page(1);
				});
				prePageLi.click(function() {
					to_page(result.data.pageInfo.pageNum - 1);
				});
			} else {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}
			//添加首页和前一页 的提示
			ul.append(firstPageLi).append(prePageLi)

			//1,2，3遍历给ul中添加页码提示
			$.each(navigatepageNums, function(index, item) {

				var numLi = $("<li></li>").append(
						$("<a></a>").append(item).attr("href",
								"javascript:void(0);"));
				if (result.data.pageInfo.pageNum == item) {
					//若当前页是展示页，则高亮显示
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
				});
				ul.append(numLi);
			});
			//构建元素末页、下一页
			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;").attr("href",
							"javascript:void(0);"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#").attr("href",
							"javascript:void(0);"));
			//如果存在下一页，则为末页和下一页按钮添加点击事件，否则禁用这两个按钮
			if (result.data.pageInfo.hasNextPage) {
				nextPageLi.click(function() {
					to_page(result.data.pageInfo.pageNum + 1);
				});
				lastPageLi.click(function() {
					to_page(result.data.pageInfo.pages);
				});
			} else {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");

			}

			//添加下一页和末页 的提示
			ul.append(nextPageLi).append(lastPageLi);
		}
	</script>
	<script type="text/javascript">
	
	var log = console.log;
	$(document).ready(function() {
		//默认加载页面时展示第一页
	
	
		$("#user_add_btn").click(function() {
			$("#userAddModal").modal({
				backdrop : "static"
			});
		})
	
		$("#user_modify_btn").click(function() {
			$("#userModifyModal").modal({
				backdrop : "static"
			});
		})

	
		//封装的一个检验信息展示方法
		function show_validate_msg(element,status,msg){
			$(element).parent().removeClass("has-success has-error");
			$(element).next("span").text("");
			if("success"==status){
				$(element).parent().addClass("has-success");
				$(element).next("span").text(msg);
			}else if("fail" == status){
				$(element).parent().addClass("has-error");
				$(element).next("span").text(msg);
			}	
		}
		//定义用户名、账号、密码校验的正则表达式
		var regName = /(^[a-zA-Z0-9_-]{3,12}$)|(^[\u2E80-\u9FFF]{2,5})/;
		var regAccount= /^[a-zA-Z0-9_-]{3,12}$/;
		var regPassword= /^[a-zA-Z0-9_-]{6,12}$/;
		//用户名输入框失焦时触发校验
		$("#username").blur(function(){
			
			check_username();
		});
				
				
		function check_username() {
			
			//if($("#account").val()==""||$.trim($("#account").val())==""){
			//log("null")
			/* $("#account_input").removeClass("has-success");
			$("#account_check").text("帐户名不能为空或空格");
			$("#account_input").addClass("has-error"); */
			/* 	show_validate_msg("#username","fail","用户名不能为空或空格");
				$("#username").val("");
				return false;
			} */
			if (regName.test($("#username").val())) {
				show_validate_msg("#username", "success", "");
				return true;
			} else {
				if ($("#username").val().indexOf(" ") >= 0) {
					show_validate_msg("#username", "fail", "用户名不能包含空格");
					return false;
					//	$("#account_check").text("帐户名不能包含空格");
				} else {
					show_validate_msg("#username", "fail", "用户名必须为3-12位英文或数字组合或2-5位中文");
					return false;
					//$("#account_check").text("帐户名必须为6-12为英文或数字组合");
				}
			}
		}
		//账号输入框失焦时触发校验功能
		$("#account").blur(function(){
			check_account();
		});
		
		function check_account() {
			
			if ($("#account").val() == "" || $.trim($("#account").val()) == "") {
				show_validate_msg("#account", "fail", "帐户名不能为空或空格");
				$("#account").val("");

			}
			if (regAccount.test($("#account").val())) {
				$.ajax({
					url : "${path}/checkaccount",
					data : {
						"account" : $("#account").val()
					},
					async: false,
					type : "GET",
					success : function(result) {
						if (result.code == 100) {
						
							show_validate_msg("#account", "success", "帐户名可用");
							$("#ajax_validate").val("success");
							
						} else {
						
							show_validate_msg("#account", "fail", "帐户名已存在");
							$("#ajax_validate").val("fail");
							
						}
					}
				});

				var flag = $("#ajax_validate").val();
				//log(flag)
				return flag=="success"?true:false;
				
				
			} else {
				//$("#account_input").removeClass("has-success");
				if ($("#account").val().indexOf(" ") >= 0) {
					show_validate_msg("#account", "fail", "帐户名不能包含空格");
					return false;
					//	$("#account_check").text("帐户名不能包含空格");
				} else {
					show_validate_msg("#account", "fail", "帐户名必须为3-12为英文或数字组合");
					return false;
					//$("#account_check").text("帐户名必须为6-12位英文或数字组合");
				}
				//$("#account_input").addClass("has-error");
				/* $("#account").val(""); */
			}
		};
	
		//校验密码
		$("#password").blur(function() {
			check_password();
		})
		function check_password() {

			if (regName.test($("#password").val())) {
				show_validate_msg("#password", "success", "");
				return true;
			} else {
				if ($("#password").val().indexOf(" ") >= 0) {
					show_validate_msg("#password", "fail", "密码不能包含空格");
					return false;
					//	$("#account_check").text("帐户名不能包含空格");
				} else {
					show_validate_msg("#password", "fail", "密码必须为6-12位英文或数字的组合");
					return false;
					//$("#account_check").text("帐户名必须为6-12为英文或数字组合");
				}

			}
		}
		/*          ================================================================*/
		$("#user_save_btn").click(function() {
			//前端校验数据是否正确

			log("check_username:"+check_username());
			log("check_account:"+check_account());
			log("check_password:"+check_password());
			if (check_username() && check_account() && check_password()) {							
				log($("#user_add_form").serialize())
				//2、发送ajax请求保存员工
				$.ajax({
					url : "${path}/user",
					type : "POST",
					data : $("#user_add_form").serialize(),
					success : function(result) {
						//alert(result.msg);
						log(result.msg)
						if(result.code == 100){
							//员工保存成功；
							//1、关闭模态框
							$("#userAddModal").modal('hide');
							reset_form("#user_add_form");
							//$("#userSaveSuccessModal #confirm_message").append("<p>保存成功</p>")
							$("#userSaveSuccessModal").modal('show');
							//2、来到最后一页，显示刚才保存的数据
							//发送ajax请求显示最后一页数据即可
							//to_page(100); 
						}

					}
				});
			}
		});
		//重置表单封装函数
		function reset_form(element){
			$(element)[0].reset();
			//清空表单样式
			$(element).find("*").removeClass("has-error has-success");
			$(element).find(".help-block").text("");
		}
		//保存成功点击确认清空新增用户模态框的信息
		$("#user_save_success_modal_btn").click(function(){
			$("#userSaveSuccessModal").modal('hide');
			log(1)
			to_page(maxpage);
		})
		/*  =======================================================================*/
		function fuzzy_search() {
			var username = $("#searchInput").val();
			log(username)

		}

		$("#check_all").click(function() {
			/* 	console.log($(this).prop("checked")) */
			$(".check_item").prop("checked", $(this).prop("checked"));
		});
		//check_item
		$(document)
				.on(
						"click",
						".check_item",
						function() {
							//判断当前选择中的元素是否10个
							var flag = $(".check_item:checked").length == $(".check_item").length;
							$("#check_all").prop("checked", flag);
						});
		
	});
	</script>
</body>
</html>