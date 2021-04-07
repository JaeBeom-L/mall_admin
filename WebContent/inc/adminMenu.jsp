<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gd.mall.dao.*" %>
<%@ page import="gd.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	Manager manager =(Manager)session.getAttribute("sessionManager");
	String managerId = "비로그인";
	int managerLevel;
	if(session.getAttribute("sessionManager") != null){
		managerId = manager.getManagerId();
		managerLevel = manager.getManagerLevel();
	}
%>

		<!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="<%=request.getContextPath()%>/adminIndex.jsp">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3">Home<sup></sup></div>
            </a>

            <li class="nav-item">
                <a class="nav-link" href="<%=request.getContextPath()%>/Manager/managerList.jsp">
               	<i class="fas fa-fw fa-tachometer-alt"></i>
              	<span>운영자 관리</span></a>
            </li>

            <li class="nav-item">
                <a class="nav-link collapsed" href="<%=request.getContextPath()%>/Client/clientList.jsp">
               	<i class="fas fa-fw fa-cog"></i>
               	<span>고객관리</span>
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link collapsed" href="<%=request.getContextPath()%>/Category/categoryList.jsp">
               	<i class="fas fa-fw fa-wrench"></i>
               	<span>상품 카테고리 관리</span>
                </a>
            </li>

           <li class="nav-item">
                <a class="nav-link collapsed" href="<%=request.getContextPath()%>/Ebook/ebookList.jsp" data-toggle="collapse" data-target="#collapsePages" aria-expanded="true" aria-controls="collapsePages">
               	<i class="fas fa-fw fa-folder"></i>
               	<span>ebook 관리</span>
                </a>
                <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">           
                        <a class="collapse-item" href="<%=request.getContextPath()%>/Ebook/ebookList.jsp">전체</a>
							<%
								ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
								for(String s : categoryNameList){
							%>
									<a class="collapse-item" href="<%=request.getContextPath()%>/Ebook/ebookList1.jsp?categoryName=<%=s%>"><%=s%></a>
							<%
								}
							%>                    
                    </div>
                </div>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="<%=request.getContextPath()%>/Orders/ordersList.jsp">
              	<i class="fas fa-fw fa-chart-area"></i>
              	<span>주문관리</span></a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="<%=request.getContextPath()%>/Notice/noticeList.jsp">
              	<i class="fas fa-fw fa-table"></i>
           		<span>공지관리</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

        </ul>
        <!-- End of Sidebar -->