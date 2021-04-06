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
	
	//현재 페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

			
	//페이지당 행의수
	int rowPerPage = 10;
	if(request.getParameter("rowPerPage") != null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	
	// 카테고리 이름
		String categoryName = request.getParameter("categoryName");
		System.out.println(categoryName);
	
	//시작 행
	int beginRow = (currentPage - 1) * rowPerPage;
	
	// 전체 행의 개수
	int totalRow = EbookDao.totalRow(categoryName);
	
	// 마지막 페이지
	int lastPage = totalRow/rowPerPage;
	if((totalRow % rowPerPage) != 0){
		lastPage +=1;
	}
	
	// 검색 카테고리
	String searchCategory = "";
	if(request.getParameter("searchCategory")!=null){
		searchCategory=request.getParameter("searchCategory");
	}
	
	// 검색 단어
	String searchWord = "";
	if(request.getParameter("searchWord") != null){
		searchWord=request.getParameter("searchWord");
	}
	
	ArrayList<Ebook> list = EbookDao.ebookList(beginRow, rowPerPage, categoryName); //list에 페이징 메서드
	ArrayList<Ebook> searchList = EbookDao.searchList(beginRow, rowPerPage, searchCategory, searchWord); //검색 LIST
	/* String categoryName = request.getParameter("categoryName");
	System.out.println(categoryName); */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ebookList</title>
</head>
<body>
	
	<!-- adminMenu -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
		
	<!-- 카테고리별 목록을 볼 수 있는 메뉴 (네비게이션)-->
	<div>
		<a href="<%=request.getContextPath()%>/Ebook/ebookList.jsp">[전체]</a>
		<%
			ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
			for(String s : categoryNameList){
		%>
				<a href="<%=request.getContextPath()%>/Ebook/ebookList.jsp?categoryName=<%=s%>">[<%=s%>]</a>
		<%
			}
		%>
	</div>
	
	
	<h1>ebookList</h1>
	
	<!-- 화면에 보고 싶은 행만큼 출력 할 수 있도록 설정 -->
	<form action="<%=request.getContextPath()%>/Ebook/ebookList.jsp" method="post"> 
		
		<select name="rowPerPage">
			<%
				for(int i=10; i<=30; i+=5){
					if(rowPerPage == i){
			%>
					<option value="<%=i%>" selected="selected"><%=i%></option>
			<%
					}else {
			%>
					<option value="<%=i%>"><%=i%></option>
			<%			
					}
				}
			%>
		</select>
		<button type="submit">보기</button>
	</form>
	<a href = "<%=request.getContextPath()%>/Ebook/insertEbookForm.jsp"><button type="button">ebook 추가</button></a>
	<!-- rowPerPage별 페이징-->
	<table border="1">
		<thead>
			<tr>
				<th>categoryName</th>
				<th>ebookISBN</th>
				<th>ebookTitle</th>
				<th>ebookAuthor</th>
				<th>ebookDate</th>
				<th>ebookPrice</th>
			</tr>
		</thead>
		
		<tbody>						
			<%	
				for(Ebook e : searchList){
			%>
					<tr>
						<td><%=e.getCategoryName() %></td>
						<td><%=e.getEbookISBN() %></td>
						<td><a href="<%=request.getContextPath()%>/Ebook/ebookOne.jsp?ebookISBN=<%=e.getEbookISBN()%>&ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle()%></a></td>
						<td><%=e.getEbookAuthor()%></td>
						<td><%=e.getEbookDate()%></td>
						<td><%=e.getEbookPrice()%></td>
					</tr>
			<%
				}									
			%>
		</tbody>
	</table>
		<!-- 페이지 이동 -->
	<%
		if(currentPage==1 && totalRow>rowPerPage){ // 첫 페이지면 이전 버튼을 눌러도 첫 페이지
	%>
			<a href="<%=request.getContextPath()%>/Ebook/ebookList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">첫페이지</a>
			<a href="<%=request.getContextPath()%>/Ebook/ebookList.jsp?currentPage=<%=currentPage%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">이전</a>
			<a href="<%=request.getContextPath()%>/Ebook/ebookList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">다음</a>
			<a href="<%=request.getContextPath()%>/Ebook/ebookList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">마지막페이지</a>
	<%
		}else if(totalRow<=rowPerPage){ // 총 행의 수가 보려는 페이지 수 보다 작을 때 게시물 수가 많아지면 필요없다
	%>	
			<a href="<%=request.getContextPath()%>/Ebook/ebookList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">처음으로</a>
			<a href="<%=request.getContextPath()%>/Ebook/ebookList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">이전으로</a>
			<a href="<%=request.getContextPath()%>/Ebook/ebookList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">다음으로</a>
			<a href="<%=request.getContextPath()%>/Ebook/ebookList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">마지막으로</a>			
	<%
		}else if(currentPage==lastPage){ //마지막 페이지면 다음 버튼을 눌러도 마지막 페이지
	%>
			<a href="<%=request.getContextPath()%>/Ebook/ebookList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">첫페이지</a>
			<a href="<%=request.getContextPath()%>/Ebook/ebookList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">이전</a>
			<a href="<%=request.getContextPath()%>/Ebook/ebookList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">다음</a>
			<a href="<%=request.getContextPath()%>/Ebook/ebookList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">마지막페이지</a>
	<%				
		}else{ // 평상시 페이지
	%>
			<a href="<%=request.getContextPath()%>/Ebook/ebookList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">첫페이지</a>
			<a href="<%=request.getContextPath()%>/Ebook/ebookList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">이전</a>
			<a href="<%=request.getContextPath()%>/Ebook/ebookList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">다음</a>
			<a href="<%=request.getContextPath()%>/Ebook/ebookList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">마지막페이지</a>
	<%
		}
	%>
	<!-- 검색 창 구현 -->
	<form method="post" action="<%=request.getContextPath()%>/Ebook/ebookSearchList.jsp">
		<div>
			<select name="searchCategory">
				<option value="ebook_isbn">ebookISBN</option>
				<option value="ebook_title">ebookTitle</option>
			</select>
			<input type="text" name="searchWord">
			<button type="submit">검색</button>
		</div>
	</form>
</body>
</html>