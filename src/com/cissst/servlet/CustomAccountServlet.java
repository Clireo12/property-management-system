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
import com.cissst.entity.CustomAccount;
import com.cissst.service.ICustomAccountService;
import com.cissst.service.impl.CustomAccountServiceImpl;
import com.cissst.util.MD5Util;

public class CustomAccountServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		ICustomAccountService ca = new CustomAccountServiceImpl();
		if ("customAccountList".equals(action)) {
			List<CustomAccount> list = ca.findAllcustomAccount();
			request.setAttribute("customAccounts", list);
			RequestDispatcher rd = request.getRequestDispatcher("customAccount/custom-list.jsp");
			rd.forward(request, response);

		} else if ("customAccountAdd".equals(action)) {
			String username = request.getParameter("username");
			String password = MD5Util.encode(request.getParameter("password"));
			String ownerid = request.getParameter("ownerid");
			String carid = request.getParameter("carid");

			CustomAccount c = new CustomAccount();
			c.setUsername(username);
			c.setPassword(password);
			c.setOwnerid(ownerid);
			c.setCarid(carid);

			ca.save(c);

			response.sendRedirect("custom?action=customAccountList");
		} else if ("findById".equals(action)) {
			String accountid = request.getParameter("accountid");
			CustomAccount c = ca.findById(accountid);
			request.setAttribute("customAccount", c);

			RequestDispatcher rd = request.getRequestDispatcher("customAccount/custom-edit.jsp");
			rd.forward(request, response);

		} else if ("findById2".equals(action)) {
			String accountid = request.getParameter("accountid");
			CustomAccount c = ca.findById(accountid);
			request.setAttribute("customAccount", c);
			RequestDispatcher rd = request.getRequestDispatcher("customAccount/user-custom-list.jsp");
			rd.forward(request, response);

			
		}else if ("customAccountSearch".equals(action)) {
			    String keyword = request.getParameter("keyword");
			    
			    List<CustomAccount> list;
			    
			        list = ca.searchCustomAccounts(keyword);
			    
			    
			    request.setAttribute("customAccounts", list);
			    request.setAttribute("keyword", keyword);
			    
			    RequestDispatcher rd = request.getRequestDispatcher("customAccount/custom-list.jsp");
			    rd.forward(request, response);
			
			
		} else if ("customAccountEdit".equals(action)) {
			int accountid = Integer.parseInt(request.getParameter("accountid"));
			String username = request.getParameter("username");
			String password = MD5Util.encode(request.getParameter("password"));
			String ownerid = request.getParameter("ownerid");
			String carid = request.getParameter("carid");

			CustomAccount c = new CustomAccount();

			c.setAccountid(accountid);
			c.setUsername(username);
			c.setPassword(password);
			c.setOwnerid(ownerid);
			c.setCarid(carid);

			ca.update(c);
			response.sendRedirect("custom?action=customAccountList");
		} else if ("customAccountDelete".equals(action)) {
			String accountid = request.getParameter("accountid");
			ca.delete(accountid);
			response.sendRedirect("custom?action=customAccountList");
		} else if ("change".equals(action)) {
			// GET请求，显示修改密码页面
			String accountid = request.getParameter("accountid");
			CustomAccount c = ca.findById(accountid);
			request.setAttribute("customAccount", c);
			RequestDispatcher rd = request.getRequestDispatcher("customAccount/user-change-passwd.jsp");
			rd.forward(request, response);
		} else if ("updatePassword".equals(action)) {
		    // POST请求，处理密码修改
		    String accountid = request.getParameter("accountid");
		    String newPassword = request.getParameter("password");
		    String confirmPassword = request.getParameter("password2");

		    // 清除之前的错误信息
		    request.removeAttribute("errorMsg");
		    request.removeAttribute("successMsg");

		    // 验证密码
		    boolean isValid = true;
		    String errorMsg = "";

		    // 验证新密码
		    if (newPassword == null || newPassword.trim().isEmpty()) {
		        errorMsg = "请输入新密码";
		        isValid = false;
		    } else if (newPassword.length() < 6 ) {
		        errorMsg = "密码长度必须为6位以上";
		        isValid = false;
		    } else if (!Pattern.matches("^[a-z0-9_]+$", newPassword)) {
		        errorMsg = "密码只能包含字母、数字或下划线";
		        isValid = false;
		    } else if (!newPassword.equals(confirmPassword)) {
		        errorMsg = "两次输入的密码不一致";
		        isValid = false;
		    }

		    if (isValid) {
		        // 对密码进行MD5加密
		        String encryptedPassword = MD5Util.encode(newPassword);

		        // 获取当前用户信息
		        CustomAccount c = ca.findById(accountid);
		        // 只更新密码，保留其他信息不变
		        c.setPassword(encryptedPassword);

		        // 更新数据库
		        ca.update(c);

		        // 返回成功信息
		        request.setAttribute("successMsg", "密码修改成功！");
		    } else {
		        request.setAttribute("errorMsg", errorMsg);
		    }

		    // 重新显示修改密码页面
		    CustomAccount c = ca.findById(accountid);
		    request.setAttribute("customAccount", c);
		    RequestDispatcher rd = request.getRequestDispatcher("customAccount/user-change-passwd.jsp");
		    rd.forward(request, response);
		} else if ("customAccountUserEdit".equals(action)) {
			int accountid = Integer.parseInt(request.getParameter("accountid"));
			String username = request.getParameter("username");
			String password = MD5Util.encode(request.getParameter("password"));
			String ownerid = request.getParameter("ownerid");
			String carid = request.getParameter("carid");

			CustomAccount c = new CustomAccount();

			c.setAccountid(accountid);
			c.setUsername(username);
			c.setPassword(password);
			c.setOwnerid(ownerid);
			c.setCarid(carid);

			ca.update(c);
			response.sendRedirect("custom?action=findById2&accountid=" + accountid);
		}
	}
}
