package org.calk.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.calk.domain.Criteria;
import org.calk.domain.PageDTO;
import org.calk.domain.SaleVO;
import org.calk.service.SaleService;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/sale/")
@AllArgsConstructor
public class SaleController {

	private SaleService saleSvc;

	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
	}

	@GetMapping("/publishing")
	public void publishing(Model model) {
		log.info("publishing:");
		model.addAttribute("custList", saleSvc.getCustList());
		model.addAttribute("cateList", saleSvc.getCateList());
	}

	@PostMapping("/getProdListWithCate")
	public void getProdListWithCate(Model model, 
			@RequestParam("category") String category) {
		log.info("getProdListWithCate");
		if(category.equals(""))
			model.addAttribute("prodList", 
				saleSvc.getProdList());
		else 
			model.addAttribute("prodList", 
					saleSvc.getProdList(category));
	}
	@PostMapping("/getProdListWithCateByReport")
	public void getProdListWithCateByReport(Model model, 
			@RequestParam("category") String category,
			@RequestParam("selProd") String selProd) {
		log.info("getProdListWithCateByReport");
		if(category.equals("all"))
			model.addAttribute("prodList", 
				saleSvc.getProdList());
		else 
			model.addAttribute("prodList", 
					saleSvc.getProdList(category));
		log.info("selProd>>>"+selProd);
		model.addAttribute("selProd", selProd);
	}	
	@PostMapping("/saleReg")
	public String saleReg(SaleVO vo, RedirectAttributes rttr) {
		log.info("saleReg");
		saleSvc.saleReg(vo);
		rttr.addFlashAttribute("result", 1);
		log.info("rttr"+rttr.getFlashAttributes());
		return "redirect:/sale/publishing";
	}
	
	@GetMapping("/report")
	public void reportGet(Model model) {
		log.info("report:");
		model.addAttribute("custList", saleSvc.getCustList());
		model.addAttribute("cateList", saleSvc.getCateList());
	}

	@PostMapping("/report")
	public void reportPost(Model model, Criteria cri) {
		log.info("amount>>>>>"+cri.getAmount());
		model.addAttribute("orderList", saleSvc.getOrderList(cri));
		model.addAttribute("custList", saleSvc.getCustList());
		model.addAttribute("cateList", saleSvc.getCateList());
		int total = saleSvc.getTotal(cri);
		log.info("amount>>>"+cri.getAmount());
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@GetMapping("/member")
	public void memberGet(Model model) {
		log.info("report:");
		model.addAttribute("custList", saleSvc.getCustList());
		model.addAttribute("cateList", saleSvc.getCateList());
	}

	@PostMapping("/member")
	public void memberPost(Model model, Criteria cri) {
		log.info("amount>>>>>"+cri.getAmount());
		model.addAttribute("orderList", saleSvc.getOrderList(cri));
		model.addAttribute("custList", saleSvc.getCustList());
		model.addAttribute("cateList", saleSvc.getCateList());
		int total = saleSvc.getTotal(cri);
		log.info("amount>>>"+cri.getAmount());
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

}
