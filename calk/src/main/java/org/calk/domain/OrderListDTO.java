package org.calk.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OrderListDTO {
	private int order_id, customer_id, order_total, user_id;
	private String customerName, userName;
	private Date order_timestamp;
}
