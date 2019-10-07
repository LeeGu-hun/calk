<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Start Bootstrap - SB Admin Version 2.0 Demo</title>

<!-- Core CSS - Include with every page -->
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/font-awesome/css/font-awesome.css"
	rel="stylesheet">

<!-- SB Admin CSS - Include with every page -->
<link href="/resources/css/sb-admin.css" rel="stylesheet">
<!-- Core Scripts - Include with every page -->
<script src="/resources/js/jquery-1.10.2.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/plugins/metisMenu/jquery.metisMenu.js"></script>

<!-- SB Admin Scripts - Include with every page -->
<script src="/resources/js/sb-admin.js"></script>

<script>
	$(document).ready(function() {
		$(".btn-success").on("click", function(e) {
			e.preventDefault();
			$("form").submit();
		});
	});
</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="login-panel panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">Logout Page</h3>
					</div>
					<div class="panel-body">
						<form role="form" method='post' action="/customLogout">
							<fieldset>
								<a href="/customLogin" class="btn btn-lg btn-success btn-block">Logout</a>
							</fieldset>
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
	
	$(".btn-success").on("click", function(e){
		
		e.preventDefault();
		$("form").submit();
		
	});
	
	</script>

</body>
</html>
