package com.koreait.pjt.vo;

/**
 * @author Administrator
 *
 */
public class BoardDomain extends BoardVO {
	// join할 때 편하라고 board
	
	private String nm;
	private int yn_like;
	public String getNm() {
		return nm;
	}
	public void setNm(String nm) {
		this.nm = nm;
	}
	public int getYn_like() {
		return yn_like;
	}
	public void setYn_like(int yn_like) {
		this.yn_like = yn_like;
	}
}



