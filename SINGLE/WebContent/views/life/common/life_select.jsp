<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- START :: include header -->
<%@include file="/views/form/header.jsp" %>
<!-- END :: include header -->
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>LIFE</title>

<!-- START :: CSS -->
<style type="text/css">
	.select {
		position: relative;
		padding-top: 200px;
		padding-left: 200px;
 		height: 75vh;  
	}
</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">


	$(function() {
		//청소예약 
		$("#reserv-clean").click(function(){
			location.href="/SINGLE/life/clean/cleanpage.do";
		})
		//세탁수거예약 
		$("#reserv-wash").click(function(){
			location.href="/SINGLE/life/wash/washpage.do";
		})
	});
	
	
</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>
	
	<div class="container">
		<!-- TEXT AREA / BUTTON AREA-->
		<div class="select">
			
				<br>
				<div class="left-button">
					<button class="btn btn-info" id="reserv-clean">청소예약</button>
					<button class="btn btn-info" id="reserv-wash">세탁수거예약</button>
				</div>
	
		</div>
		 
		
	</div>
	


<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>