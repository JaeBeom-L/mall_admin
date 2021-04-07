package gd.mall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import gd.mall.util.DBUtil;
import gd.mall.vo.Client;
import gd.mall.vo.Ebook;
import gd.mall.vo.Orders;
import gd.mall.vo.OrdersAndEbookAndClient;

public class SearchDao {
	// 총 게시물 수
	public static int totalRow(String searchList, String searchWord) throws Exception{
		int totalRow = 0;
		PreparedStatement stmt = null;
		//sql
		if(searchList.equals("clientList")) {
			String sql = "SELECT COUNT(*) FROM client WHERE client_email LIKE ?";
			//db연결
			Connection conn = DBUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
		}else if(searchList.equals("ebookList")) {
			String sql = "SELECT COUNT(*) FROM ebook WHERE ebook_isbn Like ? or ebook_title Like ?";
			//db연결
			Connection conn = DBUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			stmt.setString(2, "%"+searchWord+"%");
		}else if(searchList.equals("ordersList")) {
			String sql = "SELECT COUNT(*) FROM orders o INNER JOIN ebook e INNER JOIN client c ON o.ebook_no = e.ebook_no AND o.client_no=c.client_no WHERE c.client_email LIKE ?";
			//db연결
			Connection conn = DBUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
		}
		
		ResultSet rs = stmt.executeQuery();
		System.out.println(stmt+" 총 게시물 수");
		if(rs.next()) {
			totalRow=rs.getInt("COUNT(*)");
		}
		return totalRow;
	}
	
	//검색 메서드 구현
	public static ArrayList<OrdersAndEbookAndClient> searchList(int beginRow, int rowPerPage, String searchList, String searchWord) throws Exception{
		ArrayList<OrdersAndEbookAndClient> list = new ArrayList<>();		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		if(searchList.equals("clientList")) {
			String sql = "SELECT client_email clientMail, substr(client_date, 1, 10) clientDate, client_no clientNo, client_pw clientPw FROM client WHERE client_email LIKE ?  ORDER BY client_date DESC limit ?,?";
			Connection conn = DBUtil.getConnection();
			stmt = conn.prepareStatement(sql);		
			stmt.setString(1, "%"+searchWord+"%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			System.out.println(stmt+" 검색 리스트"); //디버깅 코드
			rs = stmt.executeQuery();
			while(rs.next()) {
				OrdersAndEbookAndClient oec = new OrdersAndEbookAndClient();

				Client c = new Client();
				c.setClientEmail(rs.getString("clientMail"));
				c.setClientDate(rs.getString("clientDate"));
				c.setClientNo(rs.getInt("clientNo"));
				c.setClientPw(rs.getString("clientPw"));
				oec.setClient(c);
				
				list.add(oec);
			}
		}else if(searchList.equals("ebookList")) {
			String sql = "SELECT ebook_no ebookNo, category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, substr(ebook_date,1,10) ebookDate, ebook_price ebookPrice, ebook_company ebookCompany FROM ebook WHERE ebook_isbn Like ? or ebook_title Like ? ORDER BY ebook_date DESC limit ?,?";
			Connection conn = DBUtil.getConnection();
			stmt = conn.prepareStatement(sql);		
			stmt.setString(1, "%"+searchWord+"%");
			stmt.setString(2, "%"+searchWord+"%");
			stmt.setInt(3, beginRow);
			stmt.setInt(4, rowPerPage);
			System.out.println(stmt+" 검색 리스트"); //디버깅 코드
			rs = stmt.executeQuery();
			while(rs.next()) {
				OrdersAndEbookAndClient oec = new OrdersAndEbookAndClient();
				
				Ebook e = new Ebook();
				e.setEbookTitle(rs.getString("ebookTitle"));
				e.setEbookISBN(rs.getString("ebookISBN"));
				e.setEbookAuthor(rs.getString("ebookAuthor"));
				e.setCategoryName(rs.getString("CategoryName"));
				e.setEbookCompany(rs.getString("ebookCompany"));
				e.setEbookDate(rs.getString("ebookDate"));
				e.setEbookNo(rs.getInt("ebookNo"));
				e.setEbookPrice(rs.getInt("ebookPrice"));
				oec.setEbook(e);
				
				list.add(oec);
			}
		}else if(searchList.equals("ordersList")) {
			String sql = "SELECT o.orders_no ordersNo, o.ebook_no ebookNo,o.client_no clientNo,o.orders_date ordersDate,o.orders_state ordersState,e.ebook_isbn ebookISBN, e.ebook_title ebookTitle, e.ebook_author ebookAuthor, e.category_name categoryName, e.ebook_company ebookCompany, e.ebook_date ebookDate, e.ebook_no ebookNo, e.ebook_price ebookPrice, c.client_email clientEmail FROM orders o INNER JOIN ebook e INNER JOIN client c ON o.ebook_no = e.ebook_no AND o.client_no=c.client_no WHERE c.client_email LIKE ? order by o.orders_date desc limit ?,?";
			Connection conn = DBUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			System.out.println(stmt+"orders검색");
			rs = stmt.executeQuery();
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
				e.setEbookAuthor(rs.getString("ebookAuthor"));
				e.setCategoryName(rs.getString("CategoryName"));
				e.setEbookCompany(rs.getString("ebookCompany"));
				e.setEbookDate(rs.getString("ebookDate"));
				e.setEbookNo(rs.getInt("ebookNo"));
				e.setEbookPrice(rs.getInt("ebookPrice"));
				oec.setEbook(e);
				
				Client c = new Client();
				c.setClientEmail(rs.getString("clientEmail"));
				oec.setClient(c);
				list.add(oec);
				
			}
		}		
		return list;
	}
}
