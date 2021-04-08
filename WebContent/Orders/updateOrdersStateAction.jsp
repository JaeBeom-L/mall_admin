<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.vo.*" %>
<%@ page import="gd.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	Manager manager =(Manager)session.getAttribute("sessionManager"); // 매니저가 값이 없거나 레벨이 1보다 작다면 adminIndex로그인페이지로 돌아간다.
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}

	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	
	System.out.println(ordersNo+"주문취소 액션 주문번호");
	OrdersDao.updateOrdersState(ordersNo);//주문 취소 메서드 실행
	response.sendRedirect(request.getContextPath()+"/Orders/ordersList.jsp");  // 작업 수행 후 주문리스트 출력
%>
