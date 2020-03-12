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
	<script src="../js/modernizr-2.6.2.min.js"></script>
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
					위치기반<span id="demo"></span>
					<button type="button" class="btn btn-default" id="get-location-info" onclick="getLocation()" style="font-size:12px;">위치불러오기</button>
					<button type="button" class="btn btn-default showbtn" onclick="draw.daumMapDraw()" style="display:none; font-size:12px;">현재위치보기</button>
					<button type="button" class="btn btn-default closebtn" onclick="draw.daumMapclose()" style="display:none; font-size:12px;">현재위치닫기</button>
					<div class="rangeWrap" style="margin-top: 30px;">
						<span class="kilometer" data-toggle="1">100m</span>
						<span class="kilometer active" data-toggle="2">300m</span>
						<span class="kilometer" data-toggle="3">500m</span>
						<span class="kilometer" data-toggle="4">1km</span>
						<span class="kilometer" data-toggle="5">3km</span>
					</div>
				</h2>
				<div id="information" style="margin-top: 15%; margin-left: 5%; display: block;">
					<h1 id="notification" style="color: #8c8b8b;">위치 불러오기를 누르시면<br>주변정보를 가져옵니다</h1>
				</div>
				<div>
					<div id="map" style="width:100%; height:300px; position: absolute;"></div>
				</div>
				<div class="row animate-box" id="travelContents" data-animate-effect="fadeInLeft">
					<div class="text-right" id="moreViewWrap">
						<a href="javascript:void(0)" onclick="moreView()">더보기</a>
					</div>
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
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6973ad6c8dbfd7b2b57396794ffbc5e6"></script>

		<script>
			$(function () {
				common.leftMenuImport();
				draw.init();
				draw.kilometerSet();
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
								$("#travelContents").append(InfoElements);
								$('.showbtn').css('display', 'inline');
							})
						} else {
							$(".text-right").css("display", "none");
						}
					} else if (data.response.body.items === '') {
						$('#information').css('display', 'block');
						$("#notification").text('설정한 거리내에 관광정보가 없습니다.');
						$(".text-right").css("display", "none");
						$('.showbtn').css('display', 'inline');
					} else {
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
						$("#travelContents").append(infoElements);
						$('.showbtn').css('display', 'inline');
					}
				}
			}

			var draw = {
				elementCount: 0,
				mapY: 0,
				mapX: 0,
				searchArrange: 0,

				init: function () {
					//$('.overlay').removeClass('overlay')
					this.elementCount = 1;
					this.mapY = 37.497891;
					this.mapX = 127.027337;
					this.searchArrange = 300;
				},
				elements: function () {
					common.getInfo('get',
						'locationBasedList',
						'MobileOS=ETC&MobileApp=AppTest&arrange=E&numOfRows=24&pageNo=' + this.elementCount
						+ '&mapY=' + this.mapY
						+ '&mapX=' + this.mapX
						+ '&radius=' + this.searchArrange,
						parsing.dataParsing);
				},
				kilometerSet: function () {
					$('.kilometer').click(function () {
						var $ref = $(this).context.attributes[1].value
						if ($ref === '1') {
							draw.searchArrange = 100;
							$('.kilometer').removeClass('active')
							$(this).addClass('active');
						} else if ($ref === '2') {
							draw.searchArrange = 300;
							$('.kilometer').removeClass('active')
							$(this).addClass('active');
						} else if ($ref === '3') {
							draw.searchArrange = 500;
							$('.kilometer').removeClass('active')
							$(this).addClass('active');
						} else if ($ref === '4') {
							draw.searchArrange = 1000;
							$('.kilometer').removeClass('active')
							$(this).addClass('active');
						} else if ($ref === '5') {
							draw.searchArrange = 3000;
							$('.kilometer').removeClass('active')
							$(this).addClass('active');
						}
					})
				},

				daumMapDraw: function () {
					var mapContainer = document.getElementById('map'),
						mapOption = {
							center: new daum.maps.LatLng(this.mapY, this.mapX),
							level: 3
						};
					var map = new daum.maps.Map(mapContainer, mapOption);
					var markerPosition = new daum.maps.LatLng(this.mapY, this.mapX);
					var marker = new daum.maps.Marker({
						position: markerPosition
					});
					marker.setMap(map);
					$('#map').css('display', 'block');
					$('.showbtn').css('display', 'none');
					$('.closebtn').css('display', 'inline');
				},
				daumMapclose: function () {
					$('#map').css('display', 'none');
					$('.closebtn').css('display', 'none');
					$('.showbtn').css('display', 'inline');
				}
			}
		</script>


</body>
</html>