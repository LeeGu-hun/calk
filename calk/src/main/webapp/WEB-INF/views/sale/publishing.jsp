<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
	.card-body span { margin-right: 20px;}
	.borRadi {border:1px solid #ddd;border-radius: 5px;}
	.cenWid {width: 100px; text-align: center;}
	#selProd { width: 150px;}
	#saleGrid{ 
		width:100%;border-spacing: 5px;
		border-collapse: separate !important;}
	#saleGrid th{background-color: #eee;}
	#saleGrid th:first-child{border-radius: 5px 0 0 5px;}
	#saleGrid th:last-child{border-radius: 0 5px 5px 0;}
	#saleGrid td{text-align: center;}
	.btnRound {text-decoration: none;
		margin: 0px;display: inline-block;	line-height: 27px;
		width: 60px;height: 27px;text-align: center;
		text-decoration: none;background-color: #deebff;
		border-radius: 5px;
		font-size: 12px;font-weight: bold;color: #2E3D4C;}
	.btnRound:hover {color: #fff;background-color: #99CCFF;
		text-decoration: none;}
</style>
<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
	<h1 class="h3 mb-0 text-gray-800">Sales</h1>
	<a href="#"
		class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
		class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
</div>

<form action="/sale/saleReg" method="post" name="frm" id="frm"> 
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<!-- Content Row -->
<div class="card shadow mb-4">
	<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary">판매 처리</h6>
	</div>
	<div class="card-body">
		<div class="row">
			<span>판매일:<input class="borRadi cenWid" type="text" id="saleDate" name="saleDate"></span>
			<span>고객:<select class="borRadi" name="selCust">
				<c:forEach items="${custList }" var="cust">
					<option value="${cust.customer_id }">
						${cust.cust_first_name} ${cust.cust_last_name }</option>
				</c:forEach>
			</select></span>
			<span>구분:<select class="borRadi" name="selCate" id="selCate">
				<c:forEach items="${cateList }" var="cate">
					<option value="${cate.category }">${cate.category }</option>
				</c:forEach>
			</select></span>
			<span>상품:<select class="borRadi" name="selProd" id="selProd">
			</select></span>
		</div>
		<div class="row" style="margin-top: 20px;">
			<span>단가:<input class="borRadi cenWid" type="text" name="price" id="price" readonly></span>
			<span>수량:<input class="borRadi cenWid" type="text" name="quantity" id="quantity"></span>
			<!-- <span>수량:<input class="borRadi cenWid" type="number" name="quantity" id="quantity" min="0" max="1000"></span> -->
			<span>합계:<input class="borRadi cenWid" type="text" name="hap" id="hap" value="0" readonly></span>
			<span>총합 <input class="borRadi cenWid" type="text" name="total" id="total" value="0" readonly></span>
			<span><a href="#" class="btnRound" onclick="addRow();">추가</a></span>
			<span><a href="#" class="btnRound" onclick="saleConfirm();">결제</a></span>
		</div>
	</div>
</div>
<div class="card shadow mb-4">
	<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary">DataTables</h6>
	</div>
	<div class="card-body">
	<input type="hidden" id="seq" value="0">
		<table id="saleGrid">
			<thead id='saleHeader'>
				<tr align="center">
					<th>순번</th>
					<th>구분</th>
					<th>품명</th>
					<th>단가</th>
					<th>수량</th>
					<th>합계</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody id="saleBody">
			</tbody>
		</table>
	</div>
</div>
</form>

<!-- Modal  추가 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<!-- <h4 class="modal-title" id="myModalLabel">Modal title</h4> -->
			</div>
			<div class="modal-body">처리가 완료되었습니다.</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<!-- <button type="button" class="btn btn-primary">Save changes</button> -->
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<script>
	function getDate() {
		var newDate = new Date();
		var yyyy = newDate.getFullYear();
		var mm = newDate.getMonth() + 1;
		if (mm < 10) mm = "0" + mm;
		var dd = newDate.getDate();
		if (dd < 10) dd = "0" + dd;
		var toDay = yyyy + "-" + mm + "-" + dd;
		document.getElementById("saleDate").value = toDay;
	}
	function prodWithCate(){
		var category = $("#selCate option:selected").val();
		priceArr = new Array();
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		$.ajax({
			url : '/sale/getProdListWithCate',
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
			data : "category=" + category,
			type : 'POST',
			dataType : 'html',
			success : function(result) {
				$("#selProd").html(result);
			}, 
			complete : getPrice
		}); //$.ajax
	}
	function listPrice(){
		for(var i=0;i<priceArr.length;i++){
			console.log(priceArr[i][0]+":::"+priceArr[i][1]);
		}
	}
	function getPrice() {
		var idx = $("#selProd option").
						index($("#selProd option:selected"));
		$("#price").val(priceArr[idx][1]);
		calcPriceQuantity();
		$("#quantity").focus();
	}
	function onlyNum(event) {
		var keycode = window.event.keyCode;
		if (keycode == 8 //backspace
				|| (keycode >= 35 && keycode <= 40)
				|| (keycode >= 46 && keycode <= 57)
				|| (keycode >= 96 && keycode <= 105) 
				|| keycode == 110 || keycode == 190) {
			window.event.returnValue = true;
			calcPriceQuantity();
		} else {window.event.returnValue = false; }
		removeHan(event);
	}
	function removeHan(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if (keyID==8||keyID==46||keyID==37||keyID==39) 
			return;
		else
			event.target.value = 
				event.target.value.replace(/[^0-9]/g, "");
	}
	function calcPriceQuantity() {
		var price = $("#price").val();
		var quantity = $("#quantity").val();
		var hap = $("#hap").val();
		if (quantity == null || quantity == "") {
			$("#hap").val("0");
			return;
		}
		$("#hap").val(price * quantity);
	}

	function calcTotal() {
		var total = parseInt($("#total").val());
		var hap =  parseInt($("#hap").val());
		$("#total").val(total+hap);
	}
	function removeRow(row, hap) {
		var table = document.getElementById("saleBody");
		var total = document.getElementById("total");
		var seq = document.getElementById("seq");
		total.value = parseInt(total.value) - parseInt(hap);
		try {
			var temp = row.rowIndex -1;
			table.deleteRow(temp);
			if(temp == 0) seq.value= 0;
		} catch (ex) { alert(ex); }
	}
	function addRow() {
		var selProd = document.getElementById("selProd");
		var selProdVal = document.getElementById("selProd").options[selProd.selectedIndex].value;
		var quantity = document.getElementById("quantity");
		var seq = document.getElementById('seq');
		if (selProdVal == null || selProdVal == "") {
			alert('품명을 선택하세요!');
			document.getElementById("selCate").focus();
			return;
		}
		if (quantity.value == 0 || quantity.value == "") {
			alert('수량을 입력하세요!');
			quantity.focus();
			return;
		}
		var selProdTxt = selProd.options[selProd.selectedIndex].text;
		var selProdVal = selProd.options[selProd.selectedIndex].value;
		seq.value = parseInt(seq.value) + 1;
		calcTotal();
		saleBody = document.getElementById('saleBody');
		row = saleBody.insertRow(saleBody.rows.length);
		cell1 = row.insertCell(0);
		cell2 = row.insertCell(1);
		cell3 = row.insertCell(2);
		cell4 = row.insertCell(3);
		cell5 = row.insertCell(4);
		cell6 = row.insertCell(5);
		cell7 = row.insertCell(6);
		cell1.innerHTML = seq.value;
		cell2.innerHTML = document.getElementById("selCate").value;
		cell3.innerHTML = '<input type="hidden" name="prodIds" value="'
				+ selProdVal + '" />' + selProdTxt;
		cell4.innerHTML = '<input type="text" class="borRadi cenWid" name="prices" value="'
				+ document.getElementById("price").value + '" />';
		cell5.innerHTML = '<input type="text" class="borRadi cenWid" name="quantities" value="'
				+ document.getElementById("quantity").value + '" />';
		cell6.innerHTML = '<input type="text" class="borRadi cenWid" name="haps" value="'
				+ document.getElementById("hap").value + '" />';
		cell7.innerHTML = '<a href="#" class="btnRound" '
				+ 'onclick="removeRow(this.parentNode.parentNode,'
				+ document.getElementById("hap").value + ')" >삭제</a>';
		quantity.focus();
	}
	function saleConfirm(){
		if($("#total").val()==0) {
			alert("결제할 내역이 존재하지 않습니다.");
			$("#quantity").focus();
			return;
		}
		$("#frm").submit();
	}
	
	function checkModal(result) {
		//null일경우 false !면 true
		//false false일 경우만 if문 skip
		if (result === '' || history.state) return;
		if (parseInt(result) > 0) {
			$(".modal-body").html("등록되었습니다.");
		}
		$("#myModal").modal("show");
	}
	
	$(document).ready(function() {
		var result = '<c:out value="${result}"/>';
		checkModal(result);

		history.replaceState({}, null, null);
		
		priceArr = new Array();
		$("#selCate").on(
				"change",
				function(e) {
					var selCate = $("#selCate option:selected").val();
					prodWithCate(selCate);
		}); //selCate
		$("#selProd").on(
				"change",
				function(e) {
					getPrice();
		}); //selProd
		$("#quantity").on(
				"keydown keyup keypress",
				function(e) {
					onlyNum(e);
		}); //quantity
		$("#saleDate").datepicker({
			dateFormat : 'yy-mm-dd',
			prevText : '이전 달',
			nextText : '다음 달',
			monthNames : ['1월','2월','3월','4월','5월','6월',
				'7월','8월','9월','10월','11월','12월'],
			monthNamesShort : ['1월','2월','3월','4월','5월','6월',
				'7월','8월','9월','10월','11월','12월'],
			dayNames : ['일','월','화','수','목','금','토' ],
			dayNamesShort : ['일','월','화','수','목','금','토' ],
			dayNamesMin : ['일','월','화','수','목','금','토' ],
			showMonthAfterYear : true,
			yearSuffix : '년'
		});
		getDate();
		prodWithCate();
	})
</script>
<%@ include file="/WEB-INF/views/includes/footer.jsp"%>