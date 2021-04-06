<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.dao.*"%>
<%@ page import="gd.mall.vo.*" %>
<%
	request.setCharacterEncoding("UTF-8"); // 인코딩	

	Manager manager =(Manager)session.getAttribute("sessionManager"); // 매니저가 값이 없거나 레벨이 1보다 작다면 adminIndex로그인페이지로 돌아간다.
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	String categoryName = request.getParameter("categoryName");
	CategoryDao.insertCategory(categoryName);
	
	response.sendRedirect(request.getContextPath()+"/Category/categoryList.jsp"); // 수정 후 카테고리 리스트를 보여준다


%>