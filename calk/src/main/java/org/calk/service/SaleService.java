package org.calk.service;

import java.util.List;

import org.calk.domain.CateVO;
import org.calk.domain.Criteria;
import org.calk.domain.CustVO;
import org.calk.domain.OrderListDTO;
import org.calk.domain.ProdVO;
import org.calk.domain.SaleVO;

public interface SaleService {
	public List<CustVO> getCustList();
	public List<CateVO> getCateList();
	public List<ProdVO> getProdList();
	public List<ProdVO> getProdList(String category);
	public void saleReg(SaleVO vo);
	public List getOrderList(Criteria cri);
	public int getTotal(Criteria cri); 
}
