<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%
if (session.getAttribute("customAccount") == null)
	response.sendRedirect("login.jsp");
%>
<meta charset="utf-8">
<title>首页 | 物业管理系统-用户</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="物业管理系统">
<meta name="author" content="lmp&yhj">

<link id="bs-css" href="css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome 图标 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link href="css/index.css" rel="stylesheet">
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
						<li class="nav-item"><a class="nav-link active"
							href="index2.jsp"> <i class="fas fa-home"></i>首页
						</a></li>

						<li class="nav-item"><a class="nav-link"
							href="custom?action=change&accountid=session.getAccountid();">
								<i class="fas fa-key"></i>修改密码
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="main?action=maintainUserList&username=${customAccount.username }">
								<i class="fas fa-tools"></i>报修管理
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="custom?action=findById2&accountid=${customAccount.accountid }">
								<i class="fas fa-user"></i>业主信息
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="house?action=findByOwnerid&ownerid=${customAccount.ownerid }">
								<i class="fas fa-house-user"></i>房产信息
						</a></li>
					</ul>
				</div>
			</div>

			<!-- 主内容区 -->
			<main class="col-lg-10 col-md-9 ms-sm-auto px-md-4 py-4">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3"
					style="background-color: #78c2ad; border-radius: 5px; padding: 10px 15px;">
					<nav aria-label="breadcrumb">
						<ol class="breadcrumb">
							<li class="breadcrumb-item" style="font-size: 18px">
							<a href="index2.jsp">首页</a></li>
						</ol>
					</nav>
				</div>

				<div class="card shadow-sm mb-4">
					<div class="card-header bg-primary text-white">
						<h5 class="mb-0">
							<i class="fas fa-bell me-2"></i>欢迎使用物业管理系统
						</h5>
					</div>
					<div class="card-body">
						<div class="welcome-message">
							<h1>
								<script language="javaScript">
                                    now = new Date(), hour = now.getHours()
                                    if (hour < 6) {
                                        document.write("凌晨好！")
                                    } else if (hour < 9) {
                                        document.write("早上好！")
                                    } else if (hour < 12) {
                                        document.write("上午好！")
                                    } else if (hour < 14) {
                                        document.write("中午好！")
                                    } else if (hour < 17) {
                                        document.write("下午好！")
                                    } else if (hour < 19) {
                                        document.write("傍晚好！")
                                    } else if (hour < 22) {
                                        document.write("晚上好！")
                                    } else {
                                        document.write("夜里好！")
                                    }
                                </script>
								<br> <small class="text-muted">欢迎使用物业管理系统！</small>
							</h1>
							<p class="lead">请在左侧选择您要进行的操作</p>

						</div>
					</div>
				</div>

				<!-- 快速入口 -->
				<div class="row">
					<div class="col-md-4 mb-4">
						<div class="card h-100 border-0 shadow-sm">
							<div class="card-body text-center">
								<i class="fas fa-user fa-3x text-info mb-3"></i>
								<h5 class="card-title">业主信息</h5>
								<p class="card-text">查看您的个人信息</p>
								<a
									href="custom?action=findById2&accountid=${customAccount.accountid}"
									class="btn btn-outline-info">查看信息</a>
							</div>
						</div>
					</div>
					<div class="col-md-4 mb-4">
						<div class="card h-100 border-0 shadow-sm">
							<div class="card-body text-center">
								<i class="fas fa-tools fa-3x text-warning mb-3"></i>
								<h5 class="card-title">报修管理</h5>
								<p class="card-text">提交或查看维修申请状态</p>
								<a
									href="main?action=maintainUserList&username=${customAccount.username }"
									class="btn btn-outline-warning">报修管理</a>
							</div>
						</div>
					</div>
					<div class="col-md-4 mb-4">
						<div class="card h-100 border-0 shadow-sm">
							<div class="card-body text-center">
								<i class="fas fa-house-user fa-3x text-success mb-3"></i>
								<h5 class="card-title">房产信息</h5>
								<p class="card-text">查看您的房产详细信息</p>
								<a
									href="house?action=findByOwnerid&ownerid=${customAccount.ownerid }"
									class="btn btn-outline-success">查看房产</a>
							</div>
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

	<!-- Bootstrap 5 JS bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

	<!-- 自定义脚本 -->
	<script>
        // 激活当前导航项
        document.addEventListener('DOMContentLoaded', function() {
            const currentPage = window.location.pathname.split('/').pop();
            const navLinks = document.querySelectorAll('.nav-link');
            
            navLinks.forEach(link => {
                if (link.getAttribute('href') === currentPage) {
                    link.classList.add('active');
                } else {
                    link.classList.remove('active');
                }
            });
        });
    </script>
</body>
</html>