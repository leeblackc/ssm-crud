<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户详情界面</title>


<script type="text/javascript"
	src="${ctx}/static/js/jquery-1.12.4.min.js"></script>
<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet"
	href="${ctx}/static/bootstrap/css/bootstrap.min.css">

<script src="${ctx }/static/bootstrap/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		//默认加载页面时展示第一页数据
		to_page(1);
	})

	function to_page(page) {
		$.ajax({
			url : "${ctx}/users",
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
		$.each(users,function(index, item) {
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
				var userIdTd = $("<td></td>").append(item.userid);
				var userNameTd = $("<td></td>").append(item.username);
				var accountTd = $("<td></td>").append(item.account);
				var passwordTd = $("<td></td>").append(item.password);
				var uTypeTd = $("<td></td>").append(item.type == "1" ? "管理员" : "普通用户");
				var manageTd = $("<td></td>").append("<a><span class=\"glyphicon glyphicon-pencil\" aria-hidden=\"true\"></span>编辑明细</a>")
									.append("<a><span class=\"glyphicon glyphicon-pencil\" aria-hidden=\"true\"></span>修改密码</a>")
									.append("<a><span class=\"glyphicon glyphicon-trash\" aria-hidden=\"true\"></span>删除</a>");
							//append方法执行完成以后还是返回原来的元素
				$("<tr></tr>").append(checkBoxTd)
										.append(userIdTd)
										.append(userNameTd)
										.append(accountTd)
										.append(passwordTd)
										.append(uTypeTd)
										.append(manageTd)
										.appendTo("#users_table tbody");
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

		//构建元素首页、下一页
		var firstPageLi = $("<li></li>").append(
				$("<a></a>").append("首页").attr("href", "javascript:void(0);"));
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
				//当前页-1
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
	function fuzzy_search(){
		var username = $("#searchInput").val();
		alert(username)
		
	}

</script>

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

			<button type="button" class="btn  btn-sx btn-success">
				<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>添加
			</button>

			<button type="button" class="btn  btn-sx btn-info">
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
				<button type="button" class="btn btn-default btn-info" onclick="fuzzy_search()">查询</button>
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
			<table class="table table-hover " id="users_table">
				<thead>
					<tr>
						<th><input type="checkbox" id="check_all" value="">
						</th>
						<th>用户编号</th>
						<th>用户名</th>
						<th>用户账号</th>
						<th>密码</th>
						<th>用户类别</th>
						<th>管理</th>
					</tr>
				<thead>
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
				<li><a href="#" aria-label="Previous"> <span
						aria-hidden="true">&laquo;</span>
				</a></li>
				<li><a href="#">1</a></li>
				<li><a href="#">2</a></li>
				<li><a href="#">3</a></li>
				<li><a href="#">4</a></li>
				<li><a href="#">5</a></li>
				<li><a href="#" aria-label="Next"> <span aria-hidden="true">&raquo;</span>
				</a></li>
			</ul>
			</nav>
		</div>

	</div>

</body>
</html>