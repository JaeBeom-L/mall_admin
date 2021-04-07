<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.vo.*" %>
<%@ page import="gd.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	Manager manager =(Manager)session.getAttribute("sessionManager"); // 매니저가 값이 없거나 레벨이 1보다 작다면 adminIndex로그인페이지로 돌아간다.
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
	String ebookISBN = request.getParameter("ebookISBN");
	Ebook ebook = EbookDao.selectEbookOne(ebookISBN); // isbn에 맞는 정보 출력하도록 데이터를 가져온다
%>
	
	<input type="hidden" name="ebookISBN" value="<%=ebook.getEbookISBN()%>">
	<table class="table-hover">
		<tr><!-- 책 번호 -->
			<td>ebookNo</td>
			<td><%=ebook.getEbookNo()%></td>
		</tr>
		
		<tr><!-- 책  고유 ISBN -->
			<td>ebookISBN</td>
			<td><%=ebook.getEbookISBN()%></td>
		</tr>
		
		<tr><!-- 카테고리 -->
			<td>categoryName</td>
			<td>
				<select name="categoryName" class="custom-select">
					<option value="">선택</option>
					<%
						for(String cn : categoryNameList){
					%>
							<option value="<%=cn%>"><%=cn%></option>
					<%
						}
					%>
				</select>
			</td>
		</tr>
			
		<tr><!-- 저자 -->
			<td>ebookAuthor</td>
			<td>
				<input type="text" name="ebookAuthor" class="form-control">
			</td>
		</tr>
			
		<tr><!-- 출판사 -->
			<td>ebookCompany</td>
			<td>
				<input type="text" name="ebookCompany" class="form-control">
			</td>
		</tr>
			
		<tr><!-- 책 페이지 수 -->
			<td>ebookPageCount</td>
			<td>
				<input type="text" name="ebookPageCount" class="form-control">
			</td>
		</tr>
			
		<tr><!-- 가격 -->
			<td>ebookPrice</td>
			<td>
				<input type="text" name="ebookPrice" class="form-control">
			</td>
		</tr>
			
		<tr><!-- 간단한 설명 -->
			<td>ebookSummary</td>
			<td><%=ebook.getEbookSummary()%></td>
		</tr>
			
		<tr><!-- 책 사진 -->
			<td>ebookImg</td>
			<td>
				<img src="<%=request.getContextPath() %>/img/<%=ebook.getEbookImg()%>">
			</td>
		</tr>
			
		<tr><!-- 책 출판일 -->
			<td>ebookDate</td>
			<td><%=ebook.getEbookDate()%></td>
		</tr>
			
		<tr><!-- 책 상태 -->
			<td>ebookState</td>
			<td><%=ebook.getEbookState()%></td>
		</tr>
	</table>

