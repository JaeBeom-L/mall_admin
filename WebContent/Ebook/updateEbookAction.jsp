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
	
	String categoryName = request.getParameter("categoryName");
	String ebookAuthor = request.getParameter("ebookAuthor");
	String ebookCompany = request.getParameter("ebookCompany");
	String ebookISBN = request.getParameter("ebookISBN");
	int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
	int ebookPrice = Integer.parseInt(request.getParameter("ebookPrice"));
	
	System.out.println(categoryName+"전체수정"); //디버깅코드
	System.out.println(ebookAuthor+"전체수정"); //디버깅코드
	System.out.println(ebookCompany+"전체수정"); //디버깅코드
	System.out.println(ebookISBN+"전체수정"); //디버깅코드
	System.out.println(ebookPageCount+"전체수정"); //디버깅코드
	System.out.println(ebookPrice+"전체수정"); //디버깅코드
	
	Ebook ebook = new Ebook();
	ebook.setCategoryName(categoryName);
	ebook.setCategoryName(categoryName);
	ebook.setCategoryName(categoryName);
	ebook.setCategoryName(categoryName);
	ebook.setCategoryName(categoryName);
	ebook.setEbookPrice(ebookPrice);
	EbookDao.updateEbook(ebook); //전체 수정 메서드 실행
	
	response.sendRedirect(request.getContextPath()+"/Ebook/ebookOne.jsp?ebookISBN="+ebookISBN); // 작업 완료후 ISBN에 맞는 ebookOne페이지로 돌아간다.
%>
