package org.calk.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class SaleVO {
	private Date saleDate;
	private int selCust;
	private int total;
	private int userId;
	private int orderId;
	private int[] prodIds;
	private int[] prices;
	private int[] quantities;
	
	private List<OrderItemsVO> orderItems;
}
