<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.vo.*" %>
<%@ page import="gd.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	Manager manager = (Manager)session.getAttribute("sessionManager"); // 매니저가 값이 없으면 adminIndex로그인페이지로 돌아간다. 레벨2보다 작으면 리스트로 돌아간다.
	if(manager == null){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");		
	}else if(manager.getManagerLevel() < 2){
		response.sendRedirect(request.getContextPath()+"/Notice/noticeList.jsp");
		System.out.println("권한이 없습니다.");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo+"삭제"); //디버깅코드
	
	//댓글이 있는지 확인
	int rowCnt = CommentDao.selectCommentCnt(noticeNo);
	if(rowCnt==0){ // 댓글이 없으면 삭제
		NoticeDao.deleteNotice(noticeNo);
		response.sendRedirect(request.getContextPath()+"/Notice/noticeList.jsp");
	} else{ // 댓글이 있으면 삭제 불가
		System.out.printf("공지글의 댓글이 %s 개 있습니다.",rowCnt);
		response.sendRedirect(request.getContextPath()+"/Notice/noticeOne.jsp?noticeNo="+noticeNo);
	}
	
	


%>
