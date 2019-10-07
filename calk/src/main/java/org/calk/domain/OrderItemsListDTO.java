package org.calk.domain;

import lombok.Data;

@Data
public class OrderItemsListDTO extends OrderListDTO {
	private String category, product_name;
	private int product_id;
}
