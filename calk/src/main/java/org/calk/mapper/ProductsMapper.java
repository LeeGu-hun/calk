package org.calk.mapper;

import java.util.List;

import org.calk.domain.CateVO;
import org.calk.domain.ProdVO;

public interface ProductsMapper {
	public List<CateVO> getCateAll();
	public List<ProdVO> getProdAll();
	public List<ProdVO> getProdList(String category);
}
