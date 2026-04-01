package com.cissst.servlet;

import java.io.IOException;
import java.util.List;
import java.util.regex.Pattern;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cissst.entity.Admin;
import com.cissst.service.IAdminService;
import com.cissst.service.impl.AdminServiceImpl;
import com.cissst.util.MD5Util;

public class AdminServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8;");
		String action = request.getParameter("action");
		IAdminService adminService = new AdminServiceImpl();

		if ("adminList".equals(action)) {
			List<Admin> list = adminService.findAlladmins();
			request.setAttribute("admins", list);
			RequestDispatcher rd = request.getRequestDispatcher("admin/admin-list.jsp");
			rd.forward(request, response);

		} else if ("adminAdd".equals(action)) {
			// 获取表单数据
			String name = request.getParameter("name");
			String password = request.getParameter("password");
			String confirmPassword = request.getParameter("password2"); // 确认密码
			String sex = request.getParameter("sex");
			String age = request.getParameter("age");
			String tel = request.getParameter("tel");
			String phone = request.getParameter("phone");
			String addr = request.getParameter("addr");
			String memo = request.getParameter("memo");

			// 验证密码
			boolean isValid = true;
			String errorMsg = "";

			// 验证密码是否为空
			if (password == null || password.trim().isEmpty()) {
				errorMsg = "请输入密码";
				isValid = false;
			}
			// 验证密码长度
			else if (password.length() < 6) {
				errorMsg = "密码长度必须至少6位";
				isValid = false;
			}
			// 验证密码格式
			else if (!Pattern.matches("^[a-z0-9_]+$", password)) {
				errorMsg = "密码只能包含字母、数字或下划线";
				isValid = false;
			}
			// 验证两次密码是否一致
			else if (!password.equals(confirmPassword)) {
				errorMsg = "两次输入的密码不一致";
				isValid = false;
			}

			if (!isValid) {
				request.setAttribute("errorMsg", errorMsg);
				RequestDispatcher rd = request.getRequestDispatcher("admin/admin-add.jsp");
				rd.forward(request, response);
				return;
			}

			// 密码验证通过，继续处理
			Number ag = Integer.parseInt(age);
			String encryptedPassword = MD5Util.encode(password);

			Admin a = new Admin();
			a.setName(name);
			a.setPassword(encryptedPassword);
			a.setSex(sex);
			a.setAge(ag);
			a.setTel(tel);
			a.setPhone(phone);
			a.setAddr(addr);
			a.setMemo(memo);

			adminService.save(a);

			response.sendRedirect("admin?action=adminList");

		} else if ("findById".equals(action)) {
			String id = request.getParameter("id");

			Admin a = adminService.findById(id);

			request.setAttribute("admin", a);

			RequestDispatcher rd = request.getRequestDispatcher("admin/admin-edit.jsp");
			rd.forward(request, response);
		}else if("adminSearch".equals(action)) {
			// 获取搜索参数
	        String keyword = request.getParameter("keyword");
	        
	        // 调用服务层方法
	        List<Admin> list;
	        if(keyword != null && !keyword.trim().isEmpty()) {
	            list = adminService.searchAdmins(keyword);
	        } else {
	            list = adminService.findAlladmins();
	        }
	        
	        // 将结果和搜索条件传回页面
	        request.setAttribute("keyword", keyword);
	        request.setAttribute("admins", list);
	        
	        RequestDispatcher rd = request.getRequestDispatcher("admin/admin-list.jsp");
	        rd.forward(request, response);
		
		} else if ("adminEdit".equals(action)) {
			int id = Integer.parseInt(request.getParameter("id"));
			String name = request.getParameter("name");
			String password = request.getParameter("password");
			String confirmPassword = request.getParameter("password2"); // 确认密码
			String sex = request.getParameter("sex");
			String age = request.getParameter("age");
			String tel = request.getParameter("tel");
			String phone = request.getParameter("phone");
			String addr = request.getParameter("addr");
			String memo = request.getParameter("memo");

			// 验证密码
			boolean isValid = true;
			String errorMsg = "";

			// 验证密码是否为空
			if (password == null || password.trim().isEmpty()) {
				errorMsg = "请输入密码";
				isValid = false;
			}
			// 验证密码长度
			else if (password.length() < 6) {
				errorMsg = "密码长度必须至少6位";
				isValid = false;
			}
			// 验证密码格式
			else if (!Pattern.matches("^[a-z0-9_]+$", password)) {
				errorMsg = "密码只能包含字母、数字或下划线";
				isValid = false;
			}
			// 验证两次密码是否一致
			else if (!password.equals(confirmPassword)) {
				errorMsg = "两次输入的密码不一致";
				isValid = false;
			}

			if (!isValid) {
				request.setAttribute("errorMsg", errorMsg);
				Admin admin = adminService.findById(String.valueOf(id));
				request.setAttribute("admin", admin);
				RequestDispatcher rd = request.getRequestDispatcher("admin/admin-edit.jsp");
				rd.forward(request, response);
				return;
			}

			// 密码验证通过，继续处理
			int ag = Integer.parseInt(age);
			String encryptedPassword = MD5Util.encode(password);

			Admin a = new Admin();
			a.setId(id);
			a.setName(name);
			a.setPassword(encryptedPassword);
			a.setSex(sex);
			a.setAge(ag);
			a.setTel(tel);
			a.setPhone(phone);
			a.setAddr(addr);
			a.setMemo(memo);

			adminService.update(a);

			response.sendRedirect(request.getContextPath() + "/admin?action=adminList");

		} else if ("adminDelete".equals(action)) {
			String id = request.getParameter("id");
			adminService.delete(id);
			response.sendRedirect("admin?action=adminList");
		} else if ("change".equals(action)) {
			String id = request.getParameter("id");
			Admin a = adminService.findById(id);
			request.setAttribute("admin", a);
			RequestDispatcher rd = request.getRequestDispatcher("admin/adminChange.jsp");
			rd.forward(request, response);
		}
	}
}