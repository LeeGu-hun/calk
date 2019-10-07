package org.calk.service;

import java.util.ArrayList;
import java.util.List;

import org.calk.domain.CateVO;
import org.calk.domain.Criteria;
import org.calk.domain.CustVO;
import org.calk.domain.OrderItemsVO;
import org.calk.domain.OrderListDTO;
import org.calk.domain.ProdVO;
import org.calk.domain.SaleVO;
import org.calk.mapper.CustomersMapper;
import org.calk.mapper.ProductsMapper;
import org.calk.mapper.SaleMapper;
import org.calk.security.domain.CustomUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class SaleServiceImpl implements SaleService {
	@Setter(onMethod_ = @Autowired)
	private CustomersMapper custMapper;

	@Setter(onMethod_ = @Autowired)
	private ProductsMapper prodMapper;

	@Setter(onMethod_ = @Autowired)
	private SaleMapper saleMapper;

	@Override
	public List<CustVO> getCustList() {
		log.info("getCustList");
		return custMapper.getCustAll();
	}

	@Override
	public List<CateVO> getCateList() {
		log.info("getCateList");
		return prodMapper.getCateAll();
	}

	@Override
	public List<ProdVO> getProdList() {
		log.info("getProdList");
		return prodMapper.getProdAll();
	}

	@Override
	public List<ProdVO> getProdList(String category) {
		log.info("getProdList");
		return prodMapper.getProdList(category);
	}

	@Transactional
	@Override
	public void saleReg(SaleVO vo) {
		log.info("saleServiceImpl saleReg");
		CustomUser u = (CustomUser)(
				(User) SecurityContextHolder.getContext()
				.getAuthentication().getPrincipal());
		vo.setUserId(u.getUser().getUser_id());

		List<OrderItemsVO> list = 
				new ArrayList<OrderItemsVO>();
		for(int i=0;i<vo.getPrices().length;i++) {
			list.add(
				new OrderItemsVO(
					vo.getProdIds()[i],
					vo.getPrices()[i],
					vo.getQuantities()[i]
				)
			);
		}
		vo.setOrderItems(list);
		
		saleMapper.regOrders(vo);
		saleMapper.regOrderItems(vo);
	}

	@Override
	public List getOrderList(Criteria cri) {
		List list; 
		if(cri.getSelCate().equals("all") 
				&& cri.getSelProd().equals("all")) {
			list = saleMapper.getOrdersWithPaging(cri);
		} else {
			list = saleMapper.getOrderItemsWithPaging(cri);
		}
		return list;
	}

	@Override
	public int getTotal(Criteria cri) {
		int result;
		if(cri.getSelCate().equals("all") 
				&& cri.getSelProd().equals("all")) {
			result = saleMapper.getOrdersTotalCount(cri);
		} else {
			result = saleMapper.getOrderItemsTotalCount(cri);
		}
		return result;
	}
	
}
