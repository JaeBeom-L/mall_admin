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
	Manager manager =(Manager)session.getAttribute("sessionManager"); // 매니저가 값이 없거나 레벨이 1보다 작다면 adminIndex로그인페이지로 돌아간다.
	if(manager == null || manager.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	Notice notice = NoticeDao.noticeOne(noticeNo);	
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
						<h6 class="m-0 font-weight-bold text-primary">notcieOne</h6>
					</div>
					
					
					<div class="card-body">
					<div class="table-responsive">
	
						<table class="table table-hover">
							<tr>
								<td>noticeNo</td>
								<td><%=noticeNo%></td>
							</tr>
							
							<tr>
								<td>noticeTitle</td>
								<td><%=notice.getNoticeTitle()%></td>
							</tr>
							
							<tr>
								<td>noticeContent</td>
								<td><%=notice.getNoticeContent()%></td>
							</tr>
							
							<tr>
								<td>noticeDate</td>
								<td><%=notice.getNoticeDate()%></td>
							</tr>
							
							<tr>
								<td>managerId</td>
								<td><%=notice.getManagerId()%></td>
							</tr>
						</table>
	
						
						<a href="<%=request.getContextPath()%>/Notice/updateNoticeForm.jsp?noticeNo=<%=noticeNo%>"><button class="btn btn-outline-primary">수정</button></a>
						<a href="<%=request.getContextPath()%>/Notice/deleteNoticeAction.jsp?noticeNo=<%=noticeNo%>"><button class="btn btn-outline-primary">삭제</button></a>
	
						
						</div>
					</div>
				</div>
					<br>
						<div class="card shadow mb-4">
							<!-- 댓글 -->
							<form method="post" action="<%=request.getContextPath()%>/Notice/insertCommentAction.jsp">
								<input type="hidden" name="noticeNo" value="<%=noticeNo%>">
									<table class="table table-hover">
										<thead>
											<tr>
												<th>managerId</th>
												<th>commentContent</th>
												<th>댓글 등록</th>
											</tr>
										</thead>
										<tr>
											<td>
												<input class="form-control" type="text" name="managerId" value="<%=manager.getManagerId()%>" readonly="readonly">
											</td>
											<td>
												<textarea class="form-control" rows="1" cols="80" name="commentContent"></textarea>
											</td>
											<td>
												<button type="submit" class="btn btn-outline-primary">댓글 등록</button>
											</td>
										</tr>
									</table>								
							</form>
						</div>
						
						<div class="card shadow mb-4">
              				<div class="card-header py-3">
								<h6 class="m-0 font-weight-bold text-primary">댓글</h6>
							</div>
							<div class="card shadow mb-4">
							<!-- 댓글 리스트 -->
								<table class="table table-hover-light">
								<%
									ArrayList<Comment> commentList = CommentDao.commentList(noticeNo);
									for(Comment c : commentList){
								%>			
										<tr>
											<td><%=c.getCommentContent()%></td>
											<td><%=c.getCommentDate()%></td>
											<td><%=c.getManagerId()%></td>
											<td><a href="<%=request.getContextPath()%>/Notice/deleteCommentAction.jsp?commentNo=<%=c.getCommentNo()%>&noticeNo=<%=noticeNo%>&managerId=<%=manager.getManagerId()%>"><button class="btn btn-outline-primary">삭제</button></a></td>
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
	<!-- footer 영역 -->
	<div>
		<jsp:include page="/inc/adminFooter.jsp"></jsp:include>
	</div>
</body>
</html>