package gd.mall.dao;
import java.sql.*;
import java.util.*;
import gd.mall.util.DBUtil;
import gd.mall.vo.*;

public class OrdersDao {
	// 주문 취소 메서드
	public static void updateOrdersState(int ordersNo) throws Exception{
		//sql
		String sql = "UPDATE orders SET orders_state=? WHERE orders_no=?";
		//db연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "주문취소");
		stmt.setInt(2, ordersNo);
		stmt.executeUpdate();
		System.out.println(stmt+"총 게시물 수");
	}
	
	// 총 게시물 수
	public static int totalRow() throws Exception{
		int totalRow = 0;
		//sql
		String sql = "SELECT COUNT(*) FROM orders";
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
	
	// orders join  ebook join client 리스트
	public static ArrayList<OrdersAndEbookAndClient> ordersList(int beginRow, int rowPerPage) throws Exception{
		ArrayList<OrdersAndEbookAndClient> list = new ArrayList<>();
		// sql
		String sql = "SELECT o.orders_no ordersNo,o.ebook_no ebookNo,o.client_no clientNo,o.orders_date ordersDate,o.orders_state ordersState,e.ebook_isbn ebookISBN, e.ebook_title ebookTitle,c.client_email clientEmail FROM orders o INNER JOIN ebook e INNER JOIN client c ON o.ebook_no = e.ebook_no AND o.client_no=c.client_no order by o.orders_date desc limit ?,?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		System.out.println(stmt+"주문리스트");
		while(rs.next()) {
			OrdersAndEbookAndClient oec = new OrdersAndEbookAndClient();
			
			Orders o = new Orders();
			o.setOrdersNo(rs.getInt("ordersNo"));
			o.setEbookNo(rs.getInt("ebookNo"));
			o.setClientNo(rs.getInt("clientNo"));
			o.setOrdersDate(rs.getString("ordersDate"));
			o.setOrdersState(rs.getString("ordersState"));
			oec.setOrders(o);
			
			Ebook e = new Ebook();
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookISBN(rs.getString("ebookISBN"));
			oec.setEbook(e);
			
			Client c = new Client();
			c.setClientEmail(rs.getString("clientEmail"));
			oec.setClient(c);
			
			list.add(oec);
		}
		return list;
	}
}
