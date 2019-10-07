package org.calk.domain;

import java.util.Date;

import lombok.Data;

@Data
public class SearchOrderVO {
	
	private Date saleDateFrom, saleDateTo;
	private String selCate, selCust, selProd;

}
