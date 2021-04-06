<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.dao.*"%>
<%@ page import="gd.mall.vo.*" %>
<%
	Manager manager =(Manager)session.getAttribute("sessionManager"); // 매니저가 값이 없거나 레벨이 1보다 작다면 adminIndex로그인페이지로 돌아간다.
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	request.setCharacterEncoding("UTF-8"); // 받아 올 때 올바른 인코딩으로 받아온다.
	
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookSummary = request.getParameter("ebookSummary");
	
	System.out.println(ebookISBN+"요약"); //디버깅코드
	System.out.println(ebookSummary+"요약"); //디버깅코드
	
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookSummary(ebookSummary);
	EbookDao.updateEbookSummary(ebook); // 요약 수정 메서드 실행
	
	response.sendRedirect(request.getContextPath()+"/Ebook/ebookOne.jsp?ebookISBN="+ebookISBN);
%>