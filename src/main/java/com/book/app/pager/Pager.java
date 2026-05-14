package com.book.app.pager;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Pager {
	
	private Long page;
	private Long perPage;
	private Long startNum;
	private String search = "";
	private String kind;
	private Long start;
	private Long end;
	private boolean pre = true;
	private boolean next = true;
	private String username;
	
	public Long getPage() {
		if(page==null || page<1) {
			this.page=1L;
		}
		return this.page;
	}
	
	public Long getPerPage() {
		if(perPage==null || perPage<1) {
			this.perPage=5L;
		}
		return this.perPage;
	}
	
	public void makeStartNum() {
		this.startNum = (this.getPage()-1)*getPerPage();
	}
	
	public void makePageNum(Long totalCount) {
		Long totalPage = (long)(Math.ceil((double)totalCount/getPerPage()));
		
		Long perBlock = 5L;
		Long totalBlock = totalPage/perBlock;
		if(totalPage%perBlock != 0) {
			totalBlock++;
		}
		
		Long curBlock = getPage()/perBlock;
		if(getPage()%perBlock != 0) {
			curBlock++;
		}
		
		start = (curBlock-1)*perBlock+1;
		end = curBlock*perBlock;
		
		if(curBlock==totalBlock) {
			end = totalPage;
			next = false;
		}
		
		if(curBlock==1) {
			pre = false;
		}
	}

}
