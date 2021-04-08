<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	session.invalidate(); // 기존의 세션을 초기화(기존의 로그인 정보도 사라지게 된다.)
	response.sendRedirect(request.getContextPath()+"/adminIndex.jsp"); // 작업 수행 후 index page 다시 호출
%>