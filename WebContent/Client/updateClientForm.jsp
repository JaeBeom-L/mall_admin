<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.dao.*" %>
<%@ page import="gd.mall.vo.*" %>
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
	Manager manager =(Manager)session.getAttribute("sessionManager"); // 매니저가 값이 없거나 레벨이 1보다 작다면 adminIndex로그인페이지로 돌아간다.
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}

	int clientNo = Integer.parseInt(request.getParameter("clientNo")); // 수정버튼으로 고객이메일을 받아온다.
	Client client = (Client)(ClientDao.clientInformation(clientNo));
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
				<div class="col-xl-4 col-md-6 mb-4">
	              	<div class="card shadow mb-4">           
		              	<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">Update Client Pw</h6>							
						</div>
							
						<div class="card-body">
							<form method="post" action="<%=request.getContextPath()%>/Client/updateClientAction.jsp">
								<input type="hidden" name="clientNo" value="<%=client.getClientNo()%>">
								<table class="table table-hover">
									<tr>
										<td>clientNo</td>
										<td><%=client.getClientNo()%></td>
									</tr>
									
									<tr>
										<td>clientEmail</td>
										<td><%=client.getClientEmail() %></td>
									</tr>
									
									<tr>
										<td>clientPw</td>
										<td><input type="text" name="clientPw" class="form-control"></td>
									</tr>
									
									<tr>
										<td>clientDate</td>
										<td><%=client.getClientDate() %></td>
									</tr>
						
								</table>
								<button type="submit" class="btn btn-primary">수정</button>
							</form>
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