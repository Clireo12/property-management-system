<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%
if (session.getAttribute("admin") == null)
    response.sendRedirect("login.jsp");
%>
<meta charset="utf-8">
<title>管理员信息 | 物业管理系统</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="物业管理系统">
<meta name="author" content="lmp&yhj">

<link id="bs-css" href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/index.css" rel="stylesheet">
<!-- Font Awesome 图标 -->
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
.action-buttons .btn {
    margin-right: 5px;
}

.table-responsive {
    overflow-x: auto;
}

.btn-success {
    margin-bottom: 15px;
}

.search-container {
    display: flex;
    margin-bottom: 15px;
}

.search-container .form-control {
    width: 300px;
    margin-right: 10px;
}

.alert-info {
    background-color: #e7f8ff;
    border-left: 4px solid #17a2b8;
    padding: 10px 15px;
    margin-bottom: 15px;
}

.badge {
    font-size: 0.9em;
    padding: 0.35em 0.65em;
}
</style>
</head>

<body>
    <!-- 顶部导航栏 -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="index.jsp"> 
                <img alt="物业管理系统 Logo" src="img/logo.png" class="d-inline-block align-top"> 
                <span>物业管理系统-管理员</span>
            </a>

            <div class="ms-auto d-flex align-items-center">
                <div class="dropdown">
                    <button class="btn btn-light dropdown-toggle d-flex align-items-center"
                        data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-user-circle me-2"></i> 
                        <span class="d-none d-sm-inline">${admin.name}</span>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="user?action=logout"> 
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
                        <li class="nav-item"><a class="nav-link" href="index.jsp">
                            <i class="fas fa-home"></i>首页
                        </a></li>
                        <li class="nav-item active"><a class="nav-link"
                            href="admin?action=adminList"> 
                            <i class="fas fa-cog"></i>管理员信息
                        </a></li>
                        <li class="nav-item"><a class="nav-link"
                            href="main?action=maintainList"> 
                            <i class="fas fa-tools"></i>报修管理
                        </a></li>
                        <li class="nav-item"><a class="nav-link"
                            href="custom?action=customAccountList"> 
                            <i class="fas fa-user"></i>业主信息
                        </a></li>
                        <li class="nav-item"><a class="nav-link"
                            href="house?action=houseList"> 
                            <i class="fas fa-house-user"></i>房产信息
                        </a></li>
                    </ul>
                </div>
            </div>

            <!-- 主内容区 -->
            <main class="col-lg-10 col-md-9 ms-sm-auto px-md-4 py-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3"
                    style="background-color: #78c2ad; border-radius: 5px; padding: 10px 15px;">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0"
                            style="background-color: transparent; padding: 0; color: white;">
                            <li class="breadcrumb-item"><a href="index.jsp"
                                style="color: white; font-size: 16px">首页</a></li>
                            <li class="breadcrumb-item active"
                                style="color: #f8f9fa; font-size: 16px">管理员信息</li>
                        </ol>
                    </nav>
                </div>

                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-cog me-2"></i>管理员信息
                        </h5>
                    </div>
                    <div class="card-body">
                        <a class="btn btn-success mb-3" href="admin/admin-add.jsp"> 
                            <i class="fas fa-plus me-2"></i>添加记录
                        </a>

                        <!-- 搜索表单 -->
                        <div class="search-container">
                            <form action="admin" method="get" class="d-flex">
                                <input type="hidden" name="action" value="adminSearch">
                                <input type="text" class="form-control" id="keyword"
                                    name="keyword" placeholder="输入用户名、电话、地址等关键词" 
                                    value="${param.keyword}">
                                <button type="submit" class="btn btn-primary me-2">
                                    <i class="fas fa-search me-2"></i>搜索
                                </button>
                                <a href="admin?action=adminList" class="btn btn-secondary">
                                    <i class="fas fa-sync-alt me-2"></i>重置
                                </a>
                            </form>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <c:choose>
                            <c:when test="${empty admins}">
                                <div class="alert alert-warning text-center my-4">
                                    <i class="fas fa-exclamation-circle me-2"></i> 未找到管理员记录
                                    <c:if test="${not empty param.keyword}">
                                        (搜索关键词: "${param.keyword}")
                                        <br>
                                        <a href="admin?action=adminList" class="btn btn-sm btn-outline-primary mt-2">
                                            <i class="fas fa-list me-1"></i>显示全部记录
                                        </a>
                                    </c:if>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:if test="${not empty param.keyword}">
                                    <div class="alert alert-info">
                                        <i class="fas fa-search me-2"></i> 搜索到 
                                        <span class="badge bg-primary">${fn:length(admins)}</span> 条记录
                                        (关键词: "${param.keyword}")
                                    </div>
                                </c:if>
                                
                                <table class="table table-striped table-hover">
                                    <thead class="table-light">
                                        <tr>
                                            <th>用户名</th>
                                            <th>密码</th>
                                            <th>性别</th>
                                            <th>年龄</th>
                                            <th>电话</th>
                                            <th>手机</th>
                                            <th>地址</th>
                                            <th>备注</th>
                                            <th>操作</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="admin" items="${admins}">
                                            <tr>
                                                <td>${admin.name}</td>
                                                <td>******</td>
                                                <td>${admin.sex}</td>
                                                <td>${admin.age}</td>
                                                <td>${admin.tel}</td>
                                                <td>${admin.phone}</td>
                                                <td>${admin.addr}</td>
                                                <td>${admin.memo}</td>
                                                <td class="action-buttons">
                                                    <a class="btn btn-info"
                                                        href="admin?action=findById&id=${admin.id}"> 
                                                        <i class="fas fa-edit me-2"></i>编辑
                                                    </a> 
                                                    <a class="btn btn-danger"
                                                        href="javascript:if(confirm('此条记录将被永久删除，确认删除吗？')) window.location.href='admin?action=adminDelete&id=${admin.id}';">
                                                        <i class="fas fa-trash-alt me-2"></i>删除
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:otherwise>
                        </c:choose>
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
</body>
</html>