<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SINGLE</title>
<meta property="og:title" content="SINGLE">
<meta property="og:description" content="혼자 사는 사람들을 위한 공간">
<meta property="og:image" content="https://images.unsplash.com/photo-1541194577687-8c63bf9e7ee3?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80">

<!-- START :: CSS -->
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">

	@import url('https://fonts.googleapis.com/css?family=Do+Hyeon&display=swap');

	.container-fluid {
		margin: 0;
		padding: 0;
		width: 100%;
	}

	.main-img {
		background: url("https://images.unsplash.com/photo-1541194577687-8c63bf9e7ee3?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80");
		background-size: cover;
		background-repeat: no-repeat;
		position: relative;
		height: 100vh;
	}
	
	.main-content {
		position: absolute;
	    top:50%;
	    left:50%;
	    transform: translate(-50%, -50%);
	    color: white;
	    z-index: 999;
		font-family: 'Noto Sans KR';
		text-align: center;
	}
	
	.img-cover {
		background-color: #000;
		opacity: 0.5;
		z-index: 998;
		position: absolute;
		height: 100%;
		width: 100%;
	}
	
	.home {
		height: 100vh;
	}
	
	.btn-join {
		text-decoration: none;
		height: 40px;
		border: 1px solid #e0e0e0;
	    padding: 0 23px;
	    color: #000;
	    font-size: 13px;
	    background-color: #fff;	
	    box-sizing: border-box;
	    text-align: center;
	    border-radius: 20px;
	    max-width: 280px;
	    min-width: 280px;
	    display: inline-block;
	    line-height: 38px;
	    margin: 10px;
	    transition: background-color .1s linear, border-color .1s linear;
	}
	
	.btn-join:hover {
		text-decoration: none;
		background-color: #46b8da;
		border-color : #46b8da;
		color: #fff;
	}
	
	.btn-login {
		text-decoration: none;
		height: 40px;
		border: 1px solid #e0e0e0;
	    padding: 0 23px;
	    color: #000;
	    font-size: 13px;
	    background-color: #fff;	
	    box-sizing: border-box;
	    text-align: center;
	    border-radius: 20px;
	    max-width: 280px;
	    min-width: 280px;
	    display: inline-block;
	    line-height: 38px;
	    margin: 10px;
	}
	
	.btn-login:hover {
		text-decoration: none;
		background-color: #46b8da;
		border-color : #46b8da;
		color: #fff;
	}
	
	.icon-scroll {
	    position: fixed;
	    bottom: 3%;
	    z-index: 999;
	    transition: bottom 0.4s linear;
	    left: 49%;
	}
	
	.icon-scroll:hover {
	    text-align: center;
	    bottom: 8%;
	    z-index: 999;
	    left: 49%;
	}
	
	.title{
		font-family: 'Do Hyeon', sans-serif;
		text-align: center;
		font-size: 54px;
		color: #b4b4b4;
		margin: 20px;
	}
	
	.title:hover{
		color: black;
	}

</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

	var scrollEvent = false;
	var count = 0;
	
	$("html, body").on('mousewheel', function(c) {
		
		var m = c.originalEvent.wheelDelta;
		var sb = $(".home").height();
		
		if(m>1 && scrollEvent == false && count >= 1) {
			console.log(count);
			scrollEvent = true;
			count--;
			
			$("html,body").stop().animate({scrollTop: sb*count},
					{duration: 600, complete: function() {
						scrollEvent = false;}
					});
			
			if(count > 1) {
				$(".icon-scroll").css("display", "none");
			} else {
				$(".icon-scroll").css("display", "");
			}
			
		} else if (m<1 && scrollEvent == false && count < 3) {
			console.log(count);
			scrollEvent = true;
			count++;
			
			$("html,body").stop().animate({scrollTop: sb*count},
					{duration: 600, complete: function() {
						scrollEvent = false;}
					});
			
			if(count > 1) {
				$(".icon-scroll").css("display", "none");
			} else {
				$(".icon-scroll").css("display", "");
			}
		}
		
	});
	
	$(function(){
		
		$('#title_notice').hover(function(){
			$('#notice').css("background-color", "#FFD5D2");		
		}, function(){
			$('#notice').css("background-color", "white");
		});
		
		$('#title_map').hover(function(){
			$('#map').css("background-color", "#20B2AA");		
		}, function(){
			$('#map').css("background-color", "white");
		});
		
		$('#title_life').hover(function(){
			$('#life').css("background-color", "#32B8FF");		
		}, function(){
			$('#life').css("background-color", "white");
		});
		
		$('#title_resale').hover(function(){
			$('#resale').css("background-color", "#FF9614");		
		}, function(){
			$('#resale').css("background-color", "white");
		});
		
		$('#title_festival').hover(function(){
			$('#festival').css("background-color", "#bc3cbc");		
		}, function(){
			$('#festival').css("background-color", "white");
		});
		
	});

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>

	<div class="container-fluid">
		<div class="home main-img">
			<div class="main-content" style="color: #fff;">
				<h1 style="margin: 0;"><strong>ENJOY YOUR SINGLE LIFE</strong></h1>
				<p style="font-size: 1.5em; line-height: 40px; padding: 15px 0 45px;"><br>어려울 거 없어요<br>한 번의 로그인이면 돼요!<br>바로 시작해볼까요?<br></p>
				<a class="btn-join" href="/SINGLE/member/joinpage.do">가입하기</a>
				<br>
				<a class="btn-login" href="/SINGLE/member/loginpage.do">로그인하기</a>
			</div>
			<div class="img-cover"></div>
		</div>
		
		<!-- 스크롤 이미지 고정 -->
        <div class="icon-scroll">
            <img style="width: 50px; height: 50px;" src="${pageContext.request.contextPath}/resources/images/icon/scrolldown.png" alt="스크롤">
        </div>
        
        <div class="home" style="padding-top: 200px;">
			<div class="title" id="title_notice">
				<span>
					우리동네 소식을 알고 싶다면
				</span>
				<br/>
				<span>
					<span id="notice">공지</span> 로 들어가면 돼요
				</span>
			</div>

			<div class="title" id="title_map">
				<span class="title_content">
					남는 식재료가 있거나 
				</span>
				<br/>
				<span>
					동네친구를 사귀고 싶으세요?
				</span>
				<br/>
				<span class="title_content">
					<span id="map">지도</span>를 통해 알아봐요
				</span>
			</div>
		</div>
		
		<div class="home" style="padding-top: 50px;">
			<div class="title" id="title_life">
				<span>
					철저한 예약제를 통한
				</span>
				<br/>
				<span class="title_content">
					 가사전문가의 손길을 받고 싶으세요?
				</span>
				<br/>
				<span>
					<span id="life">빨래, 가사 도우미</span> 예약이 있어요!
				</span>
			</div>
			
			<div class="title" id="title_resale">
				<span>
					처치 곤란한 중고품들?
				</span>
				<br/>
				<span>
					<span id="resale">중고게시판</span>을 통해 사고 팔 수 있어요
				</span>
			</div>
			
			<div class="title" id="title_festival">
				<span>
				특별한 <span id="festival">행사나 축제 정보</span>
				</span>
				<br/>
				<span>
				귀찮게 찾으러 다니지 마세요
				</span>
				<br/>
				<span>
				 쉽게 정보를 알 수 있으니까요
				</span>
			</div>
		</div>
			
	</div>
	
</body>
</html>