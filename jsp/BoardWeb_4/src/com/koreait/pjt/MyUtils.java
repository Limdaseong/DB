package com.koreait.pjt;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MyUtils {
	public static String encryptString(String str) {
		 String sha = "";

	       try{
	          MessageDigest sh = MessageDigest.getInstance("SHA-256");
	          sh.update(str.getBytes());
	          byte byteData[] = sh.digest();
	          StringBuffer sb = new StringBuffer(); // 문자열을 합치게 하는 것이다(문자열계의 배열)
	          // sb라는 객체에 자기가 알아서 문자열을 늘린다 (for문에서는 StringBuffer가 사용되지 않는다)
	          
	          for(int i = 0 ; i < byteData.length ; i++){
	              sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
	          }

	          sha = sb.toString();

	      }catch(NoSuchAlgorithmException e){
	          //e.printStackTrace();
	          System.out.println("Encrypt Error - NoSuchAlgorithmException");
	          sha = null;
	      }

	      return sha;
	}
}
