<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.vo.*" %>
<%@ page import="gd.mall.dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>noticeList</title>

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
	Manager manager = (Manager)session.getAttribute("sessionManager"); // 매니저가 값이 없거나 레벨이 1보다 작다면 adminIndex로그인페이지로 돌아간다.
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	//현재 페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 화면에 볼 페이지
	int rowPerPage = 10;
	if(request.getParameter("rowPerPage") != null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	
	// 전체 행 수
	int totalRow = NoticeDao.totalRow();
	
	// 시작 행
	int beginRow = (currentPage -1) * rowPerPage;
	
	// 마지막 페이지
	int lastPage = totalRow/rowPerPage; // 전체 행의 수와 화면에 볼 페이지를 나눈 나머지가 0이아니라면 한 페이지가 더 있다
	if((totalRow%rowPerPage) != 0 ){
		lastPage = totalRow/rowPerPage + 1 ;
	}
	
	// 공지 리스트 출력 메서드 사용하여 list에 저장
	ArrayList<Notice> list = NoticeDao.noticeList(beginRow, rowPerPage);
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
						<h6 class="m-0 font-weight-bold text-primary">noticeList</h6>
					</div>
					
					
					<div class="card-body">
	
						<form method="post" action="<%=request.getContextPath()%>/Notice/noticeList.jsp">
							<div class="row">
								<div class="col-sm-1">
							
								<select name="rowPerPage" class="custom-select"><!-- 보고 싶은 게시물 만큼 볼수 있게 콤보상자로 만든다 -->
									<%
										for(int i=10; i<=30; i+=5){
											if(rowPerPage == i){
									%>
											<option value=<%=i%> selected="selected"><%=i%></option>
									<%
											}else{
									%>
											<option value=<%=i%>><%=i%></option>
									<%
											}
										}
									%>
								</select>
								</div>
								<button type="submit" class="btn btn-outline-primary">보기</button>&nbsp;
								<a href="<%=request.getContextPath()%>/Notice/insertNoticeForm.jsp"><button type="button" class="btn btn-outline-primary">공지 추가</button></a>
							</div>
						</form>
						<br>
						<div class="table-responsive">
							<table class="table table-hover">
								<thead class="thead-light">
									<tr>
										<th>noticeNo</th>
										<th>noticeTitle</th>
										<th>noticeDate</th>
										<th>managerId</th>
									</tr>
								</thead>
								
								<tbody>
										<%
											for(Notice n : list){
										%>
											<tr>
												<td><%=n.getNoticeNo()%></td>
												<td><a href="<%=request.getContextPath()%>/Notice/noticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a></td>
												<td><%=n.getNoticeDate()%></td>
												<td><%=n.getManagerId()%></td>
											</tr>
										<%
											}
										%>
									
								</tbody>
							</table>
					
							<!-- 페이지 이동 -->
								<%
									if(currentPage == 1 && totalRow>rowPerPage){// 첫 페이지 일 때
								%>
										<a href="<%=request.getContextPath()%>/Notice/noticeList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Notice/noticeList.jsp?currentPage=<%=currentPage%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Notice/noticeList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">▶</button>
										</a>
										<a href="<%=request.getContextPath()%>/Notice/noticeList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">▶▶</button>
										</a>
								
								<%	
									}else if(totalRow<=rowPerPage){ // 총 행의 수가 보려는 페이지 수 보다 작을 때 게시물 수가 많아지면 필요없다
								%>	
										<a href="<%=request.getContextPath()%>/Notice/noticeList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Notice/noticeList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Notice/noticeList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">▶</button>
										</a>
										<a href="<%=request.getContextPath()%>/Notice/noticeList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">▶▶</button>
										</a>
								
								<%
									}else if(currentPage == lastPage){ //마지막 페이지 일 때
								%>
										<a href="<%=request.getContextPath()%>/Notice/noticeList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Notice/noticeList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Notice/noticeList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">▶</button>
										</a>
										<a href="<%=request.getContextPath()%>/Notice/noticeList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">▶▶</button>
										</a>					
								<%
									}else{ //평상시
								%>
										<a href="<%=request.getContextPath()%>/Notice/noticeList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Notice/noticeList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Notice/noticeList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">▶</button>
										</a>
										<a href="<%=request.getContextPath()%>/Notice/noticeList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">
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
	
	<!-- footer영역 -->
	<div>
		<jsp:include page="/inc/adminFooter.jsp"></jsp:include>
	</div>
	
	
</body>
</html>