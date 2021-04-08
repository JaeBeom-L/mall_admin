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
	request.setCharacterEncoding("UTF-8"); //파라미터를 받아 올 떄 인코딩을 UTF-8로 설정
	
	Notice notice = new Notice();
	notice.setNoticeTitle(request.getParameter("noticeTitle"));
	notice.setNoticeContent(request.getParameter("noticeContent"));
	notice.setManagerId(request.getParameter("managerId"));
	
	//디버깅 코드
	System.out.println(notice.getNoticeTitle()+"공지제목");
	System.out.println(notice.getNoticeContent()+"공지내용");
	System.out.println(notice.getManagerId()+"관리자아이디");
	
	NoticeDao.insertNotice(notice); // 공지 입력 메서드 실행
	response.sendRedirect(request.getContextPath()+"/Notice/noticeList.jsp"); // 작업 수행 후 notcieList 페이지 출력
%>
