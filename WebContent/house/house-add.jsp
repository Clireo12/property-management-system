<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%
if (session.getAttribute("admin") == null)
	response.sendRedirect("../login.jsp");
%>
<meta charset="utf-8">
<title>添加房产 | 物业管理系统-管理员</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="物业管理系统">
<meta name="author" content="lmp&yhj">

<link id="bs-css" href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/index.css" rel="stylesheet">
<link href="../css/maintain.css" rel="stylesheet">
<!-- Font Awesome 图标 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

</head>

<body>
	<!-- 顶部导航栏 -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="../index.jsp"> <img
				alt="物业管理系统 Logo" src="../img/logo.png"
				class="d-inline-block align-top"> <span>物业管理系统-管理员</span>
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
						<li><a class="dropdown-item" href="../user?action=logout">
								<i class="fas fa-sign-out-alt me-2"></i>注销登录
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
						<li class="nav-item"><a class="nav-link" href="../index.jsp">
								<i class="fas fa-home"></i>首页
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="../admin?action=adminList"> <i class="fas fa-cog"></i>管理员信息
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="../main?action=maintainList"> <i class="fas fa-tools"></i>报修管理
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="../custom?action=customAccountList"> <i
								class="fas fa-user"></i>业主信息
						</a></li>
						<li class="nav-item active"><a class="nav-link"
							href="../house?action=houseList"> <i class="fas fa-list-alt"></i>房产信息
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
							<li class="breadcrumb-item"><a href="../index.jsp"
								style="color: white; font-size: 16px">首页</a></li>
							<li class="breadcrumb-item"><a
								href="../house?action=houseList"
								style="color: white; font-size: 16px">房产信息</a></li>
							<li class="breadcrumb-item active"
								style="color: #f8f9fa; font-size: 16px">添加房产</li>
						</ol>
					</nav>
				</div>

				<div class="card shadow-sm mb-4">
					<div class="card-header bg-primary text-white">
						<h5 class="mb-0">
							<i class="fas fa-plus-circle me-2"></i>添加房产信息
						</h5>
					</div>
					<div class="card-body form-container">
						<form role="form" action="${pageContext.request.contextPath}/house?action=houseAdd" method="post">
							<div class="row">
								<div class="col-md-6">
									<div class="form-section">
										<label class="form-label required-field">门牌号</label> <input
											type="text" class="form-control" name="num" required>
									</div>

									<div class="form-section">
										<label class="form-label required-field">楼号</label> <input
											type="text" class="form-control" name="dep" required>
									</div>

									<div class="form-section">
										<label class="form-label required-field">类型</label> <select
											class="form-select" name="kind">
											<option value="独栋">独栋</option>
											<option value="多层">多层</option>
											<option value="小高层">小高层</option>
											<option value="高层">高层</option>
										</select>
									</div>

									<div class="form-section">
										<label class="form-label required-field">地区</label> <input
											type="text" class="form-control" name="area" required>
									</div>
								</div>

								<div class="col-md-6">
									<div class="form-section">
										<label class="form-label required-field">出售状况</label> <select
											class="form-select" name="sell">
											<option value="已售">已售</option>
											<option value="待售">待售</option>
										</select>
									</div>

									<div class="form-section">
										<label class="form-label required-field">单元</label> <input
											type="text" class="form-control" name="unit" required>
									</div>

									<div class="form-section">
										<label class="form-label required-field">楼层</label> <input
											type="number" class="form-control" name="floor" required>
									</div>

									<div class="form-section">
										<label class="form-label required-field">朝向</label> <select
											class="form-select" name="direction">
											<option value="南">南</option>
											<option value="东">东</option>
											<option value="西">西</option>
											<option value="北">北</option>
										</select>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-md-6">
									<div class="form-section">
										<label class="form-label">业主编号</label> <input type="text"
											class="form-control" name="ownerid">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-section">
										<label class="form-label">备注</label> <input type="text"
											class="form-control" name="memo">
									</div>
								</div>
							</div>

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
	<!-- jQuery -->
	<script src="../bower_components/jquery/jquery.min.js"></script>
	<!-- 表单验证 -->
	<script src="../js/validator.min.js"></script>
</body>
</html>