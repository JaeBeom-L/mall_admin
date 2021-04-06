<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.dao.*"%>
<%@ page import="gd.mall.vo.*" %>
<%
	Manager manager =(Manager)session.getAttribute("sessionManager"); // 매니저가 값이 없거나 레벨이 1보다 작다면 adminIndex로그인페이지로 돌아간다.
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	String ebookISBN = request.getParameter("ebookISBN");
	
	System.out.println(ebookISBN+"삭제"); //디버깅 코드
	
	EbookDao.deleteEbook(ebookISBN);
	response.sendRedirect(request.getContextPath()+"/Ebook/ebookList.jsp"); // 작업 완료후 ebookList페이지로 돌아간다.
%>
