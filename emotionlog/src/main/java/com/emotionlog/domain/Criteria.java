package com.emotionlog.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {

	private int pageNum;
	private int amount;
	
	// 검색 처리
	private String type;
	private String keyword;
	
	public Criteria() {
		this(1,10); // 1페이지에 10개씩~
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	// 검색 처리
	// getTypeArr 은 검색 조건이 각 글자(T,W,C)로 구성되어 있으므로 검색 조건을 배열로 만들어서 한번에 처리하기 위함
	// getTypeArr 메서드는 검색 조건을 처리할때 MyBatis 쿼리에서 호출된다.(MyBatis 매퍼 xml 파일에서 <foreach> 구문을 사용할때)
	public String[] getTypeArr() {
		return type == null? new String[] {}: type.split("");
	}
	
	// UriComponentsBuilders 를 이용하는 링크 생성
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		return builder.toUriString();
	}
	
}
