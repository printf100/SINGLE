<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- START :: include header -->
<%@include file="/views/form/header.jsp" %>
<!-- END :: include header -->

<!DOCTYPE html>
<html class="no-js">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>SINGLE</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="tourAPI 3.0 and bootstrap template make to used this page" />
	<meta name="keywords" content="koreatravelinfo" />
	<meta name="author" content="sondeokhyeon" />

	<link rel="shortcut icon" href="favicon.ico">
	<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
		new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
		j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
		'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
		})(window,document,'script','dataLayer','GTM-5F6KFVP');</script>
		<!-- End Google Tag Manager -->

	<link href='https://fonts.googleapis.com/css?family=Roboto:400,300,600,400italic,700' rel='stylesheet' type='text/css'>
	<link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>

	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/animate.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/icomoon.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/owl.carousel.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/owl.theme.default.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/customused.css">
	
	<!-- Modernizr JS -->
	<script src="${pageContext.request.contextPath}/resources/js/modernizr-2.6.2.min.js"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="../js/respond.min.js"></script>
	<![endif]-->
<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>
		
	
	
		<div id="fh5co-main">
			<div class="fh5co-narrow-content">
				<h2 class="animate-box" data-animate-effect="fadeInLeft">
				축제정보
				</h2>
				<nav class="areaLists">
					<span class="area area__select-style">지역</span>
					<span class="sigungu area__select-style">시군구</span>
					<div class="areaList">
						<div class="hiddenMenu">
							<li class="areaCodes" data-toggle="1">서울</li>
							<li class="areaCodes" data-toggle="7">울산</li>
							<li class="areaCodes" data-toggle="35">경북</li>
						</div>
						<div class="hiddenMenu">
							<li class="areaCodes" data-toggle="2">인천</li>
							<li class="areaCodes" data-toggle="8">세종시</li>
							<li class="areaCodes" data-toggle="36">경남</li>
						</div>
						<div class="hiddenMenu">
							<li class="areaCodes" data-toggle="3">대전</li>
							<li class="areaCodes" data-toggle="31">경기도</li>
							<li class="areaCodes" data-toggle="37">전북</li>
						</div>
						<div class="hiddenMenu">
							<li class="areaCodes" data-toggle="4">대구</li>
							<li class="areaCodes" data-toggle="32">강원도</li>
							<li class="areaCodes" data-toggle="38">전남</li>
						</div>
						<div class="hiddenMenu">
							<li class="areaCodes" data-toggle="5">광주</li>
							<li class="areaCodes" data-toggle="33">충북</li>
							<li class="areaCodes" data-toggle="39">제주도</li>
						</div>
						<div class="hiddenMenu">
							<li class="areaCodes" data-toggle="6">부산</li>
							<li class="areaCodes" data-toggle="34">충남</li>
						</div>
					</div>
					<ul class="sigunguLists">
						<li>지역을 먼저 선택하세요</li>
					</ul>
				</nav>
				<div class="row animate-box" id="travelContents" data-animate-effect="fadeInLeft">
				</div>
				<div class="text-right"><a href="javascript:void(0)" onclick="moreView()">더보기</a></div>
			</div>
		</div>
	</div>
	
	<!-- jQuery -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<!-- jQuery Easing -->
	 <script src="${pageContext.request.contextPath}/resources/js/jquery.easing.1.3.js"></script> 
	<!-- Bootstrap -->
	 <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script> 
	<!-- Carousel -->
	 <script src="${pageContext.request.contextPath}/resources/js/owl.carousel.min.js"></script> 
	<!-- Stellar -->
	 <script src="${pageContext.request.contextPath}/resources/js/jquery.stellar.min.js"></script> 
	<!-- Waypoints -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery.waypoints.min.js"></script>
	<!-- Counters -->
	 <script src="${pageContext.request.contextPath}/resources/js/jquery.countTo.js"></script> 
	<!-- MAIN JS -->
	 <script src="${pageContext.request.contextPath}/resources/js/main.js"></script> 
	<!-- 180510 common 추가 -->
	<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
	
	<script type="text/javascript">
	$(function () {
		/*  common.leftMenuImport();  */
		common.getMonth();
		common.areaChange();
		common.sigunguChange();
		common.buttonAction();
		draw.init();
		draw.elements();
	})
	var parsing = {
		test: function (data) {
			console.log(data)
		},
		dataParsing: function (data) {
			var list = data.response.body.items.item
			if (Array.isArray(list)) {
				if (list != undefined) {
					$.each(list, function (i, item) {
						var InfoElements =
							"<div class='col-xs-6 col-sm-6 col-md-4 col-lg-3'>"
							+ "<a href='/SINGLE/festival/detailapipage.do?id=" + item.contentid + "&item=" + item.contenttypeid + "'" + "target='_blank'>"
							+ "<div class='thumbnail'>"
							+ "<img class=" + "'img-responsive'" + "src=" + "'" + item.firstimage + "'" + "onError=" + "this.onerror=null;this.src='${pageContext.request.contextPath}/resources/css/images/default.png';" + ">"
							+ "<div class='caption text-center'>"
							+ "<h5>" + item.title + "</h5>"
							+ "<h6>" + item.addr1 + "</h6>"
							+ "</div>"
							+ "</div>"
							+ "</a>"
							+ "</div>"
						$("#travelContents").append(InfoElements)
					})
				} else {
					$(".text-right").css("display", "none");
				}
			} else if (data.response.body.items === '') {
				$(".text-right").css("display", "none");
			} else {
				console.log(data)
				var infoElements =
					"<div class='col-xs-6 col-sm-6 col-md-4 col-lg-3'>"
					+ "<a href='/SINGLE/festival/detailapipage.do?id=" + list.contentid + "&item=" + list.contenttypeid + "'" + " target='_blank'>"
					+ "<div class='thumbnail'>"
					+ "<img class=" + "'img-responsive'" + "src=" + "'" + list.firstimage + "'" + "onError=" + "this.onerror=null;this.src='${pageContext.request.contextPath}/resources/css/images/default.png';" + ">"
					+ "<div class='caption text-center'>"
					+ "<h5>" + list.title + "</h5>"
					+ "<h6>" + list.addr1 + "</h6>"
					+ "</div>"
					+ "</div>"
					+ "</a>"
					+ "</div>"
				$("#travelContents").append(infoElements)

			}
		}
	}

	var draw = {

		elementCount: 0,
		areaCode: 0,
		sigunguCode: 0,

		init: function () {
			this.elementCount = '';
			this.areaCode = '';
			this.sigunguCode = '';
		},
		elements: function () {
			var date = common.getDate()
			common.getInfo('get', 'searchFestival', 'areaCode=' + this.areaCode + '&sigunguCode=' + this.sigunguCode + '&listYN=Y&MobileOS=ETC&MobileApp=AppTest&numOfRows=24&eventStartDate=' + date + '&pageNo=' + this.elementCount, parsing.dataParsing);
		},
		areaSigunguCodeGet: function () {
			common.getInfo('get', 'areaCode', 'numOfRows=50&MobileOS=ETC&MobileApp=test&areaCode=' + this.areaCode, common.areaDetailCodeParsing);
		}
	}
	</script>



</body>
</html>