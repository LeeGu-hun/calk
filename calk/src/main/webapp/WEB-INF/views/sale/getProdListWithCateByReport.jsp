<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${selProd eq null}">
	<c:forEach items="${prodList }" var="prod">
		<option value="${prod.product_id}">${prod.product_name}</option>
		<script>priceArr.push([${prod.product_id},${prod.list_price}]);</script>
	</c:forEach>
</c:if>

<c:if test="${selProd ne null}">
	<c:if test="${selProd ne 'all'}">
		<c:forEach items="${prodList }" var="prod">
			<option value="${prod.product_id}"
				${selProd eq prod.product_id?' selected':''}>${prod.product_name}</option>
			<script>priceArr.push([${prod.product_id},${prod.list_price}]);</script>
		</c:forEach>
	</c:if>
	<c:if test="${selProd eq 'all'}">
		<c:forEach items="${prodList }" var="prod">
			<option value="${prod.product_id}">${prod.product_name}</option>
			<script>priceArr.push([${prod.product_id},${prod.list_price}]);</script>
		</c:forEach>
	</c:if>
</c:if>