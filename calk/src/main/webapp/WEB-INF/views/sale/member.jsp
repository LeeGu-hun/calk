<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>
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
		value="${_csrf.token}" /> <input type="hidden" id="pageNum"
		name="pageNum" value="${pageMaker.cri.pageNum}" /> <input
		type="hidden" id="amount" name="amount"
		value="${pageMaker.cri.amount eq null?10:pageMaker.cri.amount}" />

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
							<option value="all" ${criteria.selCust eq 'all'?'selected':''}>전체</option>
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
							<option value="all" ${criteria.selCate eq 'all'?'selected':''}>전체</option>
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
				</select></span> <span><a href="#" class="btnRound" onclick="searchSale();">검색</a></span>
			</div>
		</div>
	</div>
	
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">DataTables</h6>
		</div>
		<div class="card-body">
			<div class="table-responsive">
				<div id="dataTable_wrapper"
					style="overflow-y: auto; overflow-x: hidden;">
					<div class="row">
						<div class="col-sm-12">
							<input type="hidden" id="seq" value="0">
							<table class="table table-bordered dataTable" id="dataTable"
								width="100%" cellspacing="0" role="grid"
								aria-describedby="dataTable_info" style="width: 100%;">
								<thead>
									<tr>
										<th>ID</th>
										<th>이름</th>
										<th>주소</th>
										<th>도시</th>
										<th>전화번호</th>
										<th>우편번호</th>
									</tr>
								</thead>
								<c:forEach items="${custList}" var="cust">
									<tr>
										<td><c:out value="${cust.customer_id}" /></td>
										<td><c:out value="${cust.cust_first_name }" />
											${cust.cust_last_name }</td>
										<td><c:out value="${cust.cust_street_address1}" /></td>
										<td><c:out value="${cust.cust_city}" /></td>
										<td><c:out value="${cust.phone_number1}" /></td>
										<td><c:out value="${cust.cust_postal_code}" /></td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
					<span><select name="dataTable_length"
					aria-controls="dataTable" style="width: 55px;" id="selAmount"
					name="selAmount"
					class="custom-select custom-select-sm form-control form-control-sm">
						<option value="10" ${pageMaker.cri.amount == 10?'selected':''}>10</option>
						<option value="25" ${pageMaker.cri.amount == 25?'selected':''}>25</option>
						<option value="50" ${pageMaker.cri.amount == 50?'selected':''}>50</option>
						<option value="100" ${pageMaker.cri.amount == 100?'selected':''}>100</option>
				</select></span> 
				</div>
			</div>
		</div>
	</div>
</form>

<%@ include file="/WEB-INF/views/includes/footer.jsp"%>
