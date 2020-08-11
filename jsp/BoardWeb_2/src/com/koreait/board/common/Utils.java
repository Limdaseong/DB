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
}
