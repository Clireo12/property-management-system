<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%
if (session.getAttribute("customAccount") == null)
    response.sendRedirect("../login.jsp");
%>
<meta charset="utf-8">
<title>报修 | 物业管理系统-用户</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="物业管理系统">
<meta name="author" content="lmp&yhj">

<link id="bs-css" href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/index.css" rel="stylesheet">
<!-- Font Awesome 图标 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
    .form-container {
        max-width: 600px;
        margin: 0 auto;
        padding: 20px;
    }
    .form-section {
        margin-bottom: 25px;
    }
    .form-label {
        font-weight: 500;
        margin-bottom: 8px;
        display: block;
    }
    .required-field::after {
        content: " *";
        color: #dc3545;
    }
    .submit-btn {
        width: 100%;
        padding: 10px;
        font-size: 16px;
    }
</style>
</head>

<body>
    <!-- 顶部导航栏 -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="../index2.jsp"> 
                <img alt="物业管理系统 Logo" src="../img/logo.png" class="d-inline-block align-top"> 
                <span>物业管理系统-用户</span>
            </a>

            <div class="ms-auto d-flex align-items-center">
                <div class="dropdown">
                    <button class="btn btn-light dropdown-toggle d-flex align-items-center"
                        data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-user-circle me-2"></i> 
                        <span class="d-none d-sm-inline"><%=((com.cissst.entity.CustomAccount)session.getAttribute("customAccount")).getUsername()%></span>
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
                        <li class="nav-item"><a class="nav-link" href="../index2.jsp">
                            <i class="fas fa-home"></i>首页
                        </a></li>
                        <li class="nav-item"><a class="nav-link"
                            href="../custom?action=change&accountid=<%=((com.cissst.entity.CustomAccount)session.getAttribute("customAccount")).getAccountid()%>">
                            <i class="fas fa-key"></i>修改密码
                        </a></li>
                        <li class="nav-item active"><a class="nav-link"
                            href="../main?action=maintainUserList&username=<%=((com.cissst.entity.CustomAccount)session.getAttribute("customAccount")).getUsername()%>">
                            <i class="fas fa-tools"></i>报修管理
                        </a></li>
                        <li class="nav-item"><a class="nav-link"
                            href="../custom?action=findById2&accountid=<%=((com.cissst.entity.CustomAccount)session.getAttribute("customAccount")).getAccountid()%>">
                            <i class="fas fa-user"></i>业主信息
                        </a></li>
                        <li class="nav-item"><a class="nav-link"
                            href="../house?action=findByOwnerid&ownerid=<%=((com.cissst.entity.CustomAccount)session.getAttribute("customAccount")).getOwnerid()%>">
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
                            <li class="breadcrumb-item"><a href="../index2.jsp"
                                style="color: white;font-size: 16px">首页</a></li>
                            <li class="breadcrumb-item"><a href="../main?action=maintainUserList&username=<%=((com.cissst.entity.CustomAccount)session.getAttribute("customAccount")).getUsername()%>"
                                style="color: white;font-size: 16px">报修管理</a></li>
                            <li class="breadcrumb-item active" style="color: #f8f9fa;font-size: 16px">报修</li>
                        </ol>
                    </nav>
                </div>

                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-tools me-2"></i>报修申请
                        </h5>
                    </div>
                    <div class="card-body form-container">
                        <form role="form" action="../main?action=maintainUserAdd" method="post">
                            <div class="form-section">
                                <label class="form-label required-field">报修物品</label>
                                <input type="text" class="form-control" name="thing" required>
                            </div>
                            
                            <div class="form-section">
                                <label class="form-label required-field">房门号</label>
                                <input type="text" class="form-control" name="num" required>
                            </div>
                            
                            <div class="form-section">
                                <label class="form-label required-field">预计花费</label>
                                <input type="text" class="form-control" name="tcost" 
                                    pattern="^[0-9]+(\.[0-9]{0,2})?$" required>
                                <small class="form-text text-muted">请输入数字，可包含两位小数</small>
                            </div>
                            
                            <div class="form-section">
                                <label class="form-label">报修详情</label>
                                <textarea class="form-control" name="smemo" rows="3"></textarea>
                            </div>
                            
                            <%
                                java.util.Date now = new java.util.Date();
                                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                String sdate = sdf.format(now);
                            %>
                            <input type="hidden" name="sdate" value="<%=sdate%>">
                            <input type="hidden" name="status" value="等待处理">
                            <input type="hidden" name="maintainer" 
                                value="${customAccount.username}">
                            
                            <div class="form-section mt-4">
                                <button type="submit" class="btn btn-primary submit-btn">
                                    <i class="fas fa-paper-plane me-2"></i>提交
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>