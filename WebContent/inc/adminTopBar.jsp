<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="gd.mall.vo.*"%>
<%@ page import="gd.mall.dao.*"%>
<%@ page import="java.util.*"%>
<%
Manager manager = (Manager) session.getAttribute("sessionManager");
String managerId = manager.getManagerId();
int managerLevel = manager.getManagerLevel();
%>
<!-- Topbar -->
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

	<!-- Sidebar Toggle (Topbar) -->
	<form class="form-inline">
		<button id="sidebarToggleTop"
			class="btn btn-link d-md-none rounded-circle mr-3">
			<i class="fa fa-bars"></i>
		</button>
	</form>

	<!-- Topbar Search -->

	<form method="post" action="<%=request.getContextPath()%>/Search/searchList.jsp" class="d-none d-lg-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
		<div class="row">
			<select name="searchList" class="custom-select">
				<option value="clientList">searchClient</option>
				<option value="ebookList">searchEbook</option>
				<option value="ordersList">searchOrders</option>
			</select> &nbsp;
			<div class="input-group">
				<input type="text" name="searchWord"
					class="form-control bg-light border-0 small"
					placeholder="Search for..." aria-label="Search"
					aria-describedby="basic-addon2">
				<div class="input-group-append">
					<button class="btn btn-primary" type="submit">
						<i class="fas fa-search fa-sm"></i>
					</button>
				</div>
			</div>
		</div>
	</form>


	<!-- Topbar Navbar -->
	<ul class="navbar-nav ml-auto">

		<li class="nav-item dropdown no-arrow"><a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 
		<span class="mr-2 d-none d-lg-inline text-gray-600 small"><%=managerId%><br>Level : <%=managerLevel%></span> <img class="img-profile rounded-circle" src="<%=request.getContextPath()%>/Bootstrap/img/undraw_profile.svg"></a> 
		<!-- Dropdown - User Information -->
		<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
			<div class="dropdown-divider"></div>
				<a class="dropdown-item" href="<%=request.getContextPath()%>/Manager/logoutManagerAction.jsp" data-toggle="modal" data-target="#logoutModal">
				<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>Logout
				</a>
			</div>
		</li>
	</ul>

</nav>
<!-- End of Topbar -->
