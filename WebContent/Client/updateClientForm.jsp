<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.dao.*" %>
<%@ page import="gd.mall.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateClientForm</title>
</head>
<body>
<%
	Manager manager =(Manager)session.getAttribute("sessionManager"); // 매니저가 값이 없거나 레벨이 1보다 작다면 adminIndex로그인페이지로 돌아간다.
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}

	int clientNo = Integer.parseInt(request.getParameter("clientNo")); // 수정버튼으로 고객이메일을 받아온다.
	Client client = (Client)(ClientDao.clientInformation(clientNo));
%>

	<h1>고객 정보 수정</h1>
	<form method="post" action="<%=request.getContextPath()%>/Client/updateClientAction.jsp">
		<table border="1">
			<tr>
				<td>clientNo</td>
				<td>clientEmail</td>
				<td>clientPw</td>	
				<td>clientDate</td>			
			</tr>
			
			<tr>
				<td><input type="text" name="clientNo" readonly="readonly" value="<%=client.getClientNo()%>"></td>
				<td><%=client.getClientEmail() %></td>
				<td><input type="text" name="clientPw"></td>
				<td><%=client.getClientDate() %></td>			
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>