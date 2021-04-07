<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%><!-- 업로드 파일이 중복 되지 않게 해준다 -->
<%@ page import="gd.mall.vo.*" %>
<%@ page import="gd.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	//String ebookISBN = request.getParameter("ebookISBN");이렇게 데이터를 받아오면 받지 못한다. binary 이진 수로 받기 때문에 못 받는다.
	//String ebookImg = request.getParameter("ebookImg");
	
	//파일 다운로드 받을 위치
	//application.getRealPath("img");// 톰캣 서버의 파일 경로를 알려준다
	// String path = application.getRealPath("img"); //img라는 폴더의 os상의 실제 폴더
	String path = "D:/goodie/web/mall_admin/WebContent/img";
	
	int size = 1024 * 1024 * 10; //1단위당 1바이트 <--- 10mb
	MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy()); // request를 이 메서드에 위임하여 메서드는 해석을 한다./경로/파일처리가능용량/인코딩/중복된 이름 있으면 어떻게할건지
	String ebookISBN = multi.getParameter("ebookISBN");
	String ebookImg = multi.getFilesystemName("ebookImg");
	System.out.println(ebookISBN+"이미지");
	System.out.println(ebookImg+"이미지");
	
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookImg(ebookImg);
	EbookDao.updateEbookImg(ebook);
	
	response.sendRedirect(request.getContextPath()+"/Ebook/ebookOne.jsp?ebookISBN="+ebookISBN); // 이미지 수정후 수정한 정보로 다시 출력
%>