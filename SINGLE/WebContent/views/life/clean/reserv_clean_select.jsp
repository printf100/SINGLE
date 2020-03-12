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
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/life/clean/date.js"></script>
<script type="text/javascript">
	$(function() {
		
	//페이지가 로딩될때 오늘날짜기준 4일 뒤까지 값들 셋팅	
	$("#first_pre").text("내일,"+printFirst);
	$("#second_pre").text("모레,"+printSecond);
	$("#third_pre").text(printThird);
	$("#fourth_pre").text(printFourth);
	 
	$("#img1").hover(function(){
			$("#textarea1").val("10년 경력의 숙련된 업체입니다. \r청소로부터 더 이상 스트레스 받지 마세요! \r상담 010-3131-4332");
			$("#textarea1").css("background","#E6E6E6");
		}, function(){
			$("#textarea1").val("청소박사 강혜정");
			$("#textarea1").css("background","");
		});
	
	$("#img2").hover(function(){
			$("#textarea2").val("복잡한 청소, 한번에 가자. \r전문청소부터 간이청소까지! \r상담 010-1111-2222");
			$("#textarea2").css("background","#E6E6E6");
		}, function(){
			$("#textarea2").val("MISO");
			$("#textarea2").css("background","");
		});
	
	$("#img3").hover(function(){
			$("#textarea3").val("28년간 쌓아온 깨끗한 믿음. \r전문가의 손길로 깔끔하게 청소해드립니다! \r상담 010-0227-0131");
			$("#textarea3").css("background","#E6E6E6");
		}, function(){ 
			$("#textarea3").val("청소일번지");
			$("#textarea3").css("background","");
		});
	

	$("#img1").on('click',function(){
		var result = confirm('청소박사 강혜정을 선택하시겠습니까?'); 
		
			if(result) {
				$("#CLEAN_MANAGER").val("1");
				window.open("/SINGLE/life/clean/pay.do", "PopupWin", "width=426,height=550");
			}
		});
	
	$("#img2").on('click',function(){
		var result = confirm('MISO를 선택하시겠습니까?'); 
			
			if(result) {
				$("#CLEAN_MANAGER").val("2");
				window.open("/SINGLE/life/clean/pay.do", "PopupWin", "width=426,height=550");
			}
		});
	
	$("#img3").on('click',function(){
		var result = confirm('청소일번지를 선택하시겠습니까?'); 
		
			if(result) {
				$("#CLEAN_MANAGER").val("3");
				window.open("/SINGLE/life/clean/pay.do", "PopupWin", "width=426,height=550");
			}
		
		});
	
	});
	//시간 선택을 완료하면 시간 선택은 숨기고 해당 창에서 매니저 선택창을 보여준다.
	function setWashTime(arg){
		$("#CLEAN_TIME").val(setTime(arg));
		$("#time_div").hide();
		$("#manager").show();
	}
	//form 전송
	function formSubmit(){ 
		$("#reserv_form").submit();
	}
</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>
	<div class="container">
		<!-- TEXT AREA / BUTTON AREA-->
			<form id="reserv_form" method="post" action="/SINGLE/life/clean/complete.do">
				<input type="hidden" id="MEMBER_CODE"         name="MEMBER_CODE"         value="${clean_info.MEMBER_CODE }">
				<input type="hidden" id="CLEAN_POSTCODE"       name="CLEAN_POSTCODE"       value="${clean_info.CLEAN_POSTCODE }">
				<input type="hidden" id="CLEAN_ADDRESS"   	  name="CLEAN_ADDRESS"        value="${clean_info.CLEAN_ADDRESS }">
				<input type="hidden" id="CLEAN_DETAIL_ADDRESS" name="CLEAN_DETAIL_ADDRESS" value="${clean_info.CLEAN_DETAIL_ADDRESS }">
				<input type="hidden" id="CLEAN_TIME"           name="CLEAN_TIME"           value="${clean_info.CLEAN_TIME }">
				<input type="hidden" id="CLEAN_MANAGER"        name="CLEAN_MANAGER"        value="">
				<input type="hidden" id="payComplete"         name="payComplete"         value="">
			</form>
		
		<div class="time_div" id="time_div">
		<div class="btn-group-vertical">	
			<div class="first" >
				<pre id="first_pre"></pre>
					<input type="button" class="btn btn-outline-dark btn-block" value="오후 4시 ~ 6시"  readonly="readonly" onclick="setWashTime(1)" ><br>
					<input type="button" class="btn btn-outline-dark btn-block" value="오후 6시 ~ 8시"  readonly="readonly" onclick="setWashTime(2)" ><br>
					<input type="button" class="btn btn-outline-dark btn-block" value="오후 8시 ~ 10시" readonly="readonly" onclick="setWashTime(3)" ><br>
					<input type="button" class="btn btn-outline-dark btn-block" value="오후 10시 ~ 자정" readonly="readonly" onclick="setWashTime(4)" ><br>
			</div>
			<div class="second" style="margin-top: 25px;">
				<pre id="second_pre"></pre>
					<input type="button" class="btn btn-outline-dark btn-block" value="오후 4시 ~ 6시"  readonly="readonly" onclick="setWashTime(5)" ><br>
					<input type="button" class="btn btn-outline-dark btn-block" value="오후 6시 ~ 8시"  readonly="readonly" onclick="setWashTime(6)" ><br>
					<input type="button" class="btn btn-outline-dark btn-block" value="오후 8시 ~ 10시" readonly="readonly" onclick="setWashTime(7)" ><br>
					<input type="button" class="btn btn-outline-dark btn-block" value="오후 10시 ~ 자정" readonly="readonly" onclick="setWashTime(8)" ><br>
			</div>
			<div class="third" style="margin-top: 25px;">
				<pre id="third_pre"></pre>
					<input type="button" class="btn btn-outline-dark btn-block" value="오후 4시 ~ 6시"  readonly="readonly" onclick="setWashTime(9)" ><br>
					<input type="button" class="btn btn-outline-dark btn-block" value="오후 6시 ~ 8시"  readonly="readonly" onclick="setWashTime(10)" ><br>
					<input type="button" class="btn btn-outline-dark btn-block" value="오후 8시 ~ 10시" readonly="readonly" onclick="setWashTime(11)" ><br>
					<input type="button" class="btn btn-outline-dark btn-block" value="오후 10시 ~ 자정" readonly="readonly" onclick="setWashTime(12)" ><br>
			</div>
			<!--
			<div class="fourth" style="margin-top: 25px;"> 
				<pre id="fourth_pre"></pre>
					<input type="button" class="btn btn-outline-dark btn-block" value="오후 4시 ~ 6시"  readonly="readonly" onclick="setWashTime(13)" ><br>
					<input type="button" class="btn btn-outline-dark btn-block" value="오후 6시 ~ 8시"  readonly="readonly" onclick="setWashTime(14)" ><br>
					<input type="button" class="btn btn-outline-dark btn-block" value="오후 8시 ~ 10시" readonly="readonly" onclick="setWashTime(15)" ><br>
					<input type="button" class="btn btn-outline-dark btn-block" value="오후 10시 ~ 자정" readonly="readonly" onclick="setWashTime(16)" ><br>
			</div>
			  -->
			</div>
		</div>
		 
		 <div class="text-info text-center form-group">
		 <div class="manager" id="manager" style="display: none" >
		 	<img id="img1" alt="웃음 아이콘" src="${pageContext.request.contextPath}/resources/images/clean/smile.png" style="width:120px;height:120px">
		 	<BR>
		 	<BR>
		 	<textarea class="form-control" id="textarea1" rows="4" cols="40">청소박사 강혜정</textarea>	
		 	<BR>
		 	<BR>
		 	<img id="img2" alt="청소 아이콘 첫번째" src="${pageContext.request.contextPath}/resources/images/clean/washer.png" style="width:120px;height:120px">
		 	<BR>
		 	<BR>
		 	<textarea class="form-control" id="textarea2" rows="4" cols="40">MISO</textarea>	
		 	<BR>
		 	<BR>
		 	<img id="img3" alt="청소 아이콘 두번째" src="${pageContext.request.contextPath}/resources/images/clean/washer2.png" style="width:120px;height:120px">
		 	<BR>
		 	<BR>
		 	<textarea class="form-control" id="textarea3" rows="4" cols="40">청소일번지</textarea>	
		 
		 
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