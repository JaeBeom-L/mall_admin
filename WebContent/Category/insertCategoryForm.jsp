<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gd.mall.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertCategoryForm</title>
</head>
<body>
<%
	Manager manager =(Manager)session.getAttribute("sessionManager"); // 매니저가 값이 없거나 레벨이 1보다 작다면 adminIndex로그인페이지로 돌아간다.
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>

	<!-- adminMenu -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	<h1>카테고리 추가</h1>
	<form method="post" action="<%=request.getContextPath()%>/Category/insertCategoryAction.jsp">
		<table border="1">			
			<tr>
				<td>category_name</td>		
				<td>
					<input type="text" name="categoryName">
				</td>				
			</tr>												
		</table>
		<button type="submit">생성</button>
	</form>

</body>
</html>