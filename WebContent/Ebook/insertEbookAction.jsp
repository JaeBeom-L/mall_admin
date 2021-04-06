<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.dao.*"%>
<%@ page import="gd.mall.vo.*" %>
<%
	Manager manager =(Manager)session.getAttribute("sessionManager"); // 매니저가 값이 없거나 레벨이 1보다 작다면 adminIndex로그인페이지로 돌아간다.
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	request.setCharacterEncoding("UTF-8");
	String categoryName = request.getParameter("categoryName");
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookTitle = request.getParameter("ebookTitle");
	String ebookAuthor = request.getParameter("ebookAuthor");
	String ebookCompany = request.getParameter("ebookCompany");
	int  ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
	int ebookPrice = Integer.parseInt(request.getParameter("ebookPrice"));
	String ebookSummary = request.getParameter("ebookSummary");
	//디버깅 코드
	System.out.printf("%s 카테고리, %s isbn, %s title, %s author, %s company, %d page, %d price, %s summary",categoryName,ebookISBN, ebookTitle,ebookAuthor,ebookCompany,ebookPageCount,ebookPrice,ebookSummary);
	
	Ebook ebook = new Ebook();
	ebook.setCategoryName(categoryName);
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookTitle(ebookTitle);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookPageCount(ebookPageCount);
	ebook.setEbookPrice(ebookPrice);
	ebook.setEbookSummary(ebookSummary);
		
	int result = EbookDao.checkISBN(ebookISBN);
	if( result == 1) { //중복체크 중복이면 다시 리스트로
		System.out.println("중복입니다.");
		response.sendRedirect(request.getContextPath()+"/Ebook/ebookList.jsp");
	}else{
		int rowCnt = EbookDao.insertEbook(ebook);
		response.sendRedirect(request.getContextPath()+"/Ebook/ebookList.jsp");
	}
	
	
%>