<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
.card-body span {
	margin-right: 10px;
}

.borRadi {
	border: 1px solid #ddd;
	border-radius: 5px;
}

.cenWid {
	width: 100px;
	text-align: center;
}

#selProd {
	width: 120px;
}

.btnRound {
	text-decoration: none;
	margin: 0px;
	display: inline-block;
	line-height: 27px;
	width: 45px;
	height: 27px;
	text-align: center;
	text-decoration: none;
	background-color: #deebff;
	border-radius: 5px;
	font-size: 12px;
	font-weight: bold;
	color: #2E3D4C;
}

.btnRound:hover {
	color: #fff;
	background-color: #99CCFF;
	text-decoration: none;
}
</style>
<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
	<h1 class="h3 mb-0 text-gray-800">Report</h1>
	<a href="#"
		class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
		class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
</div>

<form action="/sale/report" method="post" name="frm" id="frm">
	<input type="hidden" name="${_csrf.parameterName}"
		value="${_csrf.token}" />
	<input type="hidden" id="pageNum" name="pageNum" value="${pageMaker.cri.pageNum}" />
	<input type="hidden" id="amount" name="amount" value="${pageMaker.cri.amount eq null?10:pageMaker.cri.amount}" />
		
	<!-- Content Row -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">판매 조회</h6>
		</div>
		<div class="card-body">
			<div class="row" style="margin: 0 auto;">
				<span>기간:<input class="borRadi cenWid" type="text"
					id="saleDateFrom" name="saleDateFrom" /> <b>~</b> <input
					class="borRadi cenWid" type="text" id="saleDateTo"
					name="saleDateTo" /></span> <span>고객:<select class="borRadi"
					name="selCust">
						<c:if test="${criteria.selCust eq null}">
							<option value="all" selected>전체</option>
							<c:forEach items="${custList }" var="cust">
								<option value="${cust.customer_id }">${cust.cust_first_name}
									${cust.cust_last_name }</option>
							</c:forEach>
						</c:if>
						<c:if test="${criteria.selCust ne null}">
							<option value="all"
								${criteria.selCust eq 'all'?'selected':''}>전체</option>
							<c:forEach items="${custList }" var="cust">
								<c:if test="${criteria.selCust ne 'all'}">
									<option value="${cust.customer_id }"
										${criteria.selCust eq cust.customer_id?'selected':''}>${cust.cust_first_name}
										${cust.cust_last_name }</option>
								</c:if>
								<c:if test="${criteria.selCust eq 'all'}">
									<option value="${cust.customer_id }">${cust.cust_first_name}
										${cust.cust_last_name }</option>
								</c:if>
							</c:forEach>
						</c:if>
				</select></span> <span>구분:<select class="borRadi" name="selCate" id="selCate">
						<c:if test="${criteria.selCate eq null}">
							<option value="all" selected>전체</option>
							<c:forEach items="${cateList }" var="cate">
								<option value="${cate.category }">${cate.category }</option>
							</c:forEach>
						</c:if>
						<c:if test="${criteria.selCate ne null}">
							<option value="all"
								${criteria.selCate eq 'all'?'selected':''}>전체</option>
							<c:forEach items="${cateList }" var="cate">
								<c:if test="${criteria.selCate ne 'all'}">
									<option value="${cate.category }"
										${criteria.selCate eq cate.category?'selected':''}>${cate.category }</option>
								</c:if>
								<c:if test="${criteria.selCate eq 'all'}">
									<option value="${cate.category }">${cate.category }</option>
								</c:if>
							</c:forEach>
						</c:if>
				</select></span> <span>상품:<select class="borRadi" name="selProd" id="selProd">
				</select></span> <span><select name="dataTable_length"
					aria-controls="dataTable" style="width:55px;" id="selAmount" name="selAmount" 
					class="custom-select custom-select-sm form-control form-control-sm">
					<option value="10" ${pageMaker.cri.amount == 10?'selected':''}>10</option>
					<option value="25" ${pageMaker.cri.amount == 25?'selected':''}>25</option>
					<option value="50" ${pageMaker.cri.amount == 50?'selected':''}>50</option>
					<option value="100" ${pageMaker.cri.amount == 100?'selected':''}>100</option></select></span>
					<span><a href="#" class="btnRound" onclick="searchSale();">검색</a></span>
			</div>
		</div>
	</div>
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">DataTables</h6>
		</div>
		<div class="card-body">
			<div class="table-responsive">
				<div id="dataTable_wrapper" style="overflow-y: auto;overflow-x: hidden;">
					<div class="row">
						<div class="col-sm-12">
							<input type="hidden" id="seq" value="0">
							<table class="table table-bordered dataTable" id="dataTable"
								width="100%" cellspacing="0" role="grid"
								aria-describedby="dataTable_info" style="width: 100%;">
								<thead id='saleHeader'>
									<c:if test="${not empty criteria.selCate}">
										<c:if
											test="${criteria.selCate eq 'all' 
												&& criteria.selProd eq 'all'}">
											<tr role="row" align="center">
												<th>주문번호</th>
												<th>고객명</th>
												<th>합계</th>
												<th>판매일</th>
												<th>판매자</th>
											</tr>
										</c:if>
										<c:if
											test="${criteria.selCate ne 'all' 
												|| criteria.selProd ne 'all'}">
											<tr role="row" align="center">
												<th>주문번호</th>
												<th>고객명</th>
												<th>구분</th>
												<th>상품명</th>
												<th>합계</th>
												<th>판매일</th>
												<th>판매자</th>
											</tr>
										</c:if>
									</c:if>
								</thead>
								<tbody id="saleBody">
									<c:if test="${not empty criteria.selCate }">
										<c:forEach items="${orderList }" var="order">
											<tr role="row" align="center">
												<c:if
													test="${criteria.selCate eq 'all' && 
													criteria.selProd eq 'all'}">
													<td>${order.order_id }</td>
													<td>${order.customerName }</td>
													<td style="text-align: right;padding-right: 5px;">${order.order_total }</td>
													<td><fmt:formatDate value="${order.order_timestamp }"
															pattern="yyyy.MM.dd hh:mm:ss" /></td>
													<td>${order.userName }</td>
												</c:if>
												<c:if
													test="${criteria.selCate ne 'all' || 
													criteria.selProd ne 'all'}">
													<td>${order.order_id }</td>
													<td>${order.customerName }</td>
													<td>${order.category }</td>
													<td>${order.product_name }</td>
													<td style="text-align: right;padding-right: 5px;">${order.order_total }</td>
													<td><fmt:formatDate value="${order.order_timestamp }"
															pattern="yyyy.MM.dd hh:mm:ss" /></td>
													<td>${order.userName }</td>
												</c:if>
											</tr>
										</c:forEach>
									</c:if>
								</tbody>
							</table>
						</div>
					</div>
					<c:if test="${not empty criteria.selCate }">
						<div class="row">
							<div class="col-sm-12 col-md-5">
								<div class="dataTables_info" id="dataTable_info" role="status"
									aria-live="polite">Showing 41 to 50 of 57 entries</div>
							</div>
							<div class="col-sm-12 col-md-7">
								<div class="dataTables_paginate paging_simple_numbers"
									id="dataTable_paginate">
									<ul class="pagination justify-content-end">
										<c:if test="${pageMaker.prev}">
											<li class="paginate_button page-item previous disabled"
												id="dataTable_previous"><a
												href="${pageMaker.startPage -1}" aria-controls="dataTable"
												data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
										</c:if>

										<c:forEach var="num" begin="${pageMaker.startPage}"
											end="${pageMaker.endPage}">
											<li class='paginate_button page-item ${pageMaker.cri.pageNum == num ? "active":""}'>
												<a href="${num}" aria-controls="dataTable" data-dt-idx="1"
												tabindex="0" class="page-link">${num}</a>
											</li>
										</c:forEach>

										<c:if test="${pageMaker.next}">
											<li class="paginate_button page-item next"
												id="dataTable_next"><a href="${pageMaker.endPage +1 }"
												aria-controls="dataTable" data-dt-idx="7" tabindex="0"
												class="page-link">Next</a></li>
										</c:if>
									</ul>
								</div>
							</div>
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</form>

<script>
	function isEmpty(str) {
		if (typeof str == "undefined" || str == null || str == "")
			return true;
		else
			return false;
	}
	function nvl(str, defaultStr) {
		if (typeof str == "undefined" || str == null || str == "")
			str = defaultStr;
		return str;
	}
	function getDate() {
		var newDate = new Date();
		var yyyy = newDate.getFullYear();
		var mm = newDate.getMonth() + 1;
		if (mm < 10)
			mm = "0" + mm;
		var dd = newDate.getDate();
		if (dd < 10)
			dd = "0" + dd;
		var toDay = yyyy + "-" + mm + "-" + dd;
		<c:if test="${criteria.saleDateFrom eq null}">
		document.getElementById("saleDateFrom").value = toDay;
		document.getElementById("saleDateTo").value = toDay;
		</c:if>
		<c:if test="${criteria.saleDateFrom ne null}">
		document.getElementById("saleDateFrom").value = '<fmt:formatDate value="${criteria.saleDateFrom}" pattern="yyyy-MM-dd"/>';
		document.getElementById("saleDateTo").value = '<fmt:formatDate value="${criteria.saleDateTo}" pattern="yyyy-MM-dd"/>';
		</c:if>
	}
	function prodWithCate() {
		var category = $("#selCate option:selected").val();
		priceArr = new Array();
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		$
				.ajax({
					url : '/sale/getProdListWithCateByReport',
					beforeSend : function(xhr) {
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					data : "category="
							+ category
							+ "&selProd=<c:out value='${criteria.selProd}'/>",
					type : 'POST',
					dataType : 'html',
					success : function(result) {
						if ("<c:out value='${criteria.selProd}'/>" == "undefined"
								|| "<c:out value='${criteria.selProd}'/>" == "all")
							var tmp = "<option value='all' selected>전체</option>";
						else
							var tmp = "<option value='all'>전체</option>";
						$("#selProd").html(tmp + result);
					}
				}); //$.ajax
	}
	function searchSale() {
		$("#pageNum").val(1);
		$("#amount").val($("#selAmount option:selected").val());
		$("#frm").submit();
	}
	$(document).ready(function() {
		history.replaceState({}, null, null);
		$("#selCate").on("change", function(e) {
			var selCate = $("#selCate option:selected").val();
			prodWithCate(selCate);
		}); //selCate
		$(".paginate_button a").on("click", function(e){
			e.preventDefault();
			//console.log('click');
			$("#pageNum").val($(this).attr("href"));
			$("#frm").submit();
		});
		$("#saleDateFrom").datepicker({
			dateFormat : 'yy-mm-dd',
			prevText : '이전 달',
			nextText : '다음 달',
			monthNames : [ '1월', '2월', '3월', '4월',
					'5월', '6월', '7월', '8월', '9월',
					'10월', '11월', '12월' ],
			monthNamesShort : [ '1월', '2월', '3월', '4월',
					'5월', '6월', '7월', '8월', '9월',
					'10월', '11월', '12월' ],
			dayNames : [ '일', '월', '화', '수', '목', '금',
					'토' ],
			dayNamesShort : [ '일', '월', '화', '수', '목',
					'금', '토' ],
			dayNamesMin : [ '일', '월', '화', '수', '목',
					'금', '토' ],
			showMonthAfterYear : true,
			yearSuffix : '년'
		});
		$("#saleDateTo").datepicker({
			dateFormat : 'yy-mm-dd',
			prevText : '이전 달',
			nextText : '다음 달',
			monthNames : [ '1월', '2월', '3월', '4월',
					'5월', '6월', '7월', '8월', '9월',
					'10월', '11월', '12월' ],
			monthNamesShort : [ '1월', '2월', '3월', '4월',
					'5월', '6월', '7월', '8월', '9월',
					'10월', '11월', '12월' ],
			dayNames : [ '일', '월', '화', '수', '목', '금',
					'토' ],
			dayNamesShort : [ '일', '월', '화', '수', '목',
					'금', '토' ],
			dayNamesMin : [ '일', '월', '화', '수', '목',
					'금', '토' ],
			showMonthAfterYear : true,
			yearSuffix : '년'
		});
		getDate();
		prodWithCate();
	})
</script>
<%@ include file="/WEB-INF/views/includes/footer.jsp"%>
