package com.ezen.myProject.domain;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class PagingVO {
	
	private int pageNo; // 현재 화면에 출력 된 페이지네이션 번호 ex) 1 선택하면 1, 2 선택하면 2
	private int qty; // 한 페이지에 보이는 게시글 수
	
	private String type;
	private String keyword;
	
	public PagingVO() {
		this(1,10);
	}
	
	public PagingVO(int pageNo, int qty) {
		this.pageNo = pageNo;
		this.qty = qty;
	}
	
	public int getPageStart() { // 시작(start) 번호 구하는 메서드
		return (this.pageNo - 1) * qty; // DB에서 값을 limit 첫 시작이 0번지
	}

	public String[] getTypeToArray() {
		return this.type == null ? new String[] {} : this.type.split("");
	}
}
