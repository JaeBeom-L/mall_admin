<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.vo.*" %>
<%@ page import="gd.mall.dao.*" %>
<%@ page import="java.util.*" %>

<%
	ArrayList<Notice> noticeList = NoticeDao.noticeList(0, 5);
	ArrayList<Manager> managerList = ManagerDao.selectManagerList(0,5);
	ArrayList<Client> clientList = ClientDao.clientList(0, 5, "");
	ArrayList<Ebook> ebookList = EbookDao.ebookList(0, 5, null);
	ArrayList<OrdersAndEbookAndClient> ordersList = OrdersDao.ordersList(0, 5);			
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>adminIndex</title>

    <!-- Custom fonts for this template -->
    <link href="<%=request.getContextPath()%>/Bootstrap/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="<%=request.getContextPath()%>/Bootstrap/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <link href="<%=request.getContextPath()%>/Bootstrap/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
</head>
<body id="page-top">
<%
	if(session.getAttribute("sessionManager") == null){
%>

<div class="container">
        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">Login</h1>
                                    </div>
                                    <form class="user" method="post" action="<%=request.getContextPath()%>/Manager/loginManagerAction.jsp">
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user" name="managerId"
                                                id="exampleInputEmail" aria-describedby="emailHelp"
                                                placeholder="Enter Id">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user" name="managerPw"
                                                id="exampleInputPassword" placeholder="Password">
                                        </div>
                                 
                                        <button type="submit" class="btn btn-primary btn-user btn-block">
                                            Login
                                        </button>
                                        <hr>
                                        <div class="text-center">
                                       		<a class="small" href="Manager/insertManagerForm.jsp">Create an Account!</a>
                                    	</div>		
                                    </form>
                                    <hr>
			                       	<div class="col-xl-12 col-md-6 mb-6">     
			                        	<div class="card shadow mb-4">   
			                      			<div class="col mr-2">
			                      			<br>
			                                    <h4 class="h4 mb-0 text-gray-800">승인대기 목록</h4>
												<table class="table table-bordered">
													<tr>
														<td>managerId</td>
														<td>managerDate</td>
													</tr>
												<%		
													ArrayList<Manager> list = ManagerDao.selectManagerListByZero();
														for(Manager m : list){
												%>
															<tr>
																<td><%=m.getManagerId() %></td>
																<td><%=m.getManagerDate().substring(0,10)%></td>
															</tr>													
												<%
														}
												%>
												</table>    
											</div>
										</div> 
									</div>          
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>
<%
	} else{
		Manager manager = (Manager)(session.getAttribute("sessionManager"));
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
            	
            	<!-- First Row -->
                <div class="row">
					<!-- 최근 등록한 공지 5개 -->
					<div class="col-xl-3 col-md-6 mb-4">
						<div class="card shadow mb-4">
							<div class="col mr-2">	
							<br>
								<div class="row" >
									<div class="col-md-9"><h2 class="h3 mb-0 text-gray-800">&nbsp;noticeList</h2></div>
									<div class="col-md-3"><h4><a href="<%=request.getContextPath()%>/Notice/noticeList.jsp">more</a></h4></div>
								</div>
								<table class="table table-bordered">				
									<%
										for(Notice n : noticeList){
									%>
											<tr>
												<td><%=n.getNoticeTitle()%></td>
												<td><%=n.getManagerId()%></td>
											</tr>
									<%
										}
									%>									
								</table>
							</div>
						</div>
					</div>
					<!-- 최근 가입한 관리자 5명 -->
					
					<div class="col-xl-3 col-md-6 mb-4">
						<div class="card shadow mb-4">
							<div class="col mr-2">
							<br>
								<div class="row" >
									<div class="col-md-9"><h2 class="h3 mb-0 text-gray-800">&nbsp;managerList</h2></div>
									<div class="col-md-3"><h4><a href="<%=request.getContextPath()%>/Manager/managerList.jsp">more</a></h4></div>
								</div>
								<table class="table table-bordered">				
									<%
										for(Manager m : managerList){
									%>
											<tr>
												<td><%=m.getManagerId()%></td>
												<td><%=m.getManagerName()%></td>
											</tr>
									<%
										}
									%>									
								</table>
							</div>
						</div>
					</div>
					<!-- 최근 가입한 고객 5명 -->
					<div class="col-xl-6 col-md-6 mb-6">		
						<div class="card shadow mb-6">
							<div class="col mr-2">
							<br>
								<div class="row" >
									<div class="col-md-10"><h2 class="h3 mb-0 text-gray-800">&nbsp;clientList</h2></div>
									<div class="col-md-2"><h4><a href="<%=request.getContextPath()%>/Client/clientList.jsp">more</a></h4></div>
								</div>
								<table class="table table-bordered">				
									<%
										for(Client c : clientList){
									%>
											<tr>
												<td><%=c.getClientEmail()%></td>
												<td><%=c.getClientDate()%></td>
											</tr>
									<%
										}
									%>									
								</table>
							</div>
						</div>
					</div>
				</div>
				
				<!-- Second Row -->
	            <div class="row">
					<!-- 최근 등록한 책 5권 -->															
						<div class="col-xl-4 col-md-6 mb-4">	
							<div class="card shadow mb-6">
								<div class="col mr-2">
								<br>
									<div class="row" >
										<div class="col-md-10"><h2 class="h3 mb-0 text-gray-800">&nbsp;ebookList</h2></div>
										<div class="col-md-2"><h4><a href="<%=request.getContextPath()%>/Ebook/ebookList.jsp">more</a></h4></div>
									</div>
									<table class="table table-bordered">				
										<%
											for(Ebook e : ebookList){
										%>
												<tr>
													<td><%=e.getEbookTitle()%></td>
													<td><%=e.getEbookPrice()%></td>
												</tr>
										<%
											}
										%>									
									</table>
								</div>	
							</div>
						</div>
										
					<!-- 최근 주문 5개 -->											
						<div class="col-xl-8 col-md-6 mb-4">		
							<div class="card shadow mb-6">	
								<div class="col mr-2">
								<br>
									<div class="row" >
										<div class="col-md-11"><h2 class="h3 mb-0 text-gray-800">&nbsp;ordersList</h2></div>
										<div class="col-md-1"><h4><a href="<%=request.getContextPath()%>/Orders/ordersList.jsp">more</a></h4></div>
									</div>
									<table class="table table-bordered">				
										<%
											
											for(OrdersAndEbookAndClient oec : ordersList){
										%>
												<tr>
													<td><%=oec.getOrders().getOrdersNo()%>
													<td><%=oec.getEbook().getEbookTitle()%></td>
													<td><%=oec.getClient().getClientEmail()%></td>
												</tr>
										<%
											}
										%>									
									</table>
								</div>
							</div>
						</div>					
					</div>
				</div>
			</div>
		</div>
		</div>
<%		
	}
%>
	<!-- footer 영역 -->
	<div>
		<jsp:include page="/inc/adminFooter.jsp"></jsp:include>
	</div>
</body>
</html>