<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.vo.*" %>
<%@ page import="gd.mall.dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>clientList</title>

    <!-- Custom fonts for this template -->
    <link href="<%=request.getContextPath()%>/Bootstrap/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="<%=request.getContextPath()%>/Bootstrap/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <link href="<%=request.getContextPath()%>/Bootstrap/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
<body>
<%
	Manager manager =(Manager)session.getAttribute("sessionManager"); // 매니저가 값이 없거나 레벨이 1보다 작다면 adminIndex로그인페이지로 돌아간다.
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	String ebookISBN = request.getParameter("ebookISBN");
	Ebook ebook = EbookDao.selectEbookOne(ebookISBN); // isbn에 맞는 정보 출력하도록 데이터를 가져온다

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
						<h6 class="m-0 font-weight-bold text-primary"><%=ebook.getEbookTitle()%></h6>
					</div>
					
					
					<div class="card-body">
						<div class="table-responsive">	
							<table class="table table-hover">
								<tr><!-- 책 번호 -->
									<td>ebookNo</td>
									<td><%=ebook.getEbookNo()%></td>
									<td></td>
								</tr>
								
								<tr><!-- 책  고유 ISBN -->
									<td>ebookISBN</td>
									<td><%=ebook.getEbookISBN()%></td>
									<td></td>
								</tr>
								
								<tr><!-- 카테고리 -->
									<td>categoryName</td>
									<td><%=ebook.getCategoryName()%></td>
									<td></td>
								</tr>
								
								<tr><!-- 저자 -->
									<td>ebookAuthor</td>
									<td><%=ebook.getEbookAuthor()%></td>
									<td></td>
								</tr>
								
								<tr><!-- 출판사 -->
									<td>ebookCompany</td>
									<td><%=ebook.getEbookCompany()%></td>
									<td></td>
								</tr>
								
								<tr><!-- 책 페이지 수 -->
									<td>ebookPageCount</td>
									<td><%=ebook.getEbookPageCount()%></td>
									<td></td>
								</tr>
								
								<tr><!-- 가격 -->
									<td>ebookPrice</td>
									<td><%=ebook.getEbookPrice()%></td>
									<td></td>
								</tr>
								
								<tr><!-- 간단한 설명 -->
									<td>ebookSummary</td>
									<td><%=ebook.getEbookSummary()%></td>
									<td>
										<a href="<%=request.getContextPath()%>/Ebook/updateEbookSummaryForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>"><button class="btn btn-outline-primary">수정</button></a>
									</td>
								</tr>
								
								<tr><!-- 책 사진 -->
									<td>ebookImg</td>
									<td><img src="<%=request.getContextPath() %>/img/<%=ebook.getEbookImg()%>"></td>
									<td>
										<a href="<%=request.getContextPath()%>/Ebook/updateEbookImgAction.jsp?ebookISBN=<%=ebook.getEbookISBN()%>" data-toggle="modal" data-target="#updateEbookImgModal">
											<button class="btn btn-outline-primary">수정</button>
										</a>
									</td>
								</tr>
								
								<tr><!-- 책 출판일 -->
									<td>ebookDate</td>
									<td><%=ebook.getEbookDate()%></td>
									<td></td>
								</tr>
								
								<tr><!-- 책 상태 -->
									<td>ebookState</td>
									<td><%=ebook.getEbookState()%></td>
									<td>
										<a href="<%=request.getContextPath()%>/Ebook/updateEbookStateForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>" >
											<button class="btn btn-outline-primary">수정</button>
										</a>
									</td>
								</tr>
							</table>
							<a href="<%=request.getContextPath()%>/Ebook/updateEbookForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>"><button class="btn btn-outline-primary">정보 수정</button></a>
							<a href="<%=request.getContextPath()%>/Ebook/deleteEbookAction.jsp?ebookISBN=<%=ebook.getEbookISBN()%>"><button class="btn btn-outline-primary">삭제</button></a>
						</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- ebook 이미지 수정 모달 폼 -->
	 <form method="post" action="<%=request.getContextPath()%>/Ebook/updateEbookImgAction.jsp" enctype="multipart/form-data">
		<div class="modal fade" id="updateEbookImgModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						 <h5 class="modal-title" id="exampleModalLabel">updateImg</h5>
						 <button class="close" type="button" data-dismiss="modal" aria-label="Close">
						      <span aria-hidden="true">×</span>
						  </button>
		              </div>
		             <div class="modal-body">
						 <jsp:include page="/Ebook/updateEbookImgForm.jsp"></jsp:include>
					 </div>
					<div class="modal-footer">					                    
						<button type="submit" class="btn btn-primary">수정</button>
					 </div>
				 </div>
			</div>
		 </div>
	</form>				
	
	<div>
		<jsp:include page="/inc/adminFotter.jsp"></jsp:include>
	</div>
	
	

</body>
</html>