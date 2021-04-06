<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.vo.*" %>
<%@ page import="gd.mall.dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateNoticeForm</title>
</head>
<body>
<%
	Manager manager = (Manager)session.getAttribute("sessionManager"); // 매니저가 값이 없으면 adminIndex로그인페이지로 돌아간다. 레벨2보다 작으면 리스트로 돌아간다.
	if(manager == null){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");		
	}else if(manager.getManagerLevel() < 2){
		response.sendRedirect(request.getContextPath()+"/Notice/noticeList.jsp");
		System.out.println("권한이 없습니다.");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo")); // 넘겨 받아 온 공지글 번호
	
%>
	<!-- adminMenu -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<h1>공지수정</h1>
	<form method="post" action="<%=request.getContextPath()%>/Notice/updateNoticeAction.jsp">
		<input type="hidden" name="noticeNo" value="<%=noticeNo%>">
		<table border="1">
			<tr>
				<td>noticeTitle</td>
				<td><input type="text" name="noticeTitle"></td>
			</tr>
			
			<tr>
				<td>noticeContent</td>
				<td>
					<textarea rows="5" cols="50" name="noticeContent"></textarea>
				</td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>