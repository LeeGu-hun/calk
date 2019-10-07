package org.calk.mapper;

import java.util.List;

import org.calk.domain.Criteria;
import org.calk.domain.OrderItemsListDTO;
import org.calk.domain.OrderListDTO;
import org.calk.domain.SaleVO;

public interface SaleMapper {
	public void regOrders(SaleVO vo);
	public void regOrderItems(SaleVO vo);
	public List<OrderListDTO> getOrders(Criteria cri);
	public List<OrderItemsListDTO> getOrderItems(Criteria cri);
	public List<OrderListDTO> getOrdersWithPaging(Criteria cri);
	public List<OrderItemsListDTO> getOrderItemsWithPaging(Criteria cri);
	public int getOrdersTotalCount(Criteria cri);
	public int getOrderItemsTotalCount(Criteria cri);
}
