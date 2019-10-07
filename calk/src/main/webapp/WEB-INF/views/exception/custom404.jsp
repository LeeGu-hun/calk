<%@ page language="java" pageEncoding="UTF-8"
  contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" 
	prefix="c" %>
<%@ page session="false" import="java.util.*" %>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Page Fault</title>
</head>
<body>
<h1>Page Not Found</h1>
<h2><c:out value="${exception.getMessage() }"></c:out></h2>
</body>
</html>