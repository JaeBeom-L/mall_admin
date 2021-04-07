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

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>clientList</title>

    <!-- Custom fonts for this template -->
    <link href="<%=request.getContextPath()%>/Bootstrap/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="<%=request.getContextPath()%>/Bootstrap/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <link href="<%=request.getContextPath()%>/Bootstrap/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
</head>
<body>
	
	<%
		//현재 페이지
		int currentPage = 1;
		if(request.getParameter("currentPage") != null){
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		//이메일 검색 받는 변수
		String searchWord = "";
		if(request.getParameter("searchWord") != null){
			searchWord=request.getParameter("searchWord");
		}
		
		//페이지당 행의수
		int rowPerPage = 10;
		if(request.getParameter("rowPerPage") != null){
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		}
		
		//시작 행
		int beginRow = (currentPage - 1) * rowPerPage;
		ArrayList<Client> list = ClientDao.clientList(beginRow, rowPerPage, searchWord);
		
		//총 행의 수
		int totalRow = ClientDao.totalRow(searchWord);
		
		// 마지막 페이지
		int lastPage = totalRow/rowPerPage;
		if((totalRow % rowPerPage) != 0){
			lastPage +=1;
		}
		

	%>
	<!-- Page Wrapper -->
   	<div id="wrapper">
	<!-- adminMenu -->
	<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	<!-- Content Wrapper -->
   	<div id="content-wrapper" class="d-flex flex-column">

  		 <!-- Main Content -->
      	 <div id="content">
			<jsp:include page="/inc/adminTopBar.jsp"></jsp:include>
			
			<!-- Begin Page Content -->
            <div class="container-fluid">
				
				<!-- DataTales Example -->
              	<div class="card shadow mb-4">
              		<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary">clientList</h6>
					</div>
					
					
					<div class="card-body">
						<form action="<%=request.getContextPath()%>/Client/clientList.jsp" method="post"> <!-- 화면에 보고 싶은 행만큼 출력 할 수 있도록 설정 -->
							<input type="hidden" name="searchWord" value="<%=searchWord%>"><!-- searchWord도 같이 넘겨준다 -->
							<div class="row">
								<div class="col-sm-1">
									<select name="rowPerPage" class="custom-select">
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
								</div>
								<button type="submit" class="btn btn-outline-primary">보기</button>
							</div>
						</form>
						<br>
						<div class="table-responsive">
							<table class="table table-hover"><!-- 리스트 출력 -->
								<thead class="thead-light">
									<tr>
										<th>clientEmail</th>
										<th>clientDate</th>
										<th>수정</th>
										<th>삭제</th>
									</tr>
								</thead>
								
								<%
									for(Client c : list){
								%>
									<tr>
										<td><%=c.getClientEmail() %></td>
										<td><%=c.getClientDate()%></td>
										<td><a href="<%=request.getContextPath()%>/Client/updateClientForm.jsp?clientNo=<%=c.getClientNo() %>"><button class="btn btn-outline-primary">수정</button></a></td>
										<td><a href="<%=request.getContextPath()%>/Client/deleteClientAction.jsp?clientNo=<%=c.getClientNo()%>"><button class="btn btn-outline-primary">삭제</button></a></td>
									</tr>
								<%			
									}
									
								%>
								
							</table>
								<!-- 페이지 이동 -->
								<%
									if(currentPage == 1 && totalRow>rowPerPage){// 첫 페이지 일 때
								%>
										<a href="<%=request.getContextPath()%>/Client/clientList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Client/clientList.jsp?currentPage=<%=currentPage%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Client/clientList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">▶</button>
										</a>
										<a href="<%=request.getContextPath()%>/Client/clientList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">▶▶</button>
										</a>
								
								<%	
									}else if(totalRow<=rowPerPage){ // 총 행의 수가 보려는 페이지 수 보다 작을 때 게시물 수가 많아지면 필요없다
								%>	
										<a href="<%=request.getContextPath()%>/Client/clientList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Client/clientList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Client/clientList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">▶</button>
										</a>
										<a href="<%=request.getContextPath()%>/Client/clientList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">▶▶</button>
										</a>
								
								<%
									}else if(currentPage == lastPage){ //마지막 페이지 일 때
								%>
										<a href="<%=request.getContextPath()%>/Client/clientList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Client/clientList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Client/clientList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">▶</button>
										</a>
										<a href="<%=request.getContextPath()%>/Client/clientList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">▶▶</button>
										</a>					
								<%
									}else{ //평상시
								%>
										<a href="<%=request.getContextPath()%>/Client/clientList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Client/clientList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Client/clientList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">▶</button>
										</a>
										<a href="<%=request.getContextPath()%>/Client/clientList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">▶▶</button>
										</a>				
								<%		
									}
								%>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!--footer-->
	<div>
		<jsp:include page="/inc/adminFooter.jsp"></jsp:include>
	</div>
</body>
</html>