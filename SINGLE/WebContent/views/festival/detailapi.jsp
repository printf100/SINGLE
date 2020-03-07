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
<title>Insert title here</title>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="keywords" content="koreatravelinfo" />
	<meta name="author" content="sondeokhyeon" />

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="keywords" content="koreatravelinfo" />
	<meta name="author" content="sondeokhyeon" />

	<!-- <script src="..js/header.js"></script> -->
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
	 <script src="../../resources/js/modernizr-2.6.2.min.js"></script> 
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="../js/respond.min.js"></script>
	<![endif]-->
<!-- END :: JAVASCRIPT -->
	<style>
		li {
			list-style: none;
		}

		ul .nav {
			background-color: #e2e2e2;
		}

		.img-responsive {
			margin : auto;
			width: 88% !important;
			padding-left: 20px;
		}
	</style>
	
	<meta property="og:type" content="website">
	<meta property="og:image:width" content="400" />
	<meta property="og:image:height" content="210" />
</head>
<body>


		<div id="fh5co-main">
			<div class="fh5co-narrow-content">
				<div class="row" id="travelContents">
				</div>
				<div id="detailIntro"> </div>
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
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6973ad6c8dbfd7b2b57396794ffbc5e6"></script>


	<script type="text/javascript">
	$(function () {
		common.leftMenuImport();
		var id = $.urlParam('id');
		var item = $.urlParam('item');
		common.getInfo('get', 'detailCommon', "contentTypeId=" + item + "&contentId=" + id + "&MobileOS=ETC&MobileApp=AppTest&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y&transGuideYN=Y", parsing.contentsParsing);
		common.getInfo('get', 'detailIntro', "contentTypeId=" + item + "&contentId=" + id + "&MobileOS=ETC&MobileApp=AppTest&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y&transGuideYN=Y", common.detailPageIntroInfoDraw);
	})

	$.urlParam = function (name) {
		var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
		return results[1] || 0;
	}

	var parsing = {

		test: function (data) {
			console.log(data)
		},
		contentsParsing: function (data) {
			var InfoElements;
			var title;
			var list = data.response.body.items.item

			document.getElementsByTagName('head')[0].innerHTML += "<meta property='og:title' content=" + list.title.replace(/(\s*)/g, "")  + ">";
			document.getElementsByTagName('head')[0].innerHTML += "<meta property='og:description' content=" + list.title.replace(/(\s*)/g, "") + ">";

			if (list.firstimage === undefined) {
				title = window.location.href.split("/")[2].concat('../../resources/css/images/default.png');
				document.getElementsByTagName('head')[0].innerHTML += "<meta property='og:image' content="+window.location.href.split("/")[0] + "//" + title + ">";
			} else {
				title = list.firstimage;
				document.getElementsByTagName('head')[0].innerHTML += "<meta property='og:image' content=" + title + ">";
			}

			InfoElements =
				"<div class='col-md-12'>"
				+ "<figure class='text-center'>"
				+ "<img src='" + title + "'" + "alt='이미지가 없습니다' class='img-responsive'>"
				+ "</figure>"
				+ "</div>"
				+ "<div class='col-md-12'>"
				+ "<figcaption>"
				+ "<ul>"
				+ "<li>"
				+ "<span> " + "<h2>" + list.title + "</h2>" + "</span>"
				+ "</li>"
				+ "<li>"
				+ "<b>위치</b>"
				+ "<span> " + list.addr1 + "</span>"
				+ "</li>"
				+ "<li>"
				+ "<b>문의</b>"
				+ "<span> " + list.tel + "</span>"
				+ "</li>"
				+ "</ul>"
				+ "</figcaption>"
				+ "<div class='buttonSet text-center'>"
				if (list.homepage !== undefined) { 
					InfoElements + list.homepage
				} 
				InfoElements += "</div>"
				+ "<div class='col-md-12'>"
				+ "<div class='cntBox'>"
				+ "<ul>"
				+ "<li><em>개요</em> <p style='text-align:justify;'>"
				+ list.overview
				+ "</li>"
				+ "<li><div id='map' style='width:100%; height:300px;'></div></li>"
				+ "<li><em>정보제공자</em>"
				+ "<ul>"
				+ "<li>" + list.telname + "</li>"
				+ "</ul>"
				+ "</li>"
				+ "</ul>"
				+ "</div>"
				+ "</div>"
				+ "</div>"
			$("#travelContents").append(InfoElements)


			var mapContainer = document.getElementById('map'),
				mapOption = {
					center: new daum.maps.LatLng(list.mapy, list.mapx),
					level: 3
				};
			var map = new daum.maps.Map(mapContainer, mapOption);
			var mapTypeControl = new daum.maps.MapTypeControl(); 				// 맵 타입컨트롤러 추가 
			var zoomControl = new daum.maps.ZoomControl();		 				// 줌 컨트롤러 추가 
			var markerPosition = new daum.maps.LatLng(list.mapy, list.mapx);   // 마커 position SET 
			var marker = new daum.maps.Marker({
				position: markerPosition
			});
			map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);
			map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
			marker.setMap(map);
		}
	}	
	
	</script>

</body>
</html>