<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.dao.*"%>
<%@ page import="gd.mall.vo.*" %>
<%
	Manager manager =(Manager)session.getAttribute("sessionManager"); // 매니저가 값이 없거나 레벨이 1보다 작다면 adminIndex로그인페이지로 돌아간다.
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	int clientNo = Integer.parseInt(request.getParameter("clientNo")); //고객 번호를 받아온다.
	ClientDao.deleteClientList(clientNo); // 삭제 메서드 실행
	
	response.sendRedirect(request.getContextPath() + "/Client/clientList.jsp"); //작업 완료 후 다시 고객리스트로 간다.

%>