<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.vo.*" %>
<%@ page import="gd.mall.dao.*" %>
<%@ page import="java.util.*" %>

	<%
		String ebookISBN = request.getParameter("ebookISBN");
		Manager manager =(Manager)session.getAttribute("sessionManager"); // 매니저가 값이 없거나 레벨이 1보다 작다면 adminIndex로그인페이지로 돌아간다.
		if(manager == null || manager.getManagerLevel() < 1){
			response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
			return;
		}
		ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
		System.out.println(categoryNameList.size()+"카테고리가 몇 개 있다.");
	%>

	
	
		<table class="table-hover">
			<tr><!-- 카테고리 -->
				<td>
					categoryName
				</td>
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
			
			<tr><!-- isbn -->
				<td>ebookISBN</td>
				<td>
					<input type="text" name="ebookISBN" class="form-control">
				</td>
			</tr>
			
			<tr><!-- title -->
				<td>ebookTitle</td>
				<td>
					<input type="text" name="ebookTitle" class="form-control">
				</td>
			</tr>			

			<tr><!-- author -->
				<td>ebookAuthor</td>
				<td>
					<input type="text" name="ebookAuthor" class="form-control">
				</td>
			</tr>				
			
			<tr><!-- company -->
				<td>ebookCompany</td>
				<td>
					<input type="text" name="ebookCompany" class="form-control">
				</td>
			</tr>		

			<tr><!-- pageCount -->
				<td>ebookPageCount</td>
				<td>
					<input type="text" name="ebookPageCount" class="form-control">
				</td>
			</tr>			
						
			<tr><!-- price -->
				<td>ebookPrice</td>
				<td>
					<input type="text" name="ebookPrice" class="form-control">
				</td>
			</tr>
			
			<tr>
				<td>ebookSummary</td>
				<td>
					<textarea rows="5" cols="40" name="ebookSummary" class="form-control"></textarea>
				</td>
			</tr>										
		</table>
	
