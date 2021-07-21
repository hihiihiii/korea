package com.spring.board.vo;

public class PageVo {
	
	private int pageNo = 0;
	private int perPageNo;
	private int rowStart;
	private int rowEnd;
	private String[] codeId;
	
	public PageVo() {
		this.pageNo = 1;
		this.perPageNo = 10;
	}
	
	public void setPageNo(int pageNo) {
		if (pageNo <= 0) {
			this.pageNo = 1;
			return;
		}
		this.pageNo = pageNo;
	}
	
	public void setPerPageNum(int perPageNo) {
		if (perPageNo <= 0 || perPageNo > 100) {
			this.perPageNo = 10;
			return;
		}
		this.perPageNo = perPageNo;
	}
	
	public int getPageNo() {
		return pageNo;
	}
	
	public int getPageStart() {
		return (this.pageNo - 1) * pageNo;
	}
	
	public int getPerPageNum() {
		return this.perPageNo;
	}
	
	public int getRowStart() {
		rowStart = ((pageNo - 1) * perPageNo) + 1;
		return rowStart;
	}
	
	public int getRowEnd() {
		rowEnd = rowStart + perPageNo - 1;
		return rowEnd;
	}

	@Override
	public String toString() {
		return "Criteria [page=" + pageNo + ", perPageNum=" + perPageNo + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd
				+ "]";
	}

	public String[] getCodeId() {
		return codeId;
	}

	public void setCodeId(String[] codeId) {
		this.codeId = codeId;
	}


}
