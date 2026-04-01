<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<title>登录:物业管理系统</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="物业管理系统登录页面">
<meta name="author" content="物业管理系统团队">

<!-- Bootstrap CSS -->
<link id="bs-css" href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="css/login.css" rel="stylesheet">

<link rel="shortcut icon" href="img/logo.svg">
</head>

<div class="login-container">
	<div class="login-header">
		<h1>物业管理系统</h1>
	</div>

	<div class="login-box">
		<div class="alert alert-info">
			<i class="glyphicon glyphicon-info-sign"></i> 请输入用户名和密码
		</div>

		<form data-toggle="validator" class="form-horizontal"
			action="user?action=login" method="post">
			<fieldset>
				<div class="form-group">
					<div class="input-group input-group-lg">
						<span class="input-group-addon"><i
							class="glyphicon glyphicon-user"></i></span> <input type="text"
							class="form-control" name="username" placeholder="用户名" required>
					</div>
				</div>

				<div class="form-group">
					<div class="input-group input-group-lg">
						<span class="input-group-addon"><i
							class="glyphicon glyphicon-lock"></i></span> <input type="password"
							class="form-control" name="password" pattern="^[a-z0-9_]{6,18}$"
							placeholder="密码" required>
					</div>
				</div>

				<div class="radio-group">
					<div class="radio">
						<label> <input type="radio" name="usertype" value="user"
							checked> <i class="glyphicon glyphicon-home"></i> 业主登录
						</label>
					</div>
					<div class="radio">
						<label> <input type="radio" name="usertype" value="admin">
							<i class="glyphicon glyphicon-cog"></i> 管理员登录
						</label>
					</div>
				</div>

				<div class="form-group text-center">
					<button type="submit" class="btn btn-primary btn-lg">
						<i class="glyphicon glyphicon-log-in"></i> 登录系统
					</button>
				</div>
			</fieldset>
		</form>
	</div>

	<div class="login-footer">&copy; 2025 lmp&yhj- 版权所有</div>
</div>

<!-- JavaScript -->
<script src="js/jquery.min.js"></script>
<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="js/validator.min.js"></script>
</body>
</html>