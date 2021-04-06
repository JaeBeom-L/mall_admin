package gd.mall.dao;
import gd.mall.util.*;
import gd.mall.vo.*;
import java.util.*;
import java.sql.*;
public class CategoryDao {
	// 카테고리 삽입 메서드
	public static void insertCategory(String categoryName) throws Exception{
		//sql
		String sql = "INSERT INTO category(category_name, category_weight, category_date) VALUES(?, 0, now())"; //가중치 초기값은 0으로 설정
		//db불러오기
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"삽입"); //디버깅코드
		stmt.setString(1, categoryName);
		stmt.executeUpdate();
	}
	
	// 수정 메서드
	public static void updateCategory(int categoryWeight, int categoryNo) throws Exception{ // 카테고리 넘버가 맞아야 수정
		// sql
		String sql = "UPDATE category SET category_weight=? WHERE category_no=?";
		//db 불러오기
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"수정"); // 디버깅 코드
		stmt.setInt(1,categoryWeight);
		stmt.setInt(2, categoryNo);
		stmt.executeUpdate();
	}
	
	// 삭제 메서드
	public static void deleteCategory(int categoryNo) throws Exception{
		// sql
		String sql = "DELETE FROM category WHERE category_no=?";
		//db불러오기
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"삭제");//디버깅 코드
		stmt.setInt(1, categoryNo);
		stmt.executeUpdate();
	}
	
	// 목록 메서드
	public static ArrayList<Category> categoryList() throws Exception{
		// sql
		String sql = "SELECT category_no categoryNo, category_name categoryName, category_weight categoryWeight FROM category";
		// 초기화
		ArrayList<Category> list = new ArrayList<>();
		//db 불러오기
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + "목록"); // 디버깅코드
		//처리
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setCategoryName(rs.getString("categoryName"));
			c.setCategoryWeight(rs.getInt("categoryWeight"));
			list.add(c);
		}
		return list; //리스트 반환
	}
	// 총 카테고리 수
	public static int totalRow() throws Exception{		
		int totalRow = 0;
		// sql
		String sql = "SELECT COUNT(*) FROM category";
		//db 불러오기
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"총 카테고리 수"); // 디버깅 코드
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			totalRow=rs.getInt("COUNT(*)");
		}
		return totalRow;
	}
	
	// 카테고리 출력 메서드
		public static ArrayList<String> categoryNameList() throws Exception{
			// sql
			String sql = "SELECT category_name categoryName FROM category";
			// 초기화
			ArrayList<String> list = new ArrayList<>();
			//db 불러오기
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			System.out.println(stmt + "목록"); // 디버깅코드
			//처리
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				String cn = new String();				
				cn = rs.getString("categoryName");				
				list.add(cn);
			}
			return list; //리스트 반환
		}
}
