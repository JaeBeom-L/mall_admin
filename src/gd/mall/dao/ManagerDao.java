package gd.mall.dao;
import gd.mall.util.DBUtil;
import gd.mall.vo.Manager;
import java.sql.*;
import java.util.*;
public class ManagerDao {
	// 총 게시물 수
	public static int totalRow() throws Exception{
		int totalRow = 0;
		//sql
		String sql = "SELECT COUNT(*) FROM manager";
		//db연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		System.out.println(stmt+"총 게시물 수");
		if(rs.next()) {
			totalRow=rs.getInt("COUNT(*)");
		}
		return totalRow;
	}

	// 매니저 대기 명단
	public static ArrayList<Manager> selectManagerListByZero() throws Exception{
		String sql = "SELECT manager_id managerId, manager_date managerDate FROM manager WHERE manager_level=0 ORDER BY manager_date DESC;";
		//2. 리턴값 초기화
		ArrayList<Manager> list = new ArrayList<>(); //Manager 타입의 list배열 생성
		//3. 처리
		Connection conn = ManagerDao.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);	
		ResultSet rs = stmt.executeQuery();
		System.out.println(stmt+"매니저대기명단");
		while(rs.next()) {
			Manager m = new Manager();
			m.setManagerId(rs.getString("managerId"));
			m.setManagerDate(rs.getString("managerDate"));			
			list.add(m);
		}
		
		return list;
	}
	
	//삭제 메서드
	public static void deleteManager(int managerNo) throws Exception{
		//1. sql문
		String sql = "DELETE FROM manager where manager_no=?;";
		//2. db처리
		Connection conn = ManagerDao.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt);
		stmt.setInt(1, managerNo);
		stmt.executeUpdate();		
	}
	
	
	//수정 메서드
	public static void updateManagerLevel(int managerNo, int managerLevel) throws Exception{
	
		//1. sql
		String sql = "UPDATE manager SET manager_level=? where manager_no=?;";
		//2. db 처리
		Connection conn = ManagerDao.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.print(stmt);
		stmt.setInt(1,managerLevel);
		stmt.setInt(2, managerNo);
		stmt.executeUpdate();
		
	}
	
		
		
	
	
	// 목록 메서드
	public static ArrayList<Manager> selectManagerList(int beginRow, int rowPerPage) throws Exception{
		//1. sql
		//매니저 레벨은 높은 순, 가입 날짜는 빠른 순으로 정렬
		String sql = "SELECT manager_no managerNo, manager_id managerId, manager_name managerName, manager_date managerDate, manager_level managerLevel FROM manager ORDER BY manager_level desc, manager_date desc limit ?,?;";
		//2. 리턴값 초기화
		ArrayList<Manager> list = new ArrayList<>(); //Manager 타입의 list배열 생성
		//3. 처리
		Connection conn = ManagerDao.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Manager m = new Manager();
			m.setManagerNo(rs.getInt("managerNo"));
			m.setManagerId(rs.getString("managerId"));
			m.setManagerName(rs.getString("managerName"));
			m.setManagerDate(rs.getString("managerDate"));
			m.setManagerLevel(rs.getInt("managerLevel"));
			list.add(m);
		}
		
		return list;
	}
	
	
	// 입력 메서드
	public static int insertManager(String managerId, String managerPw, String managerName) throws Exception{
		// sql문
		String sql = "INSERT INTO manager(manager_id, manager_pw, manager_name, manager_date, manager_level) VALUES(?,?,?,now(),0)";
		// 2.리턴값 초기화
		int rowCnt = 0; //입력성공 실패가 1,0
		//3. db핸들링
		Connection conn = ManagerDao.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		stmt.setString(2, managerPw);
		stmt.setString(3, managerName);
		rowCnt = stmt.executeUpdate();
		System.out.print(stmt);
		return rowCnt;
	}
	
	// id 사용가능여부
	public static String selectManagerId(String managerId) throws Exception {
		// 1. sql문
		String sql = "SELECT manager_id FROM manager WHERE manager_id = ?";
		// 2. 리턴타입 초기화
		String returnManagerId = null;
		//3. db핸들링
		Connection conn = ManagerDao.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		System.out.print(stmt);
		ResultSet rs = stmt.executeQuery();		
		if(rs.next()) {
			returnManagerId = rs.getString("manager_id");
		}
		//4.리턴
		return returnManagerId;
	}
	
	// 로그인 메서드
	public static Manager login(String managerId, String managerPw) throws Exception {
		String sql = "SELECT manager_id, manager_name, manager_level FROM manager WHERE manager_id=? AND manager_pw=? AND manager_level>0";
		Manager manager = null;
		Connection conn = ManagerDao.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		stmt.setString(2, managerPw);
		System.out.println(stmt + " <--login() sql");
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			manager = new Manager();
			manager.setManagerId(rs.getString("manager_id"));
			manager.setManagerName(rs.getString("manager_name"));
			manager.setManagerLevel(rs.getInt("manager_level"));
		}
		return manager;
	}
	
	//DB 연결 메소드
	public static Connection getConnection() throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/mall","root","java1004");
		return conn;
	}
}
