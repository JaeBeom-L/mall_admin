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
	
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String managerId = request.getParameter("managerId");
	
	System.out.println(managerId+"댓글 아이디");
	System.out.println(manager.getManagerId()+"로그인 아이디");
	
	if(manager.getManagerLevel() >1 ){   // 매니저 레벨이 2라면 그냥 삭제가능
		CommentDao.deleteComment(commentNo);
	}else if(manager.getManagerLevel()>0){ // 매니저 레벨이 1이라면 아이디가 같으면 삭제 가능
		CommentDao.deleteComment(commentNo, managerId);
	}else if(!manager.getManagerId().equals(managerId)){ // 매니저 아이디가 다르다면 삭제 불가능
		System.out.println("권한이 없어서 삭제 불가능");
		response.sendRedirect(request.getContextPath()+"/Notice/noticeOne.jsp?noticeNo="+noticeNo);
	}
	
	response.sendRedirect(request.getContextPath()+"/Notice/noticeOne.jsp?noticeNo="+noticeNo);
%>