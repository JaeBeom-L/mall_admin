package gd.mall.dao;
import gd.mall.util.*;
import gd.mall.vo.*;
import java.util.*;
import java.sql.*;
public class ClientDao {
	// 고객 정보 출력 메서드
	public static Client clientInformation(int clientNo) throws Exception{
		Client c = null;
		String sql ="SELECT client_no clientNo, client_email clientMail, client_pw clientPw, client_date clientDate FROM client WHERE client_no=?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);		
		stmt.setInt(1, clientNo);
		System.out.println(stmt+"고객정보출력"); //디버깅코드
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			c = new Client();
			c.setClientNo(rs.getInt("clientNo"));
			c.setClientPw(rs.getString("clientPw"));
			c.setClientEmail(rs.getString("clientMail"));
			c.setClientDate(rs.getString("clientDate"));
		}
		return c;
	}
	
	//수정 메서드
	public static void updateClientList(String clientPw, int clientNo) throws Exception{
		String sql = "UPDATE client SET client_pw=password(?) WHERE client_no=?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);		
		stmt.setString(1, clientPw);
		stmt.setInt(2, clientNo);
		System.out.println(stmt+"고객수정메서드"); //디버깅코드
		stmt.executeUpdate();
	}
	
	//삭제 메서드
	public static void deleteClientList(int clientNo) throws Exception{
		String sql = "DELETE FROM client WHERE client_no=?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt); //디버깅코드
		stmt.setInt(1, clientNo);
		stmt.executeUpdate();
	}
	
	//전체 행의 수
	public static int totalRow(String searchWord) throws Exception{ //매개변수로 searchWord 검색에 따라 행의 수가 변하도록 한다
		
		int totalRow = 0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		String sql = "";
		if(searchWord.equals("")) {
			sql="SELECT COUNT(*) FROM client";
			stmt = conn.prepareStatement(sql);
		}else {
			sql="SELECT COUNT(*) FROM client WHERE client_email LIKE ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
		}
		
		System.out.println(stmt);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) { // client table의 총 행의수 count(*)열의 값을 받아온다.
			totalRow=rs.getInt("COUNT(*)");
		}
		System.out.println(totalRow); //디버깅 코드
		return totalRow;
		}
	
	
	
	
	//목록
	public static ArrayList<Client> clientList(int beginRow, int rowPerPage, String searchWord) throws Exception{
		//Client 타입의 배열list 생성
		ArrayList<Client> list = new ArrayList<>();
		
		Connection conn = DBUtil.getConnection();
		//1.sql 문 작성
		PreparedStatement stmt = null;
		String sql = "";
		
		if(searchWord.equals("")) {
			sql="SELECT client_no clientNo, client_email clientMail, substr(client_date,1,10) clientDate FROM client ORDER BY client_date DESC limit ?,?;";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		}else {
			sql="SELECT client_no clientNo, client_email clientMail, substr(client_date,1,10) clientDate FROM client WHERE client_email like ? ORDER BY client_date DESC limit ?,?;";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		}			
		//3.db 핸들링
		System.out.println(stmt); // 디버깅코드
		ResultSet rs = stmt.executeQuery();
		//4. list를 리턴하여 메서드 끝을 알림
		while(rs.next()) {
			Client c = new Client();
			c.setClientNo(rs.getInt("clientNo"));
			c.setClientEmail(rs.getString("clientMail"));
			c.setClientDate(rs.getString("clientDate"));
			list.add(c);
		}
		return list;
		}
	
}
