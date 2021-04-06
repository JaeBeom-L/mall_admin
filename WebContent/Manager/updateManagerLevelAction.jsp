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
	//수정코드 구현
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));		// 매니저 번호와 권한레벨을 받아와 정수값으로 변환한다.
	int managerLevel = Integer.parseInt(request.getParameter("managerLevel"));
	ManagerDao.updateManagerLevel(managerNo, managerLevel);						// 레벨 변환 메서드를 실행해준다.
	System.out.println(managerNo);
	System.out.println(managerLevel);
	//dao 호출 수정 코드
	
	response.sendRedirect(request.getContextPath() + "/Manager/managerList.jsp"); //수정되면 바로 리스트에서 확인 할 수 있게한다.

%>