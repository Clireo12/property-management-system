package com.cissst.servlet;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cissst.entity.CustomAccount;
import com.cissst.entity.Maintain;
import com.cissst.service.ICustomAccountService;
import com.cissst.service.IMaintainService;
import com.cissst.service.impl.CustomAccountServiceImpl;
import com.cissst.service.impl.MaintainServiceImpl;

public class MaintainServlet extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8;");
		String action = request.getParameter("action");
		IMaintainService maintainService = new MaintainServiceImpl();
		ICustomAccountService ca = new CustomAccountServiceImpl();
		if("maintainList".equals(action)){
			List<Maintain> list =  maintainService.findAllMaintains();
			request.setAttribute("maintains", list);
			System.out.print(list);
			RequestDispatcher rd = request.getRequestDispatcher("maintain/maintain-list.jsp");
			rd.forward(request, response);
		}
		else if("maintainAdd".equals(action)){
			String thing = request.getParameter("thing");
			String status = request.getParameter("status");
			String num = request.getParameter("num");
			String sdate = request.getParameter("sdate");
			String rdate = request.getParameter("rdate");
			String tcost = request.getParameter("tcost");
			String scost = request.getParameter("scost");
			String maintainer = request.getParameter("maintainer");
			String smemo = request.getParameter("smemo");
			
			Double tt,st;
			if(tcost==null){tt=(double)0.0;}else{tt = Double.parseDouble(tcost);}
			if(scost==null||scost.equals("")){st=(double)0.0;}else{ st = Double.parseDouble(scost);}
			Maintain m = new Maintain();
			
			m.setThing(thing);
			m.setStatus(status);
			m.setNum(num);
			m.setSdate(sdate);
			m.setRdate(rdate);
			m.setTcost(tt);
			m.setScost(st);
			m.setMaintainer(maintainer);
			m.setSmemo(smemo);
			
			maintainService.save(m);
			
			response.sendRedirect("main?action=maintainList");
			return;
		}else if("findById".equals(action)){
			String id = request.getParameter("id");
			
			Maintain a = maintainService.findById(id);
			
			request.setAttribute("maintain", a);
			
			RequestDispatcher rd = request.getRequestDispatcher("maintain/maintain-edit.jsp");
			rd.forward(request, response);
			
			
		}else if("maintainUpdate".equals(action)){
			int id = Integer.parseInt(request.getParameter("id"));
			String thing = request.getParameter("thing");
			String status = request.getParameter("status");
			String num = request.getParameter("num");
			String sdate = request.getParameter("sdate");
			String rdate = request.getParameter("rdate");
			String tcost = request.getParameter("tcost");
			String scost = request.getParameter("scost");
			String maintainer = request.getParameter("maintainer");
			String smemo = request.getParameter("smemo");
			
			Double tt,st;
			if(tcost==null){tt=(double)0.0;}else{tt = Double.parseDouble(tcost);}
			if(scost==null||scost.equals("")){st=(double)0.0;}else{st = Double.parseDouble(scost);}
			Maintain m = new Maintain();
			m.setId(id);
			m.setThing(thing);
			m.setStatus(status);
			m.setNum(num);
			m.setSdate(sdate);
			m.setRdate(rdate);
			m.setTcost(tt);
			m.setScost(st);
			m.setMaintainer(maintainer);
			m.setSmemo(smemo);
			
			maintainService.update(m);
			
			response.sendRedirect("main?action=maintainList");
		}else if("maintainDelete".equals(action)){
			String id = request.getParameter("id");
			maintainService.delete(id);
			response.sendRedirect("main?action=maintainList");
		}
		else if("maintainUserList".equals(action)){
			String maintainer = request.getParameter("username");
			List<Maintain> list =  maintainService.findByMaintainer(maintainer);
			request.setAttribute("maintains", list);
			RequestDispatcher rd = request.getRequestDispatcher("maintain/user-maintain-list.jsp");
			rd.forward(request, response);
		}
		else if("maintainUserAdd".equals(action)){
		    String thing = request.getParameter("thing");
		    String status = request.getParameter("status");
		    String num = request.getParameter("num");
		    String sdate = request.getParameter("sdate");
		    String rdate = request.getParameter("rdate");
		    String tcost = request.getParameter("tcost");
		    String scost = request.getParameter("scost");
		    String maintainer = request.getParameter("maintainer");
		    String smemo = request.getParameter("smemo");
		    
		    if(sdate == null || sdate.isEmpty() || thing == null || thing.isEmpty()){
		        // 如果必填字段为空，返回添加页面
		        RequestDispatcher rd = request.getRequestDispatcher("maintain/user-maintain-add.jsp");
		        rd.forward(request, response);
		        return;
		    }
		    
		    Double tt = (tcost == null || tcost.isEmpty()) ? 0.0 : Double.parseDouble(tcost);
		    Double st = (scost == null || scost.isEmpty()) ? 0.0 : Double.parseDouble(scost);
		    
		    Maintain m = new Maintain();
		    m.setThing(thing);
		    m.setStatus(status);
		    m.setNum(num);
		    m.setSdate(sdate);
		    m.setRdate(rdate);
		    m.setTcost(tt);
		    m.setScost(st);
		    m.setMaintainer(maintainer);
		    m.setSmemo(smemo);
		    
		    maintainService.save(m);
		    
		    // 确保使用正确的重定向路径
		    String contextPath = request.getContextPath();
		    response.sendRedirect(contextPath + "/main?action=maintainUserList&username=" + java.net.URLEncoder.encode(maintainer, "UTF-8"));
		}else if("maintainUserDelete".equals(action)){
		    String id = request.getParameter("id");
		    String username = request.getParameter("username");
		    
		    // 执行删除操作
		    maintainService.delete(id);
		    
		    // 重定向回用户报修列表页面
		    String contextPath = request.getContextPath();
		    response.sendRedirect(contextPath + "/main?action=maintainUserList&username=" + java.net.URLEncoder.encode(username, "UTF-8"));
		}else if("maintainSearch".equals(action)){
			
			String keyword = request.getParameter("keyword");
		    List<Maintain> maintains = maintainService.searchMaintains(keyword); // ����������� JSP ����һ��
		    
		    // �������� maintains ���ԣ����� JSP �޷���ȡ����
		    request.setAttribute("maintains", maintains); 
		    request.setAttribute("keyword", keyword); // ��ѡ������������
		    
		    RequestDispatcher rd = request.getRequestDispatcher("maintain/maintain-list.jsp");
		    rd.forward(request, response);
		
		}else if ("maintainUserSearch".equals(action)) {
		    String keyword = request.getParameter("keyword");
		    String username = request.getParameter("username");
		    
		    List<Maintain> list=null;
		    if (keyword != null && !keyword.trim().isEmpty()) {
		        list = maintainService.searchMaintainsByUser(username, keyword);
		  
		    }
		    
		    request.setAttribute("maintains", list);
		    request.setAttribute("keyword", keyword);
		    
		    RequestDispatcher rd = request.getRequestDispatcher("maintain/user-maintain-list.jsp");
		    rd.forward(request, response);
		}
	
	}

}
