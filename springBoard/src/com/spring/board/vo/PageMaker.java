package com.spring.board.vo;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {
	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int displayPageNum = 10;
	private PageVo pageVo;
	
	public void setCri(PageVo pageVo) {
		this.pageVo = pageVo;
	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}
	
	public int getTotalCount() {
		return totalCount;
	}
	
	public int getStartPage() {
		return startPage;
	}
	
	public int getEndPage() {
		return endPage;
	}
	
	public boolean isPrev() {
		return prev;
	}
	
	public boolean isNext() {
		return next;
	}
	
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	
	public PageVo getPageVo() {
		return pageVo;
	}
	 
	private void calcData() {
		endPage = (int) (Math.ceil(pageVo.getPageNo() / (double)displayPageNum) * displayPageNum);
		startPage = (endPage - displayPageNum) + 1;
	  
		int tempEndPage = (int) (Math.ceil(totalCount / (double)pageVo.getPerPageNum()));
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		prev = startPage == 1 ? false : true;
		next = endPage * pageVo.getPerPageNum() >= totalCount ? false : true;
	}
	
	public String makeQuery(int pageNo) {
		UriComponents uriComponents =
		UriComponentsBuilder.newInstance()
						    .queryParam("pageNo", pageNo)
							.queryParam("perPageNum", pageVo.getPerPageNum())
							.build();
		   
		return uriComponents.toUriString();
	}
}
