<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.vo.*" %>
<%@ page import="gd.mall.dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateEbookStateForm</title>
</head>
<body>
<%
	String ebookISBN = request.getParameter("ebookISBN");
	Manager manager =(Manager)session.getAttribute("sessionManager"); // 매니저가 값이 없거나 레벨이 1보다 작다면 adminIndex로그인페이지로 돌아간다.
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	Ebook ebook = new Ebook();
	ebook = EbookDao.selectEbookOne(ebookISBN);
	
%>
	
	<!-- adminMenu -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<h1>updateEbookStateForm</h1>
	<form method="post" action="<%=request.getContextPath()%>/Ebook/updateEbookStateAction.jsp">
		<input type="hidden" name="ebookISBN" value="<%=ebookISBN%>">
		<label>책 상태</label>
		<select name="ebookState">
			<option>선택</option>
			<option value="판매중">판매중</option>
			<option value="품절">품절</option>
			<option value="절판">절판</option>
			<option value="구편절판">구편절판</option>
		</select>
		<button type="submit">수정</button>
	</form>
</body>
</html>