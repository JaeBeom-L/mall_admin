package gd.mall.dao;
import gd.mall.vo.*;
import gd.mall.util.*;
import java.util.*;
import java.sql.*;

public class EbookDao {	
	// 전체 수정 메서드
	public static void updateEbook(Ebook ebook) throws Exception{
		//sql
		String sql = "UPDATE ebook SET category_name=?, ebook_author=?, ebook_company=?, ebook_page_count=?, ebook_price=? WHERE ebook_isbn=?";
		//db 호출
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"전체 수정");
		stmt.setString(1, ebook.getCategoryName());
		stmt.setString(2, ebook.getEbookAuthor());
		stmt.setString(3, ebook.getEbookCompany());
		stmt.setInt(4, ebook.getEbookPageCount());
		stmt.setInt(5, ebook.getEbookPrice());
		stmt.setString(6, ebook.getEbookISBN());
		stmt.executeUpdate(); 
	}
	
	
	// 상태 수정 메서드
	public static void updateEbookState(Ebook ebook) throws Exception{
		//sql
		String sql = "UPDATE ebook SET ebook_state=? WHERE ebook_isbn=? ";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"상태 수정");
		stmt.setString(1, ebook.getEbookState());
		stmt.setString(2, ebook.getEbookISBN());
		stmt.executeUpdate();
	}
	
	// 요약 수정 메서드
	public static void updateEbookSummary(Ebook ebook) throws Exception{
		//sql
		String sql = "UPDATE ebook SET ebook_summary=? WHERE ebook_isbn=?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"요약 수정");
		stmt.setString(1, ebook.getEbookSummary());
		stmt.setString(2, ebook.getEbookISBN());
		stmt.executeUpdate();
	}
	
	// 이미지 수정 메서드
	public static void updateEbookImg(Ebook ebook) throws Exception{
		// sql
		String sql = "UPDATE ebook SET ebook_img=? WHERE ebook_isbn=?";
		//db호출
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"이미지 수정");
		stmt.setString(1, ebook.getEbookImg());
		stmt.setString(2, ebook.getEbookISBN());
		stmt.executeUpdate();
	}
	
	//삭제 메서드
	public static void deleteEbook(String ebookISBN) throws Exception{
		//sql
		String sql = "DELETE FROM ebook WHERE ebook_isbn=?";
		//db호출
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"삭제");
		stmt.setString(1,ebookISBN);
		stmt.executeUpdate();
	}
	
	// 상세보기 메서드
	public static Ebook selectEbookOne(String ebookISBN) throws Exception{
		//sql문
		String sql = "SELECT ebook_no ebookNo, ebook_isbn ebookISBN, category_name categoryName, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_company ebookCompany, ebook_page_count ebookPageCount, ebook_price ebookPrice, ebook_summary ebookSummary, ebook_img ebookImg, substr(ebook_date,1,10) ebookDate, ebook_state ebookState FROM ebook WHERE ebook_isbn=?";
		Ebook ebook = new Ebook();
		
		//db 연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"상세보기");
		stmt.setString(1,ebookISBN);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			ebook.setEbookNo(rs.getInt("ebookNo"));
			ebook.setEbookISBN(rs.getString("ebookISBN"));
			ebook.setCategoryName(rs.getString("categoryName"));
			ebook.setEbookTitle(rs.getString("ebookTitle"));
			ebook.setEbookAuthor(rs.getString("ebookAuthor"));
			ebook.setEbookCompany(rs.getString("ebookCompany"));
			ebook.setEbookPageCount(rs.getInt("ebookPageCount"));
			ebook.setEbookPrice(rs.getInt("ebookPrice"));
			ebook.setEbookSummary(rs.getString("ebookSummary"));
			ebook.setEbookImg(rs.getString("ebookImg"));
			ebook.setEbookDate(rs.getString("ebookDate"));
			ebook.setEbookState(rs.getString("ebookState"));
		}
		
		return ebook;
	}
	
	// isbn 중복검사 메서드
		public static int checkISBN(String ebookISBN) throws Exception{
			int result = 0;
			String sql = "SELECT ebook_isbn FROM ebook WHERE ebook_isbn=?";
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			System.out.println(stmt+" 중복검사"); //디버깅 코드
			stmt.setString(1, ebookISBN);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) { // 중복된 값이 있으면 값이나오므로 확인가능
				result = 1;
			}
			return result;
		}
	
	// 입력 메서드
	public static int insertEbook(Ebook ebook) throws Exception{
		// sql
		String sql = "INSERT INTO ebook(ebook_isbn, category_name, ebook_title, ebook_author, ebook_company, ebook_page_count, ebook_price, ebook_summary, ebook_img, ebook_date, ebook_state) VALUES (?,?,?,?,?,?,?,?,'default.jpg',now(),'판매중')";
		int rowCnt=0;
		//db 연결
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"입력");
		stmt.setString(1, ebook.getEbookISBN());
		stmt.setString(2, ebook.getCategoryName());
		stmt.setString(3, ebook.getEbookTitle());
		stmt.setString(4, ebook.getEbookAuthor());
		stmt.setString(5, ebook.getEbookCompany());
		stmt.setInt(6, ebook.getEbookPageCount());
		stmt.setInt(7, ebook.getEbookPrice());
		stmt.setString(8, ebook.getEbookSummary());
		rowCnt = stmt.executeUpdate();
		return rowCnt;
	}
	
	
	
	
	// 리스트 출력 메서드
	public static ArrayList<Ebook> ebookList(int beginRow, int rowPerPage, String categoryName) throws Exception{
		ArrayList<Ebook> list = new ArrayList<>();
		PreparedStatement stmt;
		if(categoryName == null) {
			String sql = "SELECT category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, "
					+"substr(ebook_date,1,10) ebookDate, ebook_price ebookPrice FROM ebook ORDER BY ebook_date DESC limit ?,?";
			Connection conn = DBUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			System.out.println(stmt+" 평상시 리스트"); //디버깅 코드			
		} else{
			String sql = "SELECT category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, "
					+"substr(ebook_date,1,10) ebookDate, ebook_price ebookPrice FROM ebook WHERE category_name=? ORDER BY ebook_date DESC limit ?,?";
			Connection conn = DBUtil.getConnection();
			stmt = conn.prepareStatement(sql);			
			stmt.setString(1, categoryName);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			System.out.println(stmt+" 카테고리 리스트"); //디버깅 코드
		}
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Ebook e = new Ebook();
			e.setCategoryName(rs.getString("categoryName"));
			e.setEbookISBN(rs.getString("ebookISBN"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookAuthor(rs.getString("ebookAuthor"));
			e.setEbookDate(rs.getString("ebookDate"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
			list.add(e);
		}
		return list;
	}
	
	// 전체 행의 수 
	public static int totalRow(String categoryName) throws Exception {
		// 변수 초기화
		int totalRow = 0;
		PreparedStatement stmt;
		if(categoryName != null) {
			// 쿼리 작성
			String sql = "SELECT COUNT(*) FROM ebook WHERE category_name=?";			
			// DB 핸들링
			Connection conn = DBUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, categoryName);
		}else {
			// 쿼리 작성
			String sql = "SELECT COUNT(*) FROM ebook";			
			// DB 핸들링
			Connection conn = DBUtil.getConnection();
			stmt = conn.prepareStatement(sql);			
			System.out.println(stmt + "전체 행의 수"); // 디버깅
		}
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) { // ebook 행의 총 개수
			totalRow = rs.getInt("COUNT(*)");
		}
		// 결과값 리턴
		return totalRow;
		}
	
}
