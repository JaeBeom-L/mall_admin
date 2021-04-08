<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.vo.*" %>
<%@ page import="gd.mall.dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>searchList</title>

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
	Manager manager = (Manager)session.getAttribute("sessionManager"); // 매니저가 아니거나 레벨이 맞지 않으면 인덱스화면으로 돌아간다.
	if(manager == null){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;	
	}else if(manager.getManagerLevel()<1){										// 매니저 등급을 조정하여 레벨에 맞지 않는 사람을 차단 할 수 있다.
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;	
	}
	request.setCharacterEncoding("UTF-8"); // 파라미터를 받아 올때 인코딩을 UTF-8로
	
	// 선택한 리스트
	String searchList = null;
	if(request.getParameter("searchList") != null){
		searchList = request.getParameter("searchList");
	}
	System.out.println(searchList+"선택한 리스트");
	
	//찾을 단어
	String searchWord = null;
	if(request.getParameter("searchWord") != null){
		searchWord = request.getParameter("searchWord");
	}
	System.out.println(searchWord+"찾을 단어");
	
	//현재 페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 한 페이지당 게시물 수
	int rowPerPage = 10;
	if(request.getParameter("rowPerPage") != null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	
	//시작행
	int beginRow = (currentPage-1)*rowPerPage;
	
	// 총 게시물수
	int totalRow = SearchDao.totalRow(searchList, searchWord);
	System.out.println(totalRow+"총 게시물 수");
	
	// 마지막 페이지
	int lastPage = totalRow/rowPerPage;
	if(totalRow%rowPerPage != 0){
		lastPage +=1;
	}

	//searchList 메서드 실행해서 실행값을 list에 담는다
	ArrayList<OrdersAndEbookAndClient> list = SearchDao.searchList(beginRow, rowPerPage, searchList, searchWord);
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
              			<div class="row">
							<h6 class="m-0 font-weight-bold text-primary"><%=searchList%>&nbsp;검색단어 : &nbsp;</h6>
							<h6 class="text-secondary"><%=searchWord %></h6>
						</div>
					</div>
					
					
					<div class="card-body">
						<!-- 화면에 보고 싶은 행만큼 출력 할 수 있도록 설정 -->
						<form action="<%=request.getContextPath()%>/Search/searchList.jsp" method="post"> 				
							<div class="row">
								<input type="hidden" name="searchList" value="<%=searchList%>">
								<input type="hidden" name="searchWord" value="<%=searchWord%>">
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
						<%
							if(searchList.equals("clientList")){ // 검색하려는 정보가 고객정보 일 때 출력
						%>
								<table class="table table-hover">
								<thead class="thead-light">
									<tr>
										<th>clientEmail</th>
										<th>clientDate</th>
										<th>수정</th>
										<th>삭제</th>
									</tr>
								</thead>
								
								<tbody>
									<%
										for(OrdersAndEbookAndClient oec : list){
									%>		
											<tr>
												<td><%=oec.getClient().getClientEmail()%></td>
												<td><%=oec.getClient().getClientDate()%></td>
												<td>																
													<a href="<%=request.getContextPath()%>/Client/updateClientForm.jsp?clientNo=<%=oec.getClient().getClientNo() %>"><button class="btn btn-outline-primary">수정</button></a>									
												</td>
												<td>
													<a href="<%=request.getContextPath()%>/Client/deleteClientAction.jsp?clientNo=<%=oec.getClient().getClientNo() %>"><button class="btn btn-outline-primary">삭제</button></a>	
												</td>
											</tr>
									
									<%
										}
									%>
									</tbody>
								</table>
						
						<%
							}else if(searchList.equals("ebookList")){ //검색하려는 결과가 ebook일 때
						%>
								<table class="table table-hover">
								<thead class="thead-light">
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
										for(OrdersAndEbookAndClient oec : list){
									%>		
											<tr>
												<td><%=oec.getEbook().getCategoryName() %></td>
												<td><%=oec.getEbook().getEbookISBN() %></td>
												<td><a href="<%=request.getContextPath()%>/Ebook/ebookOne.jsp?ebookISBN=<%=oec.getEbook().getEbookISBN()%>&ebookNo=<%=oec.getEbook().getEbookNo()%>"><%=oec.getEbook().getEbookTitle()%></a></td>
												<td><%=oec.getEbook().getEbookAuthor()%></td>
												<td><%=oec.getEbook().getEbookDate()%></td>
												<td><%=oec.getEbook().getEbookPrice()%></td>																										
											</tr>
									
									<%
										}
									%>
									</tbody>
								</table>
						<%	
							}else if(searchList.equals("ordersList")){ // 검색하려는 결과가 주문정보 일 때 출력
						%>
								<table class="table table-hover">
								<thead class="thead-light">
									<tr>
										<th>ordersNo</th>
										<th>ebookNo</th>
										<th>ebokkTitle</th>
										<th>clientNo</th>
										<th>clientEmail</th>
										<th>ordersDate</th>
										<th>ordersDate</th>
										<th>수정</th>
									</tr>
								</thead>
								
								<tbody>
									<%
										for(OrdersAndEbookAndClient oec : list){
									%>		
											<tr>
												<td><%=oec.getOrders().getOrdersNo()%></td>
												<td><%=oec.getOrders().getEbookNo()%></td>
												<td><a href="<%=request.getContextPath()%>/Ebook/ebookOne.jsp?ebookISBN=<%=oec.getEbook().getEbookISBN()%>"><%=oec.getEbook().getEbookTitle()%></a></td>
												<td><%=oec.getOrders().getClientNo()%></td>
												<td><%=oec.getClient().getClientEmail()%></td>
												<td><%=oec.getOrders().getOrdersDate()%></td>
												<td><%=oec.getOrders().getOrdersState()%></td>
												<td><a href="<%=request.getContextPath()%>/Orders/updateOrdersStateAction.jsp?ordersNo=<%=oec.getOrders().getOrdersNo()%>"><button class="btn btn-outline-primary">주문취소</button></a></td>
											</tr>
									
									<%
										}
									%>
									</tbody>
								</table>
						<%
							}
						%>
							
									<!-- 페이지 이동 -->
								<%
									if(currentPage == 1 && totalRow>rowPerPage){// 첫 페이지 일 때
								%>
										<a href="<%=request.getContextPath()%>/Search/searchList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>&searchList=<%=searchList%>&searchWord=<%=searchWord%>">
											<button type="button" class="btn btn-link">◀◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Search/searchList.jsp?currentPage=<%=currentPage%>&rowPerPage=<%=rowPerPage%>&searchList=<%=searchList%>&searchWord=<%=searchWord%>">
											<button type="button" class="btn btn-link">◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Search/searchList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&searchList=<%=searchList%>&searchWord=<%=searchWord%>">
											<button type="button" class="btn btn-link">▶</button>
										</a>
										<a href="<%=request.getContextPath()%>/Search/searchList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>&searchList=<%=searchList%>&searchWord=<%=searchWord%>">
											<button type="button" class="btn btn-link">▶▶</button>
										</a>
								
								<%	
									}else if(totalRow<=rowPerPage){ // 총 행의 수가 보려는 페이지 수 보다 작을 때 게시물 수가 많아지면 필요없다
								%>	
										<a href="<%=request.getContextPath()%>/Search/searchList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>&searchList=<%=searchList%>&searchWord=<%=searchWord%>">
											<button type="button" class="btn btn-link">◀◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Search/searchList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>&searchList=<%=searchList%>&searchWord=<%=searchWord%>">
											<button type="button" class="btn btn-link">◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Search/searchList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>&searchList=<%=searchList%>&searchWord=<%=searchWord%>">
											<button type="button" class="btn btn-link">▶</button>
										</a>
										<a href="<%=request.getContextPath()%>/Search/searchList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>&searchList=<%=searchList%>&searchWord=<%=searchWord%>">
											<button type="button" class="btn btn-link">▶▶</button>
										</a>
								
								<%
									}else if(currentPage == lastPage){ //마지막 페이지 일 때
								%>
										<a href="<%=request.getContextPath()%>/Search/searchList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>&searchList=<%=searchList%>&searchWord=<%=searchWord%>">
											<button type="button" class="btn btn-link">◀◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Search/searchList.jsp?currentPage=<%=currentPage%>&rowPerPage=<%=rowPerPage%>&searchList=<%=searchList%>&searchWord=<%=searchWord%>">
											<button type="button" class="btn btn-link">◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Search/searchList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>&searchList=<%=searchList%>&searchWord=<%=searchWord%>">
											<button type="button" class="btn btn-link">▶</button>
										</a>
										<a href="<%=request.getContextPath()%>/Search/searchList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>&searchList=<%=searchList%>&searchWord=<%=searchWord%>">
											<button type="button" class="btn btn-link">▶▶</button>
										</a>					
								<%
									}else{ //평상시
								%>
										<a href="<%=request.getContextPath()%>/Search/searchList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>&searchList=<%=searchList%>&searchWord=<%=searchWord%>">
											<button type="button" class="btn btn-link">◀◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Search/searchList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&searchList=<%=searchList%>&searchWord=<%=searchWord%>">
											<button type="button" class="btn btn-link">◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Search/searchList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&searchList=<%=searchList%>&searchWord=<%=searchWord%>">
											<button type="button" class="btn btn-link">▶</button>
										</a>
										<a href="<%=request.getContextPath()%>/Search/searchList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>&searchList=<%=searchList%>&searchWord=<%=searchWord%>">
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
	<!-- footer 영역 -->
	<div>
		<jsp:include page="/inc/adminFooter.jsp"></jsp:include>
	</div>
</body>
</html>