package com.koreait.board.common;

public class Utils {
	
	public static int parseStrToInt(String str) {
		return parseStrToInt(str, 0);
	}

	public static int parseStrToInt(String strI_board, int defNo) {
		try {
			return Integer.parseInt(strI_board);
		} catch(Exception e) {
			return defNo;
		} 
	}
	
	public static int swErr(int err) {
		switch(result) {
		case 1:
			response.sendRedirect("/jsp/board_List.jsp");
			return;
			
		case 0:
			err = 10;
			break;
			 
		case -1:
			err = 20;
			break;
		}
		response.sendRedirect("/jsp/boardWrite.jsp?err="+err);
	}
}
