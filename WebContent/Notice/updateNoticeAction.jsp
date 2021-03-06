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
	
	request.setCharacterEncoding("UTF-8"); //파라미터를 받아 올 때 인코딩 형식을 UTF-8로 설정
	Notice notice = new Notice();
	notice.setNoticeNo(Integer.parseInt(request.getParameter("noticeNo")));
	notice.setNoticeTitle(request.getParameter("noticeTitle"));
	notice.setNoticeContent(request.getParameter("noticeContent"));
	
	//디버깅 코드
	System.out.println(notice.getNoticeNo()+"수정");
	System.out.println(notice.getNoticeTitle()+"수정");
	System.out.println(notice.getNoticeContent()+"수정");
	
	NoticeDao.updateNotice(notice); // 공지수정 메서드 실행
	response.sendRedirect(request.getContextPath()+"/Notice/noticeOne.jsp?noticeNo="+notice.getNoticeNo()); // 공지 수정 후 해당 공지 다시 출력

%>
