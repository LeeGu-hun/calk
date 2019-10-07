<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:forEach items="${prodList }" var="prod">
<option value="${prod.product_id}">${prod.product_name}</option>
<script>priceArr.push([${prod.product_id},${prod.list_price}]);</script>
</c:forEach>
