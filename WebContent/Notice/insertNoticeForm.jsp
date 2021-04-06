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
	
	String managerId = manager.getManagerId(); //세션에서 불러온 매니저값을 이용해 아이디 저장
%>

		<table class="table-hover">
			<tr>
				<td>noticeTitle</td>
				<td><input type="text" name="noticeTitle" class="form-control"></td>				
			</tr>
			<tr>
				<td>noticeContent</td>
				<td>
					<textarea rows="10" cols="50" name="noticeContent" class="form-control"></textarea>
				</td>
			</tr>
		</table>
		<input type="hidden" name="managerId" value="<%=managerId%>">
