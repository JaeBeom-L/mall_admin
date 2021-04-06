<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.vo.*" %>
<%@ page import="gd.mall.dao.*" %>
<%
	Manager manager =(Manager)session.getAttribute("sessionManager"); // 매니저가 값이 없거나 레벨이 1보다 작다면 adminIndex로그인페이지로 돌아간다.
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	int categoryWeight = Integer.parseInt(request.getParameter("categoryWeight")); // 카테고리 리스트 가중치 수정 값을 받아와서 저장
	
	
	CategoryDao.updateCategory(categoryWeight, categoryNo);
	System.out.println(categoryNo+"카테고리 번호"); //디버깅코드
	System.out.println(categoryWeight+"바꾸려는 가중치");//디버깅코드
	
	response.sendRedirect(request.getContextPath()+"/Category/categoryList.jsp"); // 수정 후 카테고리 리스트를 보여준다
%>
