package org.calk.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class OrderItemsVO {
	private int prodIds;
	private int prices;
	private int quantities;

}
