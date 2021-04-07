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
	String categoryName = null;
	if(request.getParameter("categoryName") != null){
		categoryName = request.getParameter("categoryName");
	}

	
	//시작 행
	int beginRow = (currentPage - 1) * rowPerPage;
	
	// 전체 행의 개수
	int totalRow = EbookDao.totalRow(categoryName);
	System.out.println(totalRow);
	
	// 마지막 페이지
	int lastPage = totalRow/rowPerPage;
	if((totalRow % rowPerPage) != 0){
		lastPage +=1;
	}
	
	// 검색 카테고리
	String searchCategory = null;
	if(request.getParameter("searchCategory")!=null){
		searchCategory=request.getParameter("searchCategory");
	}
	
	// 검색 단어
	String searchWord = "";
	if(request.getParameter("searchWord") != null){
		searchWord=request.getParameter("searchWord");
	}
	
	ArrayList<Ebook> list = EbookDao.ebookList(beginRow, rowPerPage, categoryName); //list에 페이징 메서드

	/* String categoryName = request.getParameter("categoryName");
	System.out.println(categoryName); */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>ebookList</title>

    <!-- Custom fonts for this template -->
    <link href="<%=request.getContextPath()%>/Bootstrap/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="<%=request.getContextPath()%>/Bootstrap/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <link href="<%=request.getContextPath()%>/Bootstrap/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
</head>
<body>
	
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
						<h6 class="m-0 font-weight-bold text-primary">ebookList</h6>
					</div>
										
					<div class="card-body">
																				
						<!-- 화면에 보고 싶은 행만큼 출력 할 수 있도록 설정 -->
						<form action="<%=request.getContextPath()%>/Ebook/ebookList.jsp" method="post"> 
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
								<button type="submit" class="btn btn-outline-primary">보기</button>&nbsp;
								<a href = "<%=request.getContextPath()%>/Ebook/insertEbookAction.jsp" data-toggle="modal" data-target="#insertEbookModal"><button type="button" class="btn btn-outline-primary">ebook 추가</button></a>						
							</div>
						</form>	
						<!-- ebook 추가 모달 폼 -->
						 <form method="post" action="<%=request.getContextPath()%>/Ebook/insertEbookAction.jsp">
							 <div class="modal fade" id="insertEbookModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
						        <div class="modal-dialog" role="document">
						            <div class="modal-content">
						                <div class="modal-header">
						                    <h5 class="modal-title" id="exampleModalLabel">insertEbookForm</h5>
						                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
						                        <span aria-hidden="true">×</span>
						                    </button>
						                </div>
						                <div class="modal-body">
						                	<jsp:include page="/Ebook/insertEbookForm.jsp"></jsp:include>
						                </div>
						                <div class="modal-footer">					                    
						                    <button type="submit" class="btn btn-primary">추가</button>
						                </div>
						            </div>
						        </div>
						    </div>
						</form>									
						<br>
                       	<div class="table-responsive">	
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
										for(Ebook e : list){
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
								if(currentPage == 1 && totalRow>rowPerPage){ // 첫 페이지면 이전 버튼을 눌러도 첫 페이지
							%>
									<a href="<%=request.getContextPath()%>/Ebook/ebookList1.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">
										<button type="button" class="btn btn-link">◀◀</button>
									</a>
									<a href="<%=request.getContextPath()%>/Ebook/ebookList1.jsp?currentPage=<%=currentPage%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">
										<button type="button" class="btn btn-link">◀</button>
									</a>
									<a href="<%=request.getContextPath()%>/Ebook/ebookList1.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">
										<button type="button" class="btn btn-link">▶</button>
									</a>
									<a href="<%=request.getContextPath()%>/Ebook/ebookList1.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">
										<button type="button" class="btn btn-link">▶▶</button>
									</a>
							<%
								}else if(totalRow<=rowPerPage){ // 총 행의 수가 보려는 페이지 수 보다 작을 때 게시물 수가 많아지면 필요없다
							%>	
									<a href="<%=request.getContextPath()%>/Ebook/ebookList1.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">
										<button type="button" class="btn btn-link">◀◀</button>
									</a>
									<a href="<%=request.getContextPath()%>/Ebook/ebookList1.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">
										<button type="button" class="btn btn-link">◀</button>
									</a>
									<a href="<%=request.getContextPath()%>/Ebook/ebookList1.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">
										<button type="button" class="btn btn-link">▶</button>
									</a>
									<a href="<%=request.getContextPath()%>/Ebook/ebookList1.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">
										<button type="button" class="btn btn-link">▶▶</button>
									</a>									
							<%
								}else if(currentPage==lastPage){ //마지막 페이지면 다음 버튼을 눌러도 마지막 페이지
							%>
									<a href="<%=request.getContextPath()%>/Ebook/ebookList1.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">
										<button type="button" class="btn btn-link">◀◀</button>
									</a>
									<a href="<%=request.getContextPath()%>/Ebook/ebookList1.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">
										<button type="button" class="btn btn-link">◀</button>
									</a>
									<a href="<%=request.getContextPath()%>/Ebook/ebookList1.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">
										<button type="button" class="btn btn-link">▶</button>
									</a>
									<a href="<%=request.getContextPath()%>/Ebook/ebookList1.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">
										<button type="button" class="btn btn-link">▶▶</button>
									</a>									
							<%				
								}else{ // 평상시 페이지
							%>
									<a href="<%=request.getContextPath()%>/Ebook/ebookList1.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">
										<button type="button" class="btn btn-link">◀◀</button>
									</a>
									<a href="<%=request.getContextPath()%>/Ebook/ebookList1.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">
										<button type="button" class="btn btn-link">◀</button>
									</a>
									<a href="<%=request.getContextPath()%>/Ebook/ebookList1.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">
										<button type="button" class="btn btn-link">▶</button>
									</a>
									<a href="<%=request.getContextPath()%>/Ebook/ebookList1.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">
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
	<div>
		<jsp:include page="/inc/adminFooter.jsp"></jsp:include>
	</div>	
	
	
</body>
</html>