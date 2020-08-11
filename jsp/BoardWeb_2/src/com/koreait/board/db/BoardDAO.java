package com.koreait.board.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.koreait.board.vo.BoardVO;

public class BoardDAO {
	
	public static int delBoard(int i_board) { // pk값을 삭제할거니까 하나의 값을 삽입
		
		int result = 0; // 경우의 수는 2개 ( 0, 1)
		Connection con = null;
		PreparedStatement ps = null;
		
		String sql = " DELETE FROM t_board where i_board = ? ";
		
		try {
			con = DbCon.getCon();
			ps = con.prepareStatement(sql);
			ps.setInt(1, i_board);
			
			result = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbCon.close(con, ps);
		}
		
		return result;
	}
	
	public static int insBoard(BoardVO param) {
		int result = 0;
		Connection con = null;
		PreparedStatement ps = null;
		
		//시퀀스는 오라클에만 있다
		String sql = " INSERT INTO t_board"
				+ " (i_board, title, ctnt, i_student)"
				+ " VALUES"
				+ " (seq_board.nextval, ?, ?, ?) ";
		
		try {
			con = DbCon.getCon();
			ps = con.prepareStatement(sql);
			ps.setNString(1, param.getTitle());
			ps.setNString(2, param.getCtnt());
			ps.setInt(3,  param.getI_student());
			
			result = ps.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbCon.close(con, ps);
		}
		return result;
	}
	
	//리스트
	public static List<BoardVO> selBoardList() {
		List<BoardVO> list = new ArrayList();
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = " SELECT i_board, title, ctnt, i_student FROM t_board ORDER BY i_board asc ";
		
		try {
			con = DbCon.getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				int i_board = rs.getInt("i_board");
				String title = rs.getNString("title");
				String ctnt = rs.getNString("ctnt");
				int i_student = rs.getInt("i_student");
				
				BoardVO vo = new BoardVO();
				
				vo.setI_board(i_board);
				vo.setTitle(title);
				vo.setCtnt(ctnt);
				vo.setI_student(i_student);
				
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbCon.close(con, ps, rs);
		}
		return list;
	}
	
	//디테일
	public static BoardVO selBoard(BoardVO param) {
		BoardVO vo = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = " SELECT i_board, title, ctnt, i_student FROM t_board " 
		+ " WHERE i_board = ? ";
		
		try {
			con = DbCon.getCon();
			ps = con.prepareStatement(sql);
			ps.setInt(1, param.getI_board());
			
			rs = ps.executeQuery();
			
			if(rs.next()) { 							// 최대 나올 수 있는 레코드 수 : 1줄
				int i_board = rs.getInt("i_board");
				String title = rs.getNString("title");
				String ctnt = rs.getNString("ctnt");
				int i_student = rs.getInt("i_student");
				
				vo = new BoardVO(); // 만약 자료가 없으면 null이 반환되게 하려고
				vo.setI_board(i_board);
				vo.setTitle(title);
				vo.setCtnt(ctnt);
				vo.setI_student(i_student);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbCon.close(con, ps, rs);
		}
		return vo;
	}
	
}



