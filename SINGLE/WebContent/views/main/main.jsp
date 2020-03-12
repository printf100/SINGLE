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
<title>SINGLE</title>

<!-- START :: CSS -->
<style type="text/css">
   
   @import url('https://fonts.googleapis.com/css?family=Do+Hyeon&display=swap');
   
   .container-fluid {
      margin: 0;
      padding: 0;
   }
   
   .main {
      text-align: center;
      height: 100vh;
      overflow: hidden;
   }
   
   .btn-profile {
      text-decoration: none;
      height: 50px;
      border: 1px solid #e0e0e0;
       padding: 0 23px;
       color: #000;
       font-size: 20px;
       background-color: #fff;   
       box-sizing: border-box;
       text-align: center;
       border-radius: 20px;
       max-width: 400px;
       min-width: 400px;
       display: inline-block;
       line-height: 48px;
       margin-top: 50px;
   }
   
   .btn-profile:hover {
      text-decoration: none;
      background-color: #46b8da;
      border-color : #46b8da;
      color: #fff;
   }
   
   .main-profile-img {
      position: relative;
      width: 15rem;
      height: 15rem;
      border-radius: 0.25rem;
      overflow: hidden;
      margin: 0 auto;
   }
   
   #img {
      width: 100%;
      height: 100%;
      object-fit: cover;
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
   
   /* carousel */
   
   .carousel-caption {
      margin: 10px;
   }
   .slide_title_1{
      font-size: 50px;
       margin-bottom: -30px;
   }
   .slide_title_2{
      font-size: 50px;
      margin-bottom: 30px
   }
   .slide_subtitle{
      font-size: 20px;
      margin: auto;
   }
   .btn:hover{
      background-color: #46b8da;
      color: #fff;
   }
   .btn btn-light:hover{
      background-color: #46b8da;
      color: #fff;
   }
   .slide_bg_1{
      padding: 5px;
      width: 490px;
      background-color: #FFA500;
   }
   .slide_bg_2{
      padding: 5px;
      width: 350px;
      background-color: #FFA500;
   }
   .slide_bg_3{
      padding: 5px;
      width: 650px;
      background-color: #FF4646;
   }
   .slide_bg_4{
      padding: 5px;
      width: 180px;
      background-color: #FF4646;
   }
   
   /* main 설명 */
   
   .link-guide {
      color: #b4b4b4;
      text-decoration: none;
   }
   
   .title{
      font-family: 'Do Hyeon', sans-serif;
      text-align: center;
      font-size: 54px;
      color: #b4b4b4;
      margin: 20px;
   }
   
   .link-guide:hover{
      color: black;
   }
   
   /* 페스티발 */
   
   .festival_intro_box{
      width:100%;
      padding-left: 5%;
      padding-right: 5%;
      text-align: left;
      margin-top: 5%;
   }
   
   .festival_intro{
      color: black;
      font-weight: bold;
      font-size: 38px;
   }
   
   .festival_intro_sub{
      color: #969696;
      font-size: 22px;
      line-height: 15px;
   }
   
   .festival_container {
   		padding: 20px;
   }
   
   .festival{
	    padding: 30px;
	    border: thick #000069;    
	    border-top-left-radius: 3px; 
	    border-bottom-left-radius: 3px;
	    border-top-right-radius: 3px;
	    border-bottom-right-radius: 3px;
   } 
   
   .festival:hover{
   		box-shadow: 0 3px 6px 0 rgba(0, 0, 0, 0.2), 0 5px 18px 0 rgba(0, 0, 0, 0.19);
   }
   
   .festival_player{
	   font-weight: bold;
	   color: black;
   }
   
   .festival_title{
   		font-weight: bold;
	   color: #969696;
   }
   
   .festival_org_name{
	   color: #969696;
   }
   
   .festival_place{
	   color: #E57733;
   }
   
   .festival_date{
	   color: #969696; 
   }
    
</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e279f4719a19c18fde6278302eaeb6d8&libraries=services"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
   
   var scrollEvent = false;
   var count = 0;
   
   $("html, body").on('mousewheel', function(c) {
      
      var m = c.originalEvent.wheelDelta;
      var sb = $(".main").height();
      
      if(m>1 && scrollEvent == false && count >= 1) {
         console.log(count);
         scrollEvent = true;
         count--;
         
         $("html,body").stop().animate({scrollTop: sb*count},
               {duration: 600, complete: function() {
                  scrollEvent = false;}
               });
         
         if(count > 3) {
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
         
         if(count > 3) {
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
         $('#maptag').css("background-color", "#20B2AA");      
      }, function(){
         $('#maptag').css("background-color", "white");
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
   
   
   // 페스티벌 가져오기
   $(function() {
      $.getJSON("http://openapi.seoul.go.kr:8088/45434d5a4c6c696237345967557956/json/culturalEventInfo/1/3/", function(data){
      
         $.each(data, function(key, val){
            if(key == "culturalEventInfo"){
               
               $.each(val, function(k, v){
                  if(k == "row"){
                     
                     var list = v;
                     for(var i=0; i<list.length; i++){
                        var str = list[i];
                        $(".row").append(
                              "<div class='festival card col-md-4'>"+
                              	 "<div style='width: 300px; height: 300px; overflow: hidden; margin:auto;'>"+
	                              	"<img class='card-img-top' src = '"+str.MAIN_IMG+"'style='width:100%'>"+
	                              "</div>"+
                              	"<div class='card-body'>"+
                                 	"<p class='festival_date card-text'>"+str.DATE+"</p>"+
                                 	"<h4 class='card-title'>"+str.TITLE+"</h4>"+
                                 	"<p class='festival_place card-text'>"+str.PLACE+"</p>"+
                                 	"<p class='festival_player card-text'>"+str.PLAYER+"</p>"+
                                 "</div>"+
                                 "</div>"
                        );
                     
                     }  // for문 괄호
                  }
               });  //each val function 괄호
            } // key cultu 괄호
         });
      });
   });

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>
   
   <div class="container-fluid">
      <div class="row">
      
         <!-- 첫 번째 섹션 -->
         <div class="main col-md-12">
            <c:choose>
               <c:when test="${profile.MPROFILE_LATITUDE eq null}">
                  <div style="padding-top: 350px;">
                     <h1><strong>정확한 서비스를 위해 프로필을 완성해주세요!</strong></h1>
                     <a class="btn-profile" href="/SINGLE/member/profilepage.do">프로필 완성하러 가기</a>
                  </div>
               </c:when>
               <c:otherwise>
                  <div style="padding-top: 150px;">
                     <div class="main-profile-img">
                        <img id="img" alt="프로필 사진" src="../resources/images/profileimg/${profile.MPROFILE_IMG_SERVERNAME }">
                     </div>
                     <div style="margin-top: 20px;">
                        <h1><strong>${profile.MEMBER_NICKNAME }</strong></h1>
                     </div>
                     <div style="margin-top: 20px;">
                        <h4>${profile.MPROFILE_INTRODUCE }</h4>
                     </div>
                        
                     <!-- 카카오 맵 -->
                     <div id="map" style="width: 300px; height: 200px; margin: auto; margin-top: 25px;"></div>
                  </div>
               </c:otherwise>
            </c:choose>
         </div>
         
         <!-- 두 번째 섹션 -->
         <div class="main col-md-12 pl-0 pr-0">
            <div id="myCarousel" class="carousel slide" data-ride="carousel" style="padding-top: 80px; padding-bottom: 10px;">
              <!-- Indicators -->
              <ul class="carousel-indicators">
                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#myCarousel" data-slide-to="1"></li>
                <li data-target="#myCarousel" data-slide-to="2"></li>
                <li data-target="#myCarousel" data-slide-to="3"></li>
                <li data-target="#myCarousel" data-slide-to="4"></li>
              </ul>
            
              <!-- The slideshow -->
              <div class="carousel-inner" style="height:800px;">
              
                <div class="carousel-item active">
                  <img src="../resources/images/main/main1.jpg" width="100%" height="100%">
                  <div class="carousel-caption" style="text-align: left; bottom: 400px;">
                     <p class="slide_title_1"><b>혼자</b> 사는 사람을 위한<p>
                     <p class="slide_title_2">맞춤형 사이트</p>
                     <p class="slide_subtitle">동네 소식, 생활맞춤 서비스, 싱글족들과 친목다지기 등</p>
                     <p class="slide_subtitle">본인에게 필요한 서비스를 찾아가세요</p>
                     <button style="margin-top: 20px" type="button" class="btn btn-light" onclick="location.href='/SINGLE/board/noticepage.do';">공지 둘러보러 가기</button>
                  </div>
                </div>
                
                <div class="carousel-item">
                  <img src="../resources/images/main/main2.jpg" width="100%" height="100%">
                  <div class="carousel-caption" style="text-align: right; bottom: 560px;">
                     <p class="slide_title_1"><b>혼자</b> 사는 사람을 위한<p>
                     <p class="slide_title_2">맞춤형 지도</p>
                     <p class="slide_subtitle" >집 주변 CCTV, 남는 식재료 공유, 동네 친구찾기, 안심택배 무인함 정보, 식당 위치 등</p>
                     <p class="slide_subtitle">편리한 기능을 사용해 보세요</p>
                     <button style="margin-top: 20px" type="button" class="btn btn-light" onclick="location.href='/SINGLE/map/map.do';">지도 둘러보러 가기</button>
                  </div>
                </div>
                
                <div class="carousel-item">
                  <img src="../resources/images/main/main3.jpg" width="100%" height="100%">
                  <div class="carousel-caption" style="text-align: left; bottom: 560px;">
                     <p class="slide_title_1"><b>혼자</b> 사는 사람을 위한<p>
                     <p class="slide_title_2">맞춤형 집안일 서비스</p>
                     <div class="slide_bg_1">
                        <p class="slide_subtitle">원하는 시간 전문가에게 맡기는 청소, 빨래 도우미 찾기 등</p>
                     </div>
                     <div class="slide_bg_2">
                        <p class="slide_subtitle">바쁜 싱글족을 위한 서비스를 만나보세요</p>
                     </div>
                     <button style="margin-top: 20px" type="button" class="btn btn-light" onclick="location.href='/SINGLE/life/lifeSelect.do';">가사서비스 둘러보러 가기</button>
                  </div>
                </div>
                
                <div class="carousel-item">
                  <img src="../resources/images/main/main4.jpg" width="100%" height="100%">
                  <div class="carousel-caption" style="text-align: left; bottom: 560px;">
                     <p class="slide_title_1"><strong>혼자</strong> 사는 사람을 위한<p>
                     <p class="slide_title_2">맞춤형 중고거래</p>
                     <div class="slide_bg_3">
                        <p class="slide_subtitle">더 이상 쓸모 없어졌지만 처치 곤란한 상품들을 돈 받고 처리할 수 있는 서비스</p>
                     </div>
                     <div class="slide_bg_4">
                        <p class="slide_subtitle">한 번 구경해보세요</p>
                     </div>
                     <button style="margin-top: 20px" type="button" class="btn btn-light" onclick="location.href='/SINGLE/board/resaleMainList.do';">중고게시판 둘러보러 가기</button>
                  </div>
                </div>
                
                <div class="carousel-item">
                  <img src="../resources/images/main/main5.jpg" width="100%" height="100%">
                  <div class="carousel-caption" style="text-align: right; bottom: 560px;">
                     <p class="slide_title_1"><b>혼자</b> 사는 사람을 위한<p>
                     <p class="slide_title_2">맞춤형 축제 행사 소식</p>
                     <p class="slide_subtitle">원하는 시간 원하는 장소에서 이뤄지는 다양한 축제 소식</p>
                     <p class="slide_subtitle">편안하게 검색해 보러 가세요</p>
                     <button style="margin-top: 20px" type="button" class="btn btn-light" onclick="location.href='/SINGLE/festival/festivalpage.do';">축제소식 둘러보러 가기</button>
                  </div>
                 </div>
                 
              </div>
            
              <!-- Left and right controls -->
              <a class="carousel-control-prev" href="#myCarousel" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
              </a>
              <a class="carousel-control-next" href="#myCarousel" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
              </a>
            </div>
         </div>
         
         <div class="main col-md-12">
            <div class="festival_intro_box">
               <p class="festival_intro">행사 소식 잠깐 보고 가실래요?</p>
               <p class="festival_intro_sub">여러분이 거주하는 곳 근처 행사 소식을 자세히 알아보고 싶으시면</p>
               <p class="festival_intro_sub">행사 탭으로 들어가면 돼요!</p>
            </div>
            <div class="festival_container">
               	<div class="row"></div>
            </div>
         </div>
         
         <!-- 스크롤 이미지 고정 -->
         <div class="icon-scroll">
         	<img style="width: 50px; height: 50px;" src="${pageContext.request.contextPath}/resources/images/icon/scrolldown.png" alt="스크롤">
         </div>
           
         <div class="main col-md-12" style="padding-top: 200px;">
            <div class="title" id="title_notice">
               <a href="/SINGLE/board/noticepage.do" class="link-guide">
                  <span>
                     	우리동네 소식을 알고 싶다면
                  </span>
                  <br/>
                  <span>
                     <span id="notice">공지</span> 로 들어가면 돼요
                  </span>
               </a>
            </div>
   
            <div class="title" id="title_map">
               <a href="/SINGLE/map/map.do" class="link-guide">
                  <span class="title_content">
                     	남는 식재료가 있거나 
                  </span>
                  <br/>
                  <span>
                     	동네친구를 사귀고 싶으세요?
                  </span>
                  <br/>
                  <span class="title_content">
                     <span id="maptag">지도</span>를 통해 알아봐요
                  </span>
               </a>
            </div>
         </div>
         
         <div class="main col-md-12" style="padding-top: 80px;">
            <div class="title" id="title_life">
               <a href="/SINGLE/life/lifeSelect.do" class="link-guide">
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
               </a>
            </div>
            
            <div class="title" id="title_resale">
               <a href="/SINGLE/board/resaleMainList.do" class="link-guide">
                  <span>
                     	처치 곤란한 중고품들?
                  </span>
                  <br/>
                  <span>
                     <span id="resale">중고게시판</span>을 통해 사고 팔 수 있어요
                  </span>
               </a>
            </div>
            
            <div class="title" id="title_festival">
               <a href="/SINGLE/festival/festivalpage.do" class="link-guide">
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
               </a>
            </div>
         </div>
         
         <div class="col-md-12 pl-0 pr-0">
            <!-- START :: include footer -->
            <%@include file="/views/form/footer.jsp" %>
            <!-- END :: include footer -->
         </div>
         
         <input type="hidden" id="MPROFILE_LATITUDE" name="MPROFILE_LATITUDE" value="<c:if test='${profile.MPROFILE_LATITUDE eq null}'>37.499017</c:if>${profile.MPROFILE_LATITUDE }">
         <input type="hidden" id="MPROFILE_LONGITUDE" name="MPROFILE_LONGITUDE" value="<c:if test='${profile.MPROFILE_LONGITUDE eq null}'>127.032907</c:if>${profile.MPROFILE_LONGITUDE }">
      </div>
      
   </div>
   
</body>

<!-- START :: 카카오 맵 -->
<script type="text/javascript">

   var mapContainer = document.getElementById('map');
   var mapOption = {
      center: new kakao.maps.LatLng($("#MPROFILE_LATITUDE").val(), $("#MPROFILE_LONGITUDE").val()),
      draggable: false,
      level: 4
   };
   
   // 지도 생성
   var map = new kakao.maps.Map(mapContainer, mapOption);
   
   // 마커 설정
   var imageSrc = '../resources/images/marker/marker_myLocation.png',
       imageSize = new kakao.maps.Size(55, 55), // 마커 크기
       imageOption = {offset: new kakao.maps.Point(27, 69)};
   
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
       markerPosition = new kakao.maps.LatLng($("#MPROFILE_LATITUDE").val(), $("#MPROFILE_LONGITUDE").val());

   var marker = new kakao.maps.Marker({
       position: markerPosition,
       image: markerImage
   });
   
   // 지도에 마커 표시
   marker.setMap(map);
   
</script>
<!-- END :: 카카오 맵 -->

</html>