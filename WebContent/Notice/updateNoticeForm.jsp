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

    <title>updateNoticeForm</title>

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
	Manager manager = (Manager)session.getAttribute("sessionManager"); // 매니저가 값이 없으면 adminIndex로그인페이지로 돌아간다. 레벨2보다 작으면 리스트로 돌아간다.
	if(manager == null){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");		
	}else if(manager.getManagerLevel() < 2){
		response.sendRedirect(request.getContextPath()+"/Notice/noticeList.jsp");
		System.out.println("권한이 없습니다.");
		return;
	}
	
	String managerId = manager.getManagerId(); //세션에서 불러온 매니저값을 이용해 아이디 저장
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo")); // 넘겨 받아 온 공지글 번호
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
						<h6 class="m-0 font-weight-bold text-primary">updateNoticeList</h6>
					</div>
					
					
					<div class="card-body">
						<form method="post" action="<%=request.getContextPath()%>/Notice/updateNoticeAction.jsp">
							<input type="hidden" name="noticeNo" value="<%=noticeNo%>">
							<table class="table-hover">
								<tr>
									<td>noticeTitle</td>
									<td><input type="text" name="noticeTitle" class="form-control"></td>
								</tr>
			
								<tr>
									<td>noticeContent</td>
									<td>
										<textarea rows="20" cols="200" name="noticeContent" class="form-control"></textarea>
									</td>
								</tr>
							</table>
							<button type="submit" class="btn btn-outline-primary">수정</button>
						</form>
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