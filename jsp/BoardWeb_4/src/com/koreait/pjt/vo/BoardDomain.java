package com.koreait.pjt.vo;

public class BoardDomain extends BoardVO {
	// join할 때 편하라고 board
	
	private int yn_like;
	private int record_cnt; // 페이지당 나오는 레코드 수 (글 수)
	private int eIdx;
	private int sIdx;
	private String searchText;
	private String searchType;
	private int cmt_cnt;
	
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public int getCmt_cnt() {
		return cmt_cnt;
	}
	public void setCmt_cnt(int cmt_cnt) {
		this.cmt_cnt = cmt_cnt;
	}
	
	public String getSearchText() {
		return searchText;
	}
	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}
	public int getRecord_cnt() {
		return record_cnt;
	}
	public void setRecord_cnt(int record_cnt) {
		this.record_cnt = record_cnt;
	}
	
	public int geteIdx() {
		return eIdx;
	}
	public void seteIdx(int eIdx) {
		this.eIdx = eIdx;
	}
	public int getsIdx() {
		return sIdx;
	}
	public void setsIdx(int sIdx) {
		this.sIdx = sIdx;
	}
	
	public int getYn_like() {
		return yn_like;
	}
	public void setYn_like(int yn_like) {
		this.yn_like = yn_like;
	}
}



