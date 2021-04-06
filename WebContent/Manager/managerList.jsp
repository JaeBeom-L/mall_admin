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

    <title>managerList</title>

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
<%
	Manager manager = (Manager)session.getAttribute("sessionManager"); // 매니저가 아니거나 레벨이 맞지 않으면 인덱스화면으로 돌아간다.
	if(manager == null){
		response.sendRedirect(request.getContextPath()+"adminIndex.jsp");
		return;	
	}else if(manager.getManagerLevel()<2){										// 매니저 등급을 조정하여 레벨에 맞지 않는 사람을 차단 할 수 있다.
		response.sendRedirect(request.getContextPath()+"adminIndex.jsp");
		return;	
	}
	
	//현재 페이지
	int currentPage = 1;
	if(request.getParameter("beginRow") != null){
		currentPage = Integer.parseInt(request.getParameter("beginRow"));
	}
	
	// 한 페이지당 게시물 수
	int rowPerPage = 10;
	if(request.getParameter("rowPerPage") != null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	
	//시작행
	int beginRow = (currentPage-1)*rowPerPage;
	
	// 총 게시물수
	int totalRow = ManagerDao.totalRow();
	
	// 마지막 페이지
	int lastPage = totalRow/rowPerPage;
	if(totalRow%rowPerPage != 0){
		lastPage +=1;
	}

	ArrayList<Manager> list = ManagerDao.selectManagerList(beginRow, rowPerPage);
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
						<h6 class="m-0 font-weight-bold text-primary">managerList</h6>
					</div>
					
					
					<div class="card-body">
						<!-- 화면에 보고 싶은 행만큼 출력 할 수 있도록 설정 -->
						<form action="<%=request.getContextPath()%>/Manager/managerList.jsp" method="post"> 				
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
							<table class="table table-hover">
								<thead class="thead-light">
									<tr>
										<th>managerNo</th>
										<th>managerId</th>
										<th>managerName</th>
										<th>managerDate</th>
										<th>수정</th>
										<th>삭제</th>
									</tr>
								</thead>
								
								<tbody>
									<%
										for(Manager m : list){
									%>		
											<tr>
												<td><%=m.getManagerNo()%></td>
												<td><%=m.getManagerId()%></td>
												<td><%=m.getManagerName()%></td>
												<td><%=m.getManagerDate()%></td>
												<td>
													<form method="post" action="<%=request.getContextPath()%>/Manager/updateManagerLevelAction.jsp"> <!-- 히든 방법 -->
														<input type="hidden" name="managerNo" value="<%=m.getManagerNo()%>">
															<div class="row">
																<div class="col-sm-4">
																	<select name="managerLevel" class="custom-select">
																	<%
																		for(int i=0; i<3; i++){
																			if(m.getManagerLevel() == i){
																	%>
																				<option value="<%=i %>" selected="selected"><%=i%></option>
																	<%			
																			}else{
																	%>
																				<option value="<%=i%>"><%=i%></option>
																	<%			
																			}
																		}
																	%>
																	
																	</select>
																</div>
																<button type="submit" value="수정" class="btn btn-outline-primary">수정</button>
															</div>
													</form>
												</td>
												<td>
													<a href="<%=request.getContextPath()%>/Manager/deleteManagerAction.jsp?managerNo=<%=m.getManagerNo()%>">
														<button type="button" class="btn btn-outline-primary">삭제</button>
													</a>
												</td>
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
										<a href="<%=request.getContextPath()%>/Manager/managerList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Manager/managerList.jsp?currentPage=<%=currentPage%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Manager/managerList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">▶</button>
										</a>
										<a href="<%=request.getContextPath()%>/Manager/managerList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">▶▶</button>
										</a>
								
								<%	
									}else if(totalRow<=rowPerPage){ // 총 행의 수가 보려는 페이지 수 보다 작을 때 게시물 수가 많아지면 필요없다
								%>	
										<a href="<%=request.getContextPath()%>/Manager/managerList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Manager/managerList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Manager/managerList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">▶</button>
										</a>
										<a href="<%=request.getContextPath()%>/Manager/managerList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">▶▶</button>
										</a>
								
								<%
									}else if(currentPage == lastPage){ //마지막 페이지 일 때
								%>
										<a href="<%=request.getContextPath()%>/Manager/managerList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Manager/managerList.jsp?currentPage=<%=currentPage%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Manager/managerList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">▶</button>
										</a>
										<a href="<%=request.getContextPath()%>/Manager/managerList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">▶▶</button>
										</a>					
								<%
									}else{ //평상시
								%>
										<a href="<%=request.getContextPath()%>/Manager/managerList.jsp?currentPage=<%=1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Manager/managerList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">◀</button>
										</a>
										<a href="<%=request.getContextPath()%>/Manager/managerList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">
											<button type="button" class="btn btn-link">▶</button>
										</a>
										<a href="<%=request.getContextPath()%>/Manager/managerList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">
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
		<jsp:include page="/inc/adminFotter.jsp"></jsp:include>
	</div>
</body>
</html>