<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.vo.Manager" %>
<%@ page import="gd.mall.dao.ManagerDao" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	request.setCharacterEncoding("UFT-8");
	//1. 수정
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	String managerName = request.getParameter("managerName");
	//System.out.println(managerId);
	//System.out.println(managerPw);
	//System.out.println(managerName);
	
	//2-1. 중복된 아이디가 있는지 다시 매니저 등록 폼으로 넘어가도록 한다.
	String returnManagerId = ManagerDao.selectManagerId(managerId);
	if(returnManagerId != null){ //아이디가 존재
		System.out.println("중복된 아이디");
		response.sendRedirect(request.getContextPath() + "/Manager/insertManagerForm.jsp");
		return; // 응답을 보내놓아서 if문에 해당되면 끝나게 하기 위해 return을 쓴다.
	}
	//2-2. 매니저를 등록
	ManagerDao.insertManager(managerId, managerPw, managerName);

	//3 출력
	
%>

<div>
	매니저 등록 성공, 승인 후 사용 가능합니다. <a href="<%=request.getContextPath()%>/adminIndex.jsp">관리자 폼</a>
</div>
</body>
</html>