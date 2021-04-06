<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.vo.Manager" %>
<%@ page import="gd.mall.dao.ManagerDao" %>
<%
	Manager manager = (Manager)session.getAttribute("sessionManager"); // 매니저가 아니거나 레벨이 맞지 않으면 인덱스화면으로 돌아간다.
	if(manager == null){
		response.sendRedirect(request.getContextPath()+"adminIndex.jsp");
		return;	
	}else if(manager.getManagerLevel()<2){										// 매니저 등급을 조정하여 레벨에 맞지 않는 사람을 차단 할 수 있다.
		response.sendRedirect(request.getContextPath()+"adminIndex.jsp");
		return;	
	}
	//수정 코드 구현
	int managerNo = Integer.parseInt(request.getParameter("managerNo")); // 폼에서 받아온 매니저 번호를 받아 정수값으로 변환
	ManagerDao.deleteManager(managerNo); //매니저 삭제 메서드 실행
	System.out.print(managerNo);
	//dao 호출 수정 코드
	
	response.sendRedirect(request.getContextPath() + "/Manager/managerList.jsp"); // 삭제 실행후 바로 리스트에서 확인

%>