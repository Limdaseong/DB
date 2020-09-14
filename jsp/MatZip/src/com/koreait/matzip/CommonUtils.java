package com.koreait.matzip;

public class CommonUtils {
	public static int parseStringToInt(String str) {
		try {
			return Integer.parseInt(str);
		} catch(Exception e) {	}
		return 0;
	}
	
	public static double parseStringToDouble(String str) {
		try {
			return Double.parseDouble(str);
		} catch(Exception e) {}
		return 0;
	}
}
