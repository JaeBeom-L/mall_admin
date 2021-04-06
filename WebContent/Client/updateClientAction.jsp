<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.dao.*" %>
<%@ page import="gd.mall.vo.*" %>
<%
	
	Manager manager =(Manager)session.getAttribute("sessionManager"); // 매니저가 값이 없거나 레벨이 1보다 작다면 adminIndex로그인페이지로 돌아간다.
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	int clientNo = Integer.parseInt(request.getParameter("clientNo"));
	String clientPw = request.getParameter("clientPw");
	ClientDao.updateClientList(clientPw, clientNo);	// 수정 메서드 호출 매겨변수(고객번호, 고객패스워드)
	
	response.sendRedirect(request.getContextPath() + "/Client/clientList.jsp"); // 작업후 고객리스트로 돌아간다.

%>
