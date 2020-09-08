package com.koreait.matzip.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class JdbcTemplate {
	
	public static int executeUpdate(String sql, JdbcUpdateInterface jdbc) {
		// 누구를 가리킨다는 것은 객체이다 객체는 구현이 되어있어야 객체이다(그러므로 jdbc는 구현돼있다)
		
		int result = 0;
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = DbManager.getCon();
			ps = con.prepareStatement(sql);
			
			jdbc.update(ps);
			
			result = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbManager.close(con, ps);
		}
		
		return result;
	}
	
	public static void executeQuery(String sql, JdbcSelectInterface jdbc) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = DbManager.getCon();
			ps = con.prepareStatement(sql);
			jdbc.prepared(ps);
			
			rs = ps.executeQuery();
			jdbc.executeQuery(rs);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbManager.close(con, ps, rs);
		}
	}
}
