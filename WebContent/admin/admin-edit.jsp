<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%
if (session.getAttribute("admin") == null)
	response.sendRedirect("login.jsp");
%>
<meta charset="utf-8">
<title>编辑管理员 | 物业管理系统</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="物业管理系统">
<meta name="author" content="lmp&yhj">

<link id="bs-css" href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/index.css" rel="stylesheet">
<link href="css/maintain.css" rel="stylesheet">
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
			<a class="navbar-brand" href="index.jsp"> <img alt="物业管理系统 Logo"
				src="img/logo.png" class="d-inline-block align-top"> <span>物业管理系统-管理员</span>
			</a>

			<div class="ms-auto d-flex align-items-center">
				<div class="dropdown">
					<button
						class="btn btn-light dropdown-toggle d-flex align-items-center"
						data-bs-toggle="dropdown" aria-expanded="false">
						<i class="fas fa-user-circle me-2"></i> <span
							class="d-none d-sm-inline">${admin.name}</span>
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
						<li class="nav-item"><a class="nav-link" href="index.jsp">
								<i class="fas fa-home"></i>首页
						</a></li>
						<li class="nav-item active"><a class="nav-link"
							href="admin?action=adminList"> <i class="fas fa-cog"></i>管理员信息
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="main?action=maintainList"> <i class="fas fa-tools"></i>报修管理
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="custom?action=customAccountList"> <i
								class="fas fa-user"></i>业主信息
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="house?action=houseList"> <i class="fas fa-list-alt"></i>房产信息
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
							<li class="breadcrumb-item"><a href="index.jsp"
								style="color: white; font-size: 16px">首页</a></li>
							<li class="breadcrumb-item"><a href="admin?action=adminList"
								style="color: white; font-size: 16px">管理员信息</a></li>
							<li class="breadcrumb-item active"
								style="color: #f8f9fa; font-size: 16px">编辑管理员</li>
						</ol>
					</nav>
				</div>

				<div class="card shadow-sm mb-4">
					<div class="card-header bg-primary text-white">
						<h5 class="mb-0">
							<i class="fas fa-edit me-2"></i>编辑管理员信息
						</h5>
					</div>
					<div class="card-body form-container">
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
						<form id="editForm" role="form" action="admin?action=adminEdit"
							method="post" onsubmit="return validateForm()">
							<div class="row">
								<div class="col-md-6">
									<div class="form-section">
										<label class="form-label required-field">姓名</label> <input
											type="text" class="form-control form-control-lg" name="name"
											value="${admin.name}" required>
									</div>

									<div class="form-section">
										<label class="form-label required-field">性别</label>
										<div class="d-flex">
											<div class="form-check me-4">
												<input class="form-check-input" type="radio" name="sex"
													id="male" value="男" ${admin.sex == '男' ? 'checked' : ''}>
												<label class="form-check-label" for="male">男</label>
											</div>
											<div class="form-check">
												<input class="form-check-input" type="radio" name="sex"
													id="female" value="女" ${admin.sex == '女' ? 'checked' : ''}>
												<label class="form-check-label" for="female">女</label>
											</div>
										</div>
									</div>

									<div class="form-section">
										<label class="form-label required-field">密码</label>
										<div class="input-group">
											<input type="password" class="form-control form-control-lg"
												name="password" id="Password1" required>
											<button class="btn btn-outline-secondary" type="button"
												onclick="togglePasswordVisibility('Password1')">
												<i class="fas fa-eye"></i>
											</button>
										</div>
										<small class="form-text text-muted">密码由字母、数字或下划线组成，6位以上</small>
									</div>

									<div class="form-section">
										<label class="form-label required-field">确认密码</label>
										<div class="input-group">
											<input type="password" class="form-control form-control-lg"
												id="Password2" name="password2" required>
											<button class="btn btn-outline-secondary" type="button"
												onclick="togglePasswordVisibility('Password2')">
												<i class="fas fa-eye"></i>
											</button>
										</div>
										<div id="passwordMismatch" class="password-mismatch"
											style="display: none;">两次输入的密码不一致</div>
									</div>
								</div>

								<div class="col-md-6">
									<div class="form-section">
										<label class="form-label required-field">年龄</label> <input
											type="number" class="form-control form-control-lg" name="age"
											value="${admin.age}" required>
									</div>

									<div class="form-section">
										<label class="form-label">电话</label> <input type="text"
											class="form-control form-control-lg" name="tel"
											value="${admin.tel}">
									</div>

									<div class="form-section">
										<label class="form-label">手机</label> <input type="text"
											class="form-control form-control-lg" name="phone"
											value="${admin.phone}">
									</div>

									<div class="form-section">
										<label class="form-label required-field">地址</label> <input
											type="text" class="form-control form-control-lg" name="addr"
											value="${admin.addr}" required>
									</div>
								</div>
							</div>

							<div class="form-section">
								<label class="form-label">备注</label> <input type="text"
									class="form-control form-control-lg" name="memo"
									value="${admin.memo}">
							</div>

							<input type="hidden" name="id" value="${admin.id}" />

							<div class="submit-btn-container">
								<button type="submit" class="btn btn-primary submit-btn">
									<i class="fas fa-paper-plane me-2"></i>提 交
								</button>
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

		// 表单验证
		function validateForm() {
			const password1 = document.getElementById('Password1');
			const password2 = document.getElementById('Password2');
			const mismatchMsg = document.getElementById('passwordMismatch');

			// 验证密码是否一致
			if (password1.value !== password2.value) {
				mismatchMsg.style.display = 'block';
				password2.focus();
				return false;
			}

			// 验证密码格式
			const passwordRegex = /^[a-z0-9_]{6,}$/;
			if (!passwordRegex.test(password1.value)) {
				alert('密码格式不正确！必须由字母、数字或下划线组成，至少6位');
				password1.focus();
				return false;
			}

			return true;
		}

		// 实时验证密码一致性
		document.getElementById('Password2').addEventListener(
				'input',
				function() {
					const password1 = document.getElementById('Password1');
					const password2 = document.getElementById('Password2');
					const mismatchMsg = document
							.getElementById('passwordMismatch');

					if (password1.value !== password2.value) {
						mismatchMsg.style.display = 'block';
					} else {
						mismatchMsg.style.display = 'none';
					}
				});
	</script>
</body>
</html>