package gd.mall.dao;
import gd.mall.util.*;
import gd.mall.vo.*;
import java.util.*;
import java.sql.*;
public class NoticeDao {
	// 삭제 메서드 (DELETE)
	public static void deleteNotice(int noticeNo) throws Exception{
		//sql
		String sql = "DELETE FROM notice WHERE notice_no=?";
		//db 연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"공지삭제"); //디버깅 코드
		stmt.setInt(1,noticeNo);
		stmt.executeUpdate();
	}
	
	// 수정 메서드 (UPDATE)
	public static void updateNotice(Notice notice) throws Exception{
		//sql
		String sql = "UPDATE notice SET notice_title=?, notice_content=? WHERE notice_no=?";
		//db연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"공지수정"); //디버깅 코드
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3, notice.getNoticeNo());
		stmt.executeUpdate();
	}
	
	
	// 내용 확인 메서드 (READ)
	public static Notice noticeOne(int noticeNo) throws Exception{
		//sql
		String sql = "SELECT notice_title noticeTitle, notice_content noticeContent, notice_date noticeDate, manager_id managerId FROM notice WHERE notice_no=?;";
		//db연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"내용확인"); //디버깅 코드
		stmt.setInt(1, noticeNo);
		ResultSet rs = stmt.executeQuery();
		Notice notice = new Notice();
		if(rs.next()) {
			notice.setNoticeTitle(rs.getString("noticeTitle"));
			notice.setNoticeContent(rs.getString("noticeContent"));
			notice.setNoticeDate(rs.getString("noticeDate"));
			notice.setManagerId(rs.getString("managerId"));
		}
		return notice;
	}
	
	
	// 공지 입력 메서드 (CREATE)
	public static void insertNotice(Notice notice) throws Exception{
		//sql
		String sql = "INSERT into notice(notice_title, notice_content, notice_date, manager_id) VALUES(?, ?, now(), ?)";
		//db연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"공지입력"); //디버깅 코드
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setString(3, notice.getManagerId());
		stmt.executeUpdate();
	}
	
	// 전체 행 계산 메서드
	public static int totalRow() throws Exception{
		//return값 초기화
		int totalRow = 0;
		//sql
		String sql = "SELECT COUNT(*) FROM notice";
		//db 연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"마지막 행"); //디버깅 코드
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			totalRow = rs.getInt("COUNT(*)");
		}
		return totalRow;
	}
	
	// 공지 리스트 출력 메서드
	public static ArrayList<Notice> noticeList(int beginRow, int rowPerPage) throws Exception{
		// sql
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, notice_date noticeDate, manager_id managerId FROM notice ORDER BY notice_date desc limit ?,?";
		//db연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"공지 리스트"); //디버깅 코드
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Notice> list = new ArrayList<>();
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeTitle(rs.getString("noticeTitle"));
			n.setNoticeContent(rs.getString("noticeContent"));
			n.setNoticeDate(rs.getString("noticeDate"));
			n.setManagerId(rs.getString("managerId"));
			list.add(n);
		}
		return list;
	}
}
