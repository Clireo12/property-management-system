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
<title>修改密码 | 物业管理系统-用户</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="物业管理系统">
<meta name="author" content="lmp&yhj">

<link id="bs-css" href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/index.css" rel="stylesheet">
<!-- Font Awesome 图标 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
.password-mismatch {
	color: #dc3545;
	font-size: 0.875em;
	margin-top: 0.25rem;
}

.invalid-feedback {
	color: #dc3545;
	font-size: 0.875em;
	margin-top: 0.25rem;
	display: block;
}
</style>
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
						
						<li class="nav-item"><a class="nav-link active"
							href="custom?action=change&accountid=${customAccount.accountid}">
								<i class="fas fa-key"></i>修改密码
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="main?action=maintainUserList&username=${customAccount.username}">
								<i class="fas fa-tools"></i>报修管理
						</a></li>
						<li class="nav-item"><a class="nav-link"
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
			<main class="col-lg-10 col-md-9 ms-sm-auto px-md-4 py-4">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3"
					style="background-color: #78c2ad; border-radius: 5px; padding: 10px 15px;">
					<nav aria-label="breadcrumb">
						<ol class="breadcrumb mb-0"
							style="background-color: transparent; padding: 0; color: white;">
							<li class="breadcrumb-item"><a href="index2.jsp"
								style="color: white;font-size: 16px">首页</a></li>
							<li class="breadcrumb-item active" style="color: #f8f9fa;font-size: 16px">修改密码</li>
						</ol>
					</nav>
				</div>

				<div class="card shadow-sm mb-4">
					<div class="card-header bg-primary text-white">
						<h5 class="mb-0">
							<i class="fas fa-key me-2"></i>修改密码
						</h5>
					</div>
					 <div class="card-body">
        			<%-- 显示错误消息 --%>
        			<%
        				String errorMsg = (String) request.getAttribute("errorMsg");
        				if (errorMsg != null) {
       				 %>
        			<div class="alert alert-danger" role="alert">
            				<%=errorMsg%>
        			</div>
        			<%
        			}

        			String successMsg = (String) request.getAttribute("successMsg");
        			if (successMsg != null) {
        			%>
        			<div class="alert alert-success" role="alert">
            		<%=successMsg%>
        			</div>
        			<%
        				}
       				 %>


			<form role="form" action="custom?action=updatePassword" method="post">
            <!-- 密码输入框 -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="Password1" class="form-label">新密码*</label>
                    <div class="input-group">
                        <input type="password" class="form-control" name="password" id="Password1" required>
                        <button class="btn btn-outline-secondary" type="button" onclick="togglePasswordVisibility('Password1')">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="Password2" class="form-label">确认密码*</label>
                    <div class="input-group">
                        <input type="password" class="form-control" name="password2" id="Password2" required>
                        <button class="btn btn-outline-secondary" type="button" onclick="togglePasswordVisibility('Password2')">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>
            </div>

            <!-- 隐藏字段 -->
            <input type="hidden" name="accountid" value="${customAccount.accountid}">
            <input type="hidden" name="username" value="${customAccount.username}">
            <input type="hidden" name="ownerid" value="${customAccount.ownerid}">
            <input type="hidden" name="carid" value="${customAccount.carid}">


				<!-- 提交按钮 -->
    			<div class="row mb-3">
        			<div class="col-md-6">
            			<button type="submit" class="btn btn-primary">
                			<i class="fas fa-save me-2"></i>保存更改
            			</button>
        			</div>
    			</div>
			</form>
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
		// 密码显示/隐藏切换
		function togglePasswordVisibility(inputId) {
			const input = document.getElementById(inputId);
			const icon = input.parentElement.querySelector('i');

			if (input.type === 'password') {
				input.type = 'text';
				icon.classList.remove('fa-eye');
				icon.classList.add('fa-eye-slash');
			} else {
				input.type = 'password';
				icon.classList.remove('fa-eye-slash');
				icon.classList.add('fa-eye');
			}
		}
	</script>
</body>
</html>