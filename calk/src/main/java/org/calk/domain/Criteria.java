package org.calk.domain;

import java.util.Date;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	
	private Date saleDateFrom, saleDateTo;
	private String selCate, selCust, selProd;
	
	private int pageNum, amount;

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

}
