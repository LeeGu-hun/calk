<%@ page language="java" pageEncoding="UTF-8"
  contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" 
	prefix="c" %>
<%@ page session="false" import="java.util.*" %>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예외 발생</title>
</head>
<body>
<h1><c:out value="${exception.getMessage() }"></c:out></h1>
<ul>
	<c:forEach items="${exception.getStackTrace() }" var="stack">
		<li><c:out value="${stack }"></c:out></li>
	</c:forEach>
</ul>
</body>
</html>