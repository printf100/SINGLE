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
<title>세탁 도우미</title>

<!-- START :: CSS -->
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">


	$(function() {
		//예약하기 
		$("#reserv-btn").click(function(){
			location.href="/SINGLE/life/wash/address.do";
		})
		//예약목록으로 가기
		$("#reserv-list").click(function(){
			location.href="/SINGLE/life/wash/edit.do";
		})
	});
	
	
</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>
	
	<div class="container">
		<!-- TEXT AREA / BUTTON AREA-->
		<div class="left">
				<div class="left-text">
					<h1>따뜻한 봄바람</h1> 
					<h1>세탁이 필요할 때</h1>
				</div>
				<br>
				<div class="left-button">
					<button class="btn btn-info" id="reserv-btn">픽업예약</button>
					<button class="btn btn-info" id="reserv-list">예약목록</button>
				</div>
	
		</div>
		<div class="right">
			<img id="img" alt="세탁 이미지" src="${pageContext.request.contextPath}/resources/images/wash/wash.jpg" >
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