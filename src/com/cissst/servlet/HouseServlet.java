package com.cissst.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cissst.entity.House;
import com.cissst.service.IHouseService;
import com.cissst.service.impl.HouseServiceImpl;

public class HouseServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		IHouseService ihs = new HouseServiceImpl();
		if ("houseList".equals(action)) {
			List<House> list = ihs.findAllHouse();
			request.setAttribute("houses", list);
			RequestDispatcher rd = request.getRequestDispatcher("house/house-list.jsp");
			rd.forward(request, response);

		} else if("houseAdd".equals(action)){
			System.out.print("houseAdd");
			// int id = Integer.parseInt(request.getParameter("id"));
			String num = request.getParameter("num");
			String dep = request.getParameter("dep");
			String kind = request.getParameter("kind");
			String area = request.getParameter("area");
			String sell = request.getParameter("sell");
			String unit = request.getParameter("unit");
			String floor = request.getParameter("floor");
			String direction = request.getParameter("direction");
			String memo = request.getParameter("memo");
			String ownerid = request.getParameter("ownerid");

			House h = new House();
			// h.setId(id);
			h.setNum(num);
			h.setDep(dep);
			h.setKind(kind);
			h.setArea(area);
			h.setSell(sell);
			h.setUnit(unit);
			h.setFloor(floor);
			h.setDirection(direction);
			h.setMemo(memo);
			h.setOwnerid(ownerid);

			ihs.add(h);

			response.sendRedirect("house?action=houseList");
		} else if ("findByOwnerid".equals(action)) {
			String ownerid = request.getParameter("ownerid");
			System.out.print("ownerid"+ownerid);
			List<House> list = ihs.findByOwnerid(ownerid);
			System.out.print(list);
			request.setAttribute("houses", list);

			RequestDispatcher rd = request.getRequestDispatcher("house/user-house-list.jsp");
			rd.forward(request, response);

		} else if ("houseEdit".equals(action)) {
			// 编辑时需要ID，但从隐藏域获取（而非手动输入）
			String idStr = request.getParameter("id");
			if (idStr == null || idStr.trim().isEmpty()) {
				request.setAttribute("error", "数据错误：未找到ID");
				RequestDispatcher rd = request.getRequestDispatcher("house/house-edit.jsp");
				rd.forward(request, response);
				return;
			}

			int id;
			try {
				id = Integer.parseInt(idStr); // 转换ID（从隐藏域来，通常不会为空）
			} catch (NumberFormatException e) {
				request.setAttribute("error", "数据错误：ID格式异常");
				RequestDispatcher rd = request.getRequestDispatcher("house/house-edit.jsp");
				rd.forward(request, response);
				return;
			}

			String num = request.getParameter("num");
			String dep = request.getParameter("dep");
			String kind = request.getParameter("kind");
			String area = request.getParameter("area");
			String sell = request.getParameter("sell");
			String unit = request.getParameter("unit");
			String floor = request.getParameter("floor");
			String direction = request.getParameter("direction");
			String memo = request.getParameter("memo");
			String ownerid = request.getParameter("ownerid");
			House h = new House();

			h.setNum(num);
			h.setId(id); // 编辑时需要ID定位数据
			h.setDep(dep);
			h.setKind(kind);
			h.setArea(area);
			h.setSell(sell);
			h.setUnit(unit);
			h.setFloor(floor);
			h.setDirection(direction);
			h.setMemo(memo);
			h.setOwnerid(ownerid);

			try{
				ihs.update(h);
				response.sendRedirect("house?action=houseList");
			}catch(Exception e){
				request.setAttribute("error", "编辑失败：" + e.getMessage());
				RequestDispatcher rd = request.getRequestDispatcher("house/house-edit.jsp");
				rd.forward(request, response);
			}

		} else if ("houseDelete".equals(action)) {
			 String id = request.getParameter("id");
			    if (id == null || id.trim().isEmpty()) {
			        request.setAttribute("error", "删除失败：未找到ID");
			        response.sendRedirect("house?action=houseList");
			        return;
			    }

			    try {
			        House house = ihs.findById(id);
			        if ("已售".equals(house.getSell())) {
			            request.getSession().setAttribute("error", "无法删除：该房产已售出");
			        } else {
			            ihs.delete(id);
			            request.getSession().setAttribute("message", "删除成功");
			        }
			    } catch (Exception e) {
			        request.getSession().setAttribute("error", "删除失败：" + e.getMessage());
			    }
			    response.sendRedirect("house?action=houseList");
		} else if ("findById".equals(action)) {
			String id = request.getParameter("id");

			House h = ihs.findById(id);

			request.setAttribute("house", h);

			RequestDispatcher rd = request.getRequestDispatcher("house/house-edit.jsp");
			rd.forward(request, response);

		} else if ("houseSearch".equals(action)) {
			String keyword = request.getParameter("keyword");
			
			System.out.println("���յ��Ĺؼ���: " + keyword);

			List<House> houses = ihs.searchHouses(keyword);
			System.out.println("��ѯ���ļ�¼��: " + houses.size());

			request.setAttribute("houses", houses);
			request.setAttribute("keyword", keyword);

			// ���ԣ���������Ƿ����óɹ�
			System.out.println("���õ�houses����: " + request.getAttribute("houses"));
			System.out.println("���õ�keyword����: " + request.getAttribute("keyword"));

			RequestDispatcher rd = request.getRequestDispatcher("house/house-list.jsp");
			rd.forward(request, response);
			
		}
	}

}
