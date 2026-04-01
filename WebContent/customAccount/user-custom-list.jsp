<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%
if (session.getAttribute("customAccount") == null)
	response.sendRedirect("login.jsp");
%>
<meta charset="utf-8">
<title>业主信息 | 物业管理系统-用户</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="物业管理系统">
<meta name="author" content="lmp&yhj">

<link id="bs-css" href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/index.css" rel="stylesheet">
<link href="css/repair.css" rel="stylesheet">
<!-- Font Awesome 图标 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>

<body>
	<!-- 顶部导航栏 -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="index2.jsp"> <img alt="物业管理系统 Logo"
				src="img/logo.png" class="d-inline-block align-top"> <span>物业管理系统-用户</span>
			</a>

			<div class="ms-auto d-flex align-items-center">
				<div class="dropdown">
					<button
						class="btn btn-light dropdown-toggle d-flex align-items-center"
						data-bs-toggle="dropdown" aria-expanded="false">
						<i class="fas fa-user-circle me-2"></i> <span
							class="d-none d-sm-inline">${customAccount.username}</span>
					</button>
					<ul class="dropdown-menu dropdown-menu-end">
						<li><a class="dropdown-item" href="user?action=logout"> <i
								class="fas fa-sign-out-alt me-2"></i>注销登录
						</a></li>
					</ul>
				</div>
			</div>
		</div>
	</nav>

	<div class="container-fluid">
		<div class="row">
			<!-- 左侧菜单 -->
			<div class="col-lg-2 col-md-3 d-none d-md-block p-0">
				<div class="sidebar-nav">
					<ul class="nav nav-pills flex-column">
						<li class="nav-header" style="font-size: 18px">功能菜单</li>
						<li class="nav-item"><a class="nav-link" href="index2.jsp">
								<i class="fas fa-home"></i>首页
						</a></li>
						
						<li class="nav-item"><a class="nav-link"
							href="custom?action=change&accountid=${customAccount.accountid}">
								<i class="fas fa-key"></i>修改密码
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="main?action=maintainUserList&username=${customAccount.username}">
								<i class="fas fa-tools"></i>报修管理
						</a></li>
						<li class="nav-item active"><a class="nav-link"
							href="custom?action=findById2&accountid=${customAccount.accountid}">
								<i class="fas fa-user"></i>业主信息
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="house?action=findByOwnerid&ownerid=${customAccount.ownerid}">
								<i class="fas fa-house-user"></i>房产信息
						</a></li>
					</ul>
				</div>
			</div>

			<!-- 主内容区 -->
			<main class="col-lg-10 col-md-9 ms-sm-auto px-md-4 py-4" >
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3"
					style="background-color: #78c2ad; border-radius: 5px; padding: 10px 15px;">
					<nav aria-label="breadcrumb">
						<ol class="breadcrumb mb-0"
							style="background-color: transparent; padding: 0; color: white;">
							<li class="breadcrumb-item"><a href="index2.jsp"
								style="color: white;font-size: 16px">首页</a></li>
							<li class="breadcrumb-item active" style="color: #f8f9fa; font-size: 16px">业主信息</li>
						</ol>
					</nav>
				</div>

				<div class="card shadow-sm mb-4">
					<div class="card-header bg-primary text-white">
						<h5 class="mb-0">
							<i class="fas fa-user me-2"></i>业主信息
						</h5>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-striped table-hover">
								<thead class="table-light">
									<tr>
										<th>照片</th>
										<th>用户名</th>
										<th>密码</th>
										<th>业主编号</th>
										<th>车牌号</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<c:if test="${not empty customAccount.owner_image}">
												<img src="${customAccount.owner_image}" alt="业主照片"
													style="max-width: 50px; max-height: 50px;"
													class="img-thumbnail">
											</c:if>
										</td>
										<td>${customAccount.username}</td>
										<td>******</td>
										<td>${customAccount.ownerid}</td>
										<td>${customAccount.carid}</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>

	<footer class="footer mt-auto py-3 bg-dark text-white">
		<div class="container text-center">
			<span>&copy; 2025 lmp&yhj - 版权所有</span>
		</div>
	</footer>
	<script 
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js">
	</script>

</body>
</html>