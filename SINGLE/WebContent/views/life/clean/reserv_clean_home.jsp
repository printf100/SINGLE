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
<title>청소 도우미</title>

<!-- START :: CSS -->
<style type="text/css">

	@import url('https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap');
	
	body {
		font-family: 'Noto Sans KR';
	}

	.navbar a {
		color: #000;
		font-weight: 700;
	}
	
	.navbar {
		position: relative;
		display: flex;
		padding: 0.375rem 1rem;
		height: 80px;
		border-bottom: 1px solid lightgray;
	}
	
	.navbar-collapse {
		flex-grow: 1;
		align-items: center;
	}
	
	.nav-link {
		padding: 0.25rem 1rem;
	}
	
	.member-info {
		display: flex;
		margin-bottom: 0.25rem;
		padding: 0.6875rem 1rem 1rem 1rem;
		border-bottom: 0.0625rem solid #E9ECF3;
		color: #263747;
	}
	
	.rounded {
		width: 100%;
		height: 100%;
		object-fit: cover;
	}
	
	.profile-img {
		width: 2.5rem;
		height: 2.5rem;
		border-radius: 0.25rem;
	}
		
	.info-text {
		margin-left: 1rem;
		-webkit-font-smoothing: antialiased;
	}
	
	.title-text {
		font-weight: 700;
	}
	
	.dropdown-item {
		display: flex;
		align-items: center;
		justify-content: space-between;
		padding: 0.125rem 0.875rem;
		color: #263747;
		font-weight: 500;
	}
	
</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">


	$(function() {
		//예약하기 
		$("#reserv-btn").click(function(){
			location.href="/SINGLE/life/clean/address.do";
		})
		//예약목록으로 가기
		$("#reserv-list").click(function(){
			location.href="/SINGLE/life/clean/edit.do";
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
					<h1>봄맞이 리프레시</h1> 
					<h1>청소가 필요할 때</h1>
				</div>
				<br>
				<div class="left-button">
					<button class="btn btn-info" id="reserv-btn">청소예약</button>
					<button class="btn btn-outline-info" id="reserv-list">예약목록</button>
				</div>
	
		</div>
		<BR>
		<div class="right">
			<img id="img" class="rounded" alt="청소 이미지" src="${pageContext.request.contextPath}/resources/images/clean/wash.jpg" >
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