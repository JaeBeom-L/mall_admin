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
	request.setCharacterEncoding("UTF-8");
	Comment comment = new Comment(); //Comment 변수 comment 초기화
	
	
	comment.setCommentContent(request.getParameter("commentContent")); 
	comment.setManagerId(request.getParameter("managerId"));
	comment.setNoticeNo(Integer.parseInt(request.getParameter("noticeNo")));
	
	System.out.println(comment.getCommentContent()+"댓글 내용");
	System.out.println(comment.getManagerId()+"댓글 아이디");
	System.out.println(comment.getNoticeNo()+"공지 번호");
	
	CommentDao.insertComment(comment); // 댓글 입력 메서드 실행
	
	response.sendRedirect(request.getContextPath()+"/Notice/noticeOne.jsp?noticeNo="+comment.getNoticeNo()); // 실행 후 다시 그 공지로 돌아온다.
%>
