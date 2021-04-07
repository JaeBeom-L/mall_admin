<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.dao.*" %>
<%@ page import="gd.mall.vo.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>categoryList</title>

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
	Manager manager =(Manager)session.getAttribute("sessionManager"); // 매니저가 값이 없거나 레벨이 1보다 작다면 adminIndex로그인페이지로 돌아간다.
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}

	ArrayList<Category> list = CategoryDao.categoryList(); // 카테고리 타입 리스트
	int totalRow = CategoryDao.totalRow();
%>

	<!-- Page Wrapper -->
   	<div id="wrapper">
	<!-- adminMenu -->
	<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	<!-- Content Wrapper -->
   	<div id="content-wrapper" class="d-flex flex-column">

  		 <!-- Main Content -->
      	 <div id="content">
			<jsp:include page="/inc/adminTopBar.jsp"></jsp:include><!-- 검색창과 로그아웃 상단bar -->
			
			<!-- Begin Page Content -->
            <div class="container-fluid">
				
				<!-- DataTales Example -->
				<div class="col-xl-4 col-md-6 mb-4">
	              	<div class="card shadow mb-4">           
		              	<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">categoryList</h6>							
						</div>
							
						<div class="card-body">
							<a href="<%=request.getContextPath()%>/Category/insertCategoryAction.jsp" data-toggle="modal" data-target="#insertCategoryModal"><button type="button" class="btn btn-outline-primary">카테고리 추가</button></a>							
							<div class="table table-hover">	
							<br>	
								<table class="thead-light">
									<thead>
										<tr>
											<th>categoryName</th>
											<th>categoryWeight(수정가능)</th>
											<th>삭제</th>
										</tr>
									</thead>
									
									<tbody>
										<%
											for(Category c : list){			
										%>
											<tr>
												<td><%=c.getCategoryName()%></td>
												<td>
													<form method="post" action="<%=request.getContextPath()%>/Category/updateCategoryAction.jsp">		<!-- 폼 안에 셀렉트를 사용하여 바로 수정 할 수 있게끔 보이게 한다 -->				
														<input type="hidden" name="categoryNo" value="<%=c.getCategoryNo()%>">
															<div class="row">
																<div class="col-sm-6">
																	<select name="categoryWeight" class="custom-select">
																	<%
																		for(int i=0; i<totalRow; i++){
																			if(c.getCategoryWeight() == i){
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
																	<button type="submit" class="btn btn-outline-primary">수정</button>
																</div>
													</form>
												</td>
												<td><a href="<%=request.getContextPath()%>/Category/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>"><button type="button" class="btn btn-outline-primary">삭제</button></a></td>
											</tr>
										
										<%
										}
										 %>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	
	<!-- category 추가 모달 폼 -->
	 <form method="post" action="<%=request.getContextPath()%>/Category/insertCategoryAction.jsp">
		 <div class="modal fade" id="insertCategoryModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				 <div class="modal-content">
					 <div class="modal-header">
						  <h5 class="modal-title" id="exampleModalLabel">insertCategory</h5>
						  	 <button class="close" type="button" data-dismiss="modal" aria-label="Close">
						    	<span aria-hidden="true">×</span>
							 </button>
					</div>
				<div class="modal-body"><!-- 카테고리 추가 폼을 모달로 불러온다 -->
					<jsp:include page="/Category/insertCategoryForm.jsp"></jsp:include>
				</div>
			 <div class="modal-footer">					                    
			 <button type="submit" class="btn btn-primary">추가</button>
		 	</div>
		 		</div>
		 	</div>
		 </div>
	</form>
	
	
	
	<!-- footer영역 -->
	<div>
		<jsp:include page="/inc/adminFooter.jsp"></jsp:include>
	</div>
					
						
</body>
</html>