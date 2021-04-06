package gd.mall.dao;
import gd.mall.util.DBUtil;
import gd.mall.vo.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
public class CommentDao {
	// 댓글 확인 메서드
	public static int selectCommentCnt(int noticeNo) throws Exception {
		int rowCnt = 0;
		// sql
		String sql = "SELECT COUNT(*) FROM comment WHERE notice_no=?";
		//db연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);		
		stmt.setInt(1, noticeNo);
		System.out.println(stmt+"댓글 확인");
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			rowCnt = rs.getInt("COUNT(*)");
		}
		return rowCnt;
	}
	
	// 댓글 입력 메서드
	public static void insertComment(Comment comment) throws Exception{
		//sql
		String sql = "INSERT INTO comment (notice_no, comment_content, comment_date, manager_id) VALUES(?,?,now(),?)";
		//db연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);		
		stmt.setInt(1, comment.getNoticeNo());
		stmt.setString(2, comment.getCommentContent());
		stmt.setString(3, comment.getManagerId());
		stmt.executeUpdate();		
		System.out.println(stmt+"댓글리스트");
	}
	
	// 댓글 리스트 출력 메서드)
	public static ArrayList<Comment> commentList(int noticeNo) throws Exception{
		ArrayList<Comment> list = new ArrayList<>();
		// sql
		String sql = "SELECT comment_no commentNo, comment_content commentContent, comment_date commentDate, manager_id managerId  FROM comment WHERE notice_no=? ORDER BY comment_date DESC";
		// db연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		ResultSet rs = stmt.executeQuery();
		System.out.println(stmt+"댓글리스트");
		while(rs.next()) {
			Comment c = new Comment();
			c.setCommentNo(rs.getInt("commentNo"));
			c.setCommentContent(rs.getString("commentContent"));
			c.setCommentDate(rs.getString("commentDate"));
			c.setManagerId(rs.getString("managerId"));
			list.add(c);
		}
		return list;
	}

	// deleteComment method의 오버로딩(메서드 이름이 같지만 매개변수가 다름)
	// 매니저 레벨 2 일때 삭제 메서드
	public static void deleteComment(int commentNo) throws Exception{ //commentNo
		//sql
		String sql = "DELETE FROM comment WHERE comment_no=?";
		//db연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		System.out.println(stmt +"매니저레벨2 삭제"); //디버깅코드
		stmt.executeUpdate();
	}
	
	//매니저 레벨이 1일 때 삭제 메서드
	public static void deleteComment(int commentNo, String managerId) throws Exception{ //commentNo, managerId를 알아야한다.
		//sql
		String sql = "DELETE FROM comment WHERE comment_no=? AND manager_id=?";
		//db연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		stmt.setString(2, managerId);
		System.out.println(stmt +"매니저레벨1 삭제"); //디버깅코드
		stmt.executeUpdate();
	}
}

