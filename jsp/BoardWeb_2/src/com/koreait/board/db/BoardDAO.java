package com.koreait.board.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.koreait.board.vo.BoardVO;

public class BoardDAO {
	public static List<BoardVO> selBoardList() {
		List<BoardVO> list = new ArrayList();
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = " SELECT i_board, title, ctnt, i_student FROM t_board ";
		
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
	
	public static BoardVO istBoard(Board)
}



