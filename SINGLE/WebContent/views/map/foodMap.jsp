<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.single.model.dto.map.FoodDto"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
   request.setCharacterEncoding("UTF-8");
%>

<%
   response.setContentType("text/html; charset=UTF-8");
%>

<%@include file="/views/form/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>


<style>
#font {
   font-size: 20px;
   margin-top: 10px;
   margin-botton: 10px;
}

.fooddetail {
   width: 300px;
}

.filebox label {
   display: inline-block;
   padding: .5em .75em;
   color: #999;
   font-size: inherit;
   line-height: normal;
   vertical-align: middle;
   background-color: #fdfdfd;
   cursor: pointer;
   border: 1px solid #ebebeb;
   border-bottom-color: #e2e2e2;
   border-radius: .25em;
}

.filebox input[type="file"] { /* 파일 필드 숨기기 */
   position: absolute;
   width: 1px;
   height: 1px;
   padding: 0;
   margin: -1px;
   overflow: hidden;
   clip: rect(0, 0, 0, 0);
   border: 0;
}

.map_wrap, .map_wrap * {
   margin: 0;
   padding: 0;
   font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
   font-size: 12px;
}

.map_wrap {
   position: relative;
   width: 100%;
   height: 750px;
}

#category {
   position: absolute;
   top: 10px;
   left: 30%;
   border-radius: 5px;
   border: 1px solid #909090;
   box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);
   background: #fff;
   overflow: hidden;
   z-index: 2;
}

#category li {
   float: left;
   list-style: none;
   width: 80px;
   border-right: 1px solid #acacac;
   padding: 6px 0;
   text-align: center;
   cursor: pointer;
}

#category li.on {
   background: #eee;
}

#category li:hover {
   background: #ffe6e6;
   border-left: 1px solid #acacac;
   margin-left: -1px;
}

#category li:last-child {
   margin-right: 0;
   border-right: 0;
}

#category li span {
   display: block;
   margin: 0 auto 3px;
   width: 27px;
   height: 28px;
}

#category li .bank {
   background-position: -10px 0;
}

#category li .mart {
   background-position: -10px -36px;
}

#category li .pharmacy {
   background-position: -10px -72px;
}

#category li .oil {
   background-position: -10px -108px;
}

#category li .cafe {
   background-position: -10px -144px;
}

#category li .store {
   background-position: -10px -180px;
}

#category li .cctv {
   background-position: -10px -180px;
}

#category li.on .category_bg {
   background-position-x: -46px;
}

#category li.on .category_han {
   background-position-x: -46px;
}

.placeinfo_wrap {
   position: absolute;
   bottom: 28px;
   left: -150px;
   width: 300px;
}

.placeinfo {
   position: relative;
   width: 100%;
   border-radius: 6px;
   border: 1px solid #ccc;
   border-bottom: 2px solid #ddd;
   padding-bottom: 10px;
   background: #fff;
}

.placeinfo:nth-of-type(n) {
   border: 0;
   box-shadow: 0px 1px 2px #888;
}

.placeinfo_wrap .after {
   content: '';
   position: relative;
   margin-left: -12px;
   left: 50%;
   width: 22px;
   height: 12px;
   background:
      url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
}

.placeinfo a, .placeinfo a:hover, .placeinfo a:active {
   color: #fff;
   text-decoration: none;
}

.placeinfo a, .placeinfo span {
   display: block;
   text-overflow: ellipsis;
   overflow: hidden;
   white-space: nowrap;
}

.placeinfo span {
   margin: 5px 5px 0 5px;
   cursor: default;
   font-size: 13px;
}

.placeinfo .title {
   font-weight: bold;
   font-size: 14px;
   border-radius: 6px 6px 0 0;
   margin: -1px -1px 0 -1px;
   padding: 10px;
   color: #fff;
   background: #d95050;
   background: #d95050
      url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png)
      no-repeat right 14px center;
}

.placeinfo .tel {
   color: #0f7833;
}

.placeinfo .jibun {
   color: #999;
   font-size: 11px;
   margin-top: 0;
}

#select {
   margin-top: 500px;
}

.navicon {
   height: 25px;
   width: 80px;
   transition: transform 0.5s;
   z-index: 10000;
   position: fixed;
   cursor: pointer;
   top: 10%;
   left: 85%;
   background-color: #FBEFF8;
   border-radius: 5px;
}

.slidemenu {
   top: 0px;
   position: fixed;
   height: 100%;
   width: 20%;
   background-color: #F5F6CE;
   right: -25%;
   z-index: 10000;
}

.slidemenuinner {
   position: relative;
   top: 5%;
   height: 100%;
   width: 100%;
   color: #fff;
   font-size: 12px;
}

.menulink {
   height: 10%;
   border-top: 0.5px solid #0d3c74;
   border-bottom: 0.5px solid #0d3c74;
   padding: 10px 0px 10px 0px;
   color: black;
   margin-left: 10px;
}

.menulink:hover {
   background: white;
}

/* The Modal (background) */
.modal {
   display: none; /* Hidden by default */
   position: fixed; /* Stay in place */
   z-index: 1; /* Sit on top */
   left: 0;
   top: 0;
   width: 100%; /* Full width */
   height: 100%; /* Full height */
   overflow: auto; /* Enable scroll if needed */
   background-color: rgb(0, 0, 0); /* Fallback color */
   background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content {
   background-color: #fefefe;
   margin: 15% auto; /* 15% from the top and centered */
   padding: 20px;
   border: 1px solid #888;
   width: 30%; /* Could be more or less, depending on screen size */
}

.form-control {
   margin-bottom: 20px;
}

.right {
   float: right;
   margin-right: 50px;
   margin-top: 20px;
}

.where {
   display: block;
   margin: 25px 15px;
   font-size: 11px;
   color: #000;
   text-decoration: none;
   font-family: verdana;
   font-style: italic;
}

.filebox input[type="file"] {
   position: absolute;
   width: 1px;
   height: 1px;
   padding: 0;
   margin: -1px;
   overflow: hidden;
   clip: rect(0, 0, 0, 0);
   border: 0;
}

.filebox label {
   display: inline-block;
   padding: .5em .75em;
   color: #999;
   font-size: inherit;
   line-height: normal;
   vertical-align: middle;
   background-color: #fdfdfd;
   cursor: pointer;
   border: 1px solid #ebebeb;
   border-bottom-color: #e2e2e2;
   border-radius: .25em;
}

/* named upload */
.filebox .upload-name {
   display: inline-block;
   padding: .5em .75em;
   font-size: inherit;
   font-family: inherit;
   line-height: normal;
   vertical-align: middle;
   background-color: #f5f5f5;
   border: 1px solid #ebebeb;
   border-bottom-color: #e2e2e2;
   border-radius: .25em;
   -webkit-appearance: none;
   -moz-appearance: none;
   appearance: none;
}

.abso{
   position:absolute;
   top: 95px;
   left: 2%;
   border-radius: 5px;
   z-index:2;
 
}

.filebox.bs3-primary label {
   color: #fff;
   background-color: #337ab7;
   border-color: #2e6da4;
}

/* The Modal (background) */
.modal2 {
   display: none; /* Hidden by default */
   position: fixed; /* Stay in place */
   z-index: 1; /* Sit on top */
   left: 0;
   top: 0;
   width: 100%; /* Full width */
   height: 100%; /* Full height */
   overflow: auto; /* Enable scroll if needed */
   background-color: rgb(0, 0, 0); /* Fallback color */
   background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content2 {
   background-color: #fefefe;
   margin: 15% auto; /* 15% from the top and centered */
   padding: 20px;
   border: 1px solid #888;
   width: 30%; /* Could be more or less, depending on screen size */
} 

#myfood {
   margin-top: 10px;
   font-weight: bold;
   text-align: center;
}

HTML CSSResult
    .list-unstyled {
   padding-left: 0;
   list-style: none;
}

.sun-box {
   clear: both;
   height: 250px;
   position: relative;
}

.sun {
   -moz-animation: sunmove 5.0s ease .1s infinite;
   -webkit-animation: sunmove 5.0s ease .1s infinite;
   animation: sunmove 5.0s ease .1s infinite;
   bottom: 130px;
   left: 0;
   position: absolute;
}

.sun-line {

   -moz-animation: sunlines 15.0s ease .1s infinite;
   -moz-transform-origin: center center;
   -webkit-animation: sunlines 15.0s ease .1s infinite;
   -webkit-transform-origin: center center;
   animation: sunlines 15.0s ease .1s infinite;
   height: 150px;
   left: 50px;
   position: absolute;
   transform-origin: center center;
   width: 150px;
}

.sun-line li {
   background: #7a6021;
   height: 18px;
   position: absolute;
   width: 3px;
}

.sun-line li:nth-child(1) {
   left: 73px;
   top: 0;
}

.sun-line li:nth-child(2) {
   -moz-transform: rotate(45deg);
   -webkit-transform: rotate(45deg);
   left: 115px;
   top: 21px;
   transform: rotate(45deg);
}

.sun-line li:nth-child(3) {
   height: 3px;
   left: 132px;
   top: 73px;
   width: 18px;
}

.sun-line li:nth-child(4) {
   -moz-transform: rotate(135deg); 
   -webkit-transform: rotate(135deg);
   left: 120px;
   top: 110px;
   transform: rotate(135deg);
}

.sun-line li:nth-child(5) {
   left: 73px;
   top: 128px;
}

.sun-line li:nth-child(6) {
   -moz-transform: rotate(45deg);
   -webkit-transform: rotate(45deg);
   left: 21px;
   top: 104px;
   transform: rotate(45deg);
}

.sun-line li:nth-child(7) {
   height: 3px;
   left: 0px;
   top: 73px; 
   width: 18px;
}

.sun-line li:nth-child(8) {
   -moz-transform: rotate(135deg);
   -webkit-transform: rotate(135deg);
   left: 21px;
   top: 20px;
   transform: rotate(135deg);
}

.sun-body {
   background: #f4c042;
   border: 4px solid #7a6021;
   border-radius: 100%;
   height: 90px;
   left: 77px;
   position: absolute;
   top: 27px;
   width: 90px;
}

.sun-eye {
   -moz-animation: suneyes 5s ease .1s infinite;
   -webkit-animation: suneyes 5s ease .1s infinite;
   animation: suneyes 5s ease .1s infinite;
   left: 95px;
   position: absolute;
   top: 80px;
   width: 22px;
}

.sun-eye>span {
   background: #7a6021;
   border-radius: 100%;
   float: left;
   height: 6px;
   width: 6px;
}

.sun-eye>span:nth-child(2) {
   float: right;
}

@-webkit-keyframes suneyes { 
10% {
   left: 95px;
   opacity: 1.0;
}
11%{
left:95px;     
opacity:0;
}
12%{
left:95px;       
opacity:1.0;
}

22%{
left:95px;        
opacity:1.0;
}
23%{
left: 95px;      
opacity:0;
}
24%{
left:95px;   
opacity:1.0;    
}
27%{
left: 95px;
opacity:1.0;
}
28%{
left: 95px;       
opacity: 0;
}

29%{
left: 95px;   
opacity: 1.0;
}
33%{
left: 135px;     
opacity:1.0;
}
45%{
left: 135px;
opacity:1.0;   
}
46%{
left:135px;  
opacity: 0;
}
47%{
left:135px;
opacity: 1.0;
}
50%{
left: 135px;  
opacity: 1.0;
}
51%{
left: 135px;
opacity: 0;
}
52%{
left: 135px;   
opacity: 1.0;
}
55%{
left: 95px;
opacity: 1.0;
}
} 
@keyframes sunlines { 
0% {
   transform: rotate(0deg);
}

99.99% {
   transform: rotate(360deg);
}

100%{
transform: rotate(0deg);
}
}

@-moz-keyframes sunlines { 

0% {
   -moz-transform: rotate(0deg);
   transform: rotate(0deg);
}

99.99% {
   -moz-transform: rotate(360deg);
   transform: rotate(360deg);
}

100%
{
-moz-transform: rotate(0deg);
transform:rotate(0deg);

}
}
@-webkit-keyframes sunlines { 
0% {
   -webkit-transform: rotate(0deg);
   transform: rotate(0deg);
}

99.99% {
   -webkit-transform: rotate(360deg);
   transform: rotate(360deg);
}

100%{
-webkit-transform:rotate(0deg);
transform:rotate(0deg);
}
}

@-webkit-keyframes sunmove { 
0% {
   top: 120px;
}

3%{ 
top:100px;
}
97%{
top:100px;
}
100%{
top:120px;
}
}
@keyframes sunmove { 
0% {
   top: 120px;
}
3%
{
top: 100px;   
}

97%{
top:100px;
}

100%{
top: 120px;
}

}
@-moz-keyframes sunmove { 
0% {
   top: 120px;
}

3%{
top: 100px;  
}
97%{
top: 100px; 
}
100%{
top: 120px;
}
}
.sun-bg {
   background-color: #7a6021;
   height: 60px;
   left: 0;
   position: absolute;
   top: 189px;
   width: 100%;
}
}


</style>
<meta charset="utf-8" />
<title>Kakao 지도 시작하기</title>
</head>
<body>
   <div id="clickLatlng"></div>
   <%
      List<FoodDto> foodList = (List<FoodDto>) request.getAttribute("foodList");
      List<FoodDto> myFoodList = (List<FoodDto>) request.getAttribute("myFoodList");
   %>


   <!-- CCTV , 성범죄자, 식재료 -->
   <div class="map_wrap">
      <div id="map"
         style="width: 100%; height: 100%; margin-top:80px; position: relative; overflow: hidden;"></div>
      <ul id="category">

         <li id="behind" data-order="5"><strong>MAP</strong></li>
         <li id="MT1" data-order="1"><strong>마트</strong></li>
         <li id="AT4" data-order="5"><strong>관광지</strong></li>
         <li id="cctv" data-order="5"><strong>CCTV</strong></li>
         <li id="food" data-order="5"><strong>식재료</strong></li>
         <li id="sc" data-order="5"><strong>안심택배</strong></li>
         <li id="search" data-order="5"><strong>주변친구</strong></li>
         <li id="mask" data-order="5"><strong>MASK</strong></li>
 
      </ul>
   </div>

   <div id="myModal" class="modal">

      <!-- Modal content -->
      <div class="modal-content">
         <p style="text-align: center;">
            <span style="font-size: 14pt;"><b><span
                  style="font-size: 15pt;">식재료를 등록해주세요</span></b></span>
         </p>
         <form action="/SINGLE/food/foodUpload.do" method="POST"
            enctype="multipart/form-data">
            <input type="hidden" name="x" value="" />
            <input type="hidden" name="y" value="" />
            <input type="hidden" name="member_code" value="${member_code }">

            <div class="wrapper">
               <p>식재료 이름</p>
               <input type="text" class="form-control" name="food_name" />
               <p>내용</p>

               <textarea class="form-control" name="food_content"></textarea>
               <p>이미지</p>
               <div class="filebox bs3-primary">
                  <input class="upload-name" value="파일선택" disabled="disabled">
                  <label for="ex_filename">업로드</label> <input type="file"
                     id="ex_filename" class="upload-hidden" name="file">
               </div>
               <p></p> 
               <button class="btn btn-lg btn-info btn-block" type="submit">등록</button>
            </div>
         </form>
      </div>
   </div>

   <%
       if(myFoodList.isEmpty()){
    %>
    
   <%
       }else{
    %>
   <div class="navicon">
      <div class="sun-box" style="margin-top: -100px;">
         <div class="sun">

            <div class="sun-line">

               <ul class="list-unstyled">
                  <li></li>
                  <li></li>
                  <li></li>
                  <li></li>
                  <li></li>
                  <li></li>
                  <li></li>
                  <li></li>
               </ul>
            </div>

            <div class="sun-body"></div>
               
            <div class="sun-eye">
               <span></span><span></span>
            </div>
            <div style="border: 2px solid black; background-color: yellow;">MY
               FOOD</div>
         </div>

      </div>
   </div>
   <div class="slidemenu">
      <h4 id="myfood">내가 등록한 식재료</h4>
      <div class="slidemenuinner"></div>
   </div>
   <% 
       }
   %>
      <div class="input-group input-group col col-lg-3 abso">
         <input type="text" class="form-control col" id="myLocation">
            <div class="input-group-append">
               <button type="button" class="btn btn-info" onclick="searchLocation();">주소로 검색하기</button>
            </div> 
      </div>

   <script type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a358c4a162c62bd5de53bab3619c7a06&libraries=services"></script>
   <script>
   

   var geocoder = new kakao.maps.services.Geocoder();

   var xy = new kakao.maps.LatLng(${info.MPROFILE_LATITUDE }, ${info.MPROFILE_LONGITUDE }); 
    
   var callback = function(result, status) {
          var my_address = result[0].address.address_name;
           
         $('#cctv').click(function(){
            location.href="/SINGLE/map/cctv.do?my_address="+my_address;
         }); 
   };
   
   geocoder.coord2Address(xy.getLng(), xy.getLat(), callback);
    
   
   $(document).ready(function () {
        $(".navicon").mouseenter(function () {
            $(this).animate({
                left: "65%"
            }, 400);
            $('.slidemenu').animate({
                left: "80%"
            }, 400);
        }).click(function () {
            $(this).css({
                'z-index': '10000',
                'transform': 'translateX(0px)'
            });
            $(this).animate({
                left: "85%"
            }, 200);
            
            $('.slidemenu').animate({
                left: "120%"
            }, 200);
        });
    })
    
   $(document).ready(function(){
        var fileTarget = $('.filebox .upload-hidden');

          fileTarget.on('change', function(){   
              if(window.FileReader){
                  var filename = $(this)[0].files[0].name;
              } else {
                  var filename = $(this).val().split('/').pop().split('\\').pop();
              }

              $(this).siblings('.upload-name').val(filename);
          });
      }); 

   
   
    
      var c1 = null;
   
      // 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
      var placeOverlay = new kakao.maps.CustomOverlay({
         zIndex : 1
      }), contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
      markers = [], // 마커를 담을 배열입니다
      currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
      
      var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
      mapOption = {
         center : new kakao.maps.LatLng(${info.MPROFILE_LATITUDE }, ${info.MPROFILE_LONGITUDE }), // 지도의 중심좌표
         level : 5
      // 지도의 확대 레벨
      };

      // 지도를 생성합니다    
      var map = new kakao.maps.Map(mapContainer, mapOption);
       
      map.setZoomable(false);
      
      // 지도에 idle 이벤트를 등록합니다
      kakao.maps.event.addListener(map, 'idle', searchPlaces);
      
      // 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
      contentNode.className = 'placeinfo_wrap';

      // 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
      // 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다 
      addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
      addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);
      
      // 커스텀 오버레이 컨텐츠를 설정합니다
      placeOverlay.setContent(contentNode);

      // 각 카테고리에 클릭 이벤트를 등록합니다 
      addCategoryClickEvent();

      // 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다 
      function addEventHandle(target, type, callback) {
         if (target.addEventListener) {
            target.addEventListener(type, callback);
         } else {
            target.attachEvent('on' + type, callback);
         }
      }

      // 카테고리 검색을 요청하는 함수입니다
      function searchPlaces() {
         if (!currCategory) {
            return;
         }

         // 커스텀 오버레이를 숨깁니다 
         placeOverlay.setMap(null);

         // 지도에 표시되고 있는 마커를 제거합니다
         removeMarker();
  
         ps.categorySearch(currCategory, placesSearchCB, {
            useMapBounds : true
         });
      } 
 
      // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
      function placesSearchCB(data, status, pagination) {
         if (status === kakao.maps.services.Status.OK) {

            // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
            displayPlaces(data);
         } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
            // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요

         } else if (status === kakao.maps.services.Status.ERROR) {
            // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요

         }
      }

      // 지도에 마커를 표출하는 함수입니다 
      function displayPlaces(places) {

         // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
         // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
         var order = document.getElementById(currCategory).getAttribute('data-order');

         for (var i = 0; i < places.length; i++) {

            // 마커를 생성하고 지도에 표시합니다
            var marker = addMarker(new kakao.maps.LatLng(places[i].y,
                  places[i].x), order);
            
            // 마커와 검색결과 항목을 클릭 했을 때
            // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
            (function(marker, place) {
               kakao.maps.event.addListener(marker, 'click', function() {
                  displayPlaceInfo(place);
               });
            })(marker, places[i]);
         }
      }

      // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
      function addMarker(position, order) { 
         var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
         imageSize = new kakao.maps.Size(27, 28), // 마커 이미지의 크기
         imgOptions = {
            spriteSize : new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(46, (order * 36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset : new kakao.maps.Point(11, 28)
         
         
         // 마커 좌표에 일치시킬 이미지 내에서의 좌표 
         }, markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
               imgOptions), marker = new kakao.maps.Marker({
            position : position, // 마커의 위치
            image : markerImage 
         });

         marker.setMap(map); // 지도 위에 마커를 표출합니다
         markers.push(marker); // 배열에 생성된 마커를 추가합니다

         return marker;
      }

      // 지도 위에 표시되고 있는 마커를 모두 제거합니다
      function removeMarker() {
         for (var i = 0; i < markers.length; i++) {
            markers[i].setMap(null);
         }
         markers = [];
      }

      // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
      function displayPlaceInfo(place) {
         var content = '<div class="placeinfo">'
               + '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">'
               + place.place_name + '</a>';

         if (place.road_address_name) {
            content += '    <span title="' + place.road_address_name + '">'
                  + place.road_address_name
                  + '</span>'
                  + '  <span class="jibun" title="' + place.address_name + '">(지번 : '
                  + place.address_name + ')</span>';
         } else {
            content += '    <span title="' + place.address_name + '">'
                  + place.address_name + '</span>';
         }

         content += '    <span class="tel">' + place.phone + '</span>'
               + '</div>' + '<div class="after"></div>';

         contentNode.innerHTML = content;
         placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
         placeOverlay.setMap(map);
      }

      // 각 카테고리에 클릭 이벤트를 등록합니다
      function addCategoryClickEvent() {
         var category = document.getElementById('category'), children = category.children;

         for (var i = 0; i < children.length; i++) {
            children[i].onclick = onClickCategory;
         }
      }
      
 
      // 카테고리를 클릭했을 때 호출되는 함수입니다
      function onClickCategory() {
         var id = this.id, className = this.className;

         placeOverlay.setMap(null);

         if (className === 'on') {
            currCategory = '';
            changeCategoryClass();
            removeMarker();
         } else {
            currCategory = id;
            changeCategoryClass(this);
            searchPlaces();
         }
      }

      // 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
      function changeCategoryClass(el) {  
         var category = document.getElementById('category'), children = category.children, i;

         for (i = 0; i < children.length; i++) {
            children[i].className = '';
         }
         
         if (el) {
            el.className = 'on'; 
         }
      }
      
      var marker = new kakao.maps.Marker({
          // 지도 중심좌표에 마커를 생성합니다 
          position: map.getCenter() 
      }); 
      // 지도에 마커를 표시합니다
      marker.setMap(map);

      // 지도에 클릭 이벤트를 등록합니다
      // 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
      

      
      kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
          
          // 클릭한 위도, 경도 정보를 가져옵니다 
          var latlng = mouseEvent.latLng;
          
          // 마커 위치를 클릭한 위치로 옮깁니다
          marker.setPosition(latlng);
          
          
          x = latlng.getLat();
          y = latlng.getLng();
         
          document.getElementsByName("x")[0].value = x;
          document.getElementsByName("y")[0].value = y;
           
      });

      
   
      // 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다 
      var iwContent2 = '<div id="modal" style="padding:5px;">식재료 등록하러 가기</div>',
          iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다 
            
      var infowindows = new kakao.maps.InfoWindow({ 
          content : iwContent2,
          removable : iwRemoveable
         });
          
      kakao.maps.event.addListener(marker, 'click', function() { 
            // 마커 위에 인포윈도우를 표시합니다
            infowindows.open(map, marker);  
      }); 
       
       $(document).on('click', '#modal', function() {
          $('#myModal').show(); 
       });
       
       $(document).on('click', '#modal2', function() {
          $('#myModal2').show(); 
       });
   
       <%
       for (int i = 0; i < foodList.size(); i++) {
       %>  
      
       
        var imageSrc = '/SINGLE/resources/images/uploadImg/<%=foodList.get(i).getFood_image_name()%>', // 마커이미지의 주소입니다    
        imageSize = new kakao.maps.Size(50, 50), // 마커이미지의 크기입니다
        imageOption = {offset: new kakao.maps.Point(10, 10)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
      
        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption), 
        markerPosition = new kakao.maps.LatLng(<%=foodList.get(i).getFood_x()%>, <%=foodList.get(i).getFood_y()%>);
        
        var markerPosition  = new kakao.maps.LatLng(<%=foodList.get(i).getFood_x()%>, <%=foodList.get(i).getFood_y()%>); 
        
        markers = new kakao.maps.Marker({ 
            position: markerPosition,
            image : markerImage,
            clickable: true
        });
        
        var circle = new kakao.maps.Circle({
            center : new kakao.maps.LatLng(<%=foodList.get(i).getFood_x()%>, <%=foodList.get(i).getFood_y()%>),  // 원의 중심좌표 입니다 
            radius: 100, // 미터 단위의 원의 반지름입니다 
            strokeWeight: 5, // 선의 두께입니다 
            strokeColor: 'blue', // 선의 색깔입니다
            strokeOpacity: 0.5, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
            strokeStyle: 'solid', // 선의 스타일 입니다
            fillColor: 'yellow', // 채우기 색깔입니다
            fillOpacity: 0.5  // 채우기 불투명도 입니다   
        });  

        circle.setMap(map); 
        markers.setMap(map); 

        var geocoder = new kakao.maps.services.Geocoder();

        var callback2 = function(result, status) {
            if (status === kakao.maps.services.Status.OK) {
               
                console.log('지역 명칭 : ' + result.address_name);
            }
        };
 
        geocoder.coord2RegionCode(<%=foodList.get(i).getFood_x()%>, <%=foodList.get(i).getFood_y()%>, callback2);
      
       
        iwContent = '<div class="fooddetail">'
        +'<div class="text-center font-weight-bold" id="font">식품상세보기</div>'
        +'<table class="table">'
        +'<tr><td>식재료이름</td><td><%=foodList.get(i).getFood_name()%></td></tr>'
        +'<tr><td>내용</td><td><%=foodList.get(i).getFood_content()%></td></tr>'
        +'<tr><td>올린사람</td><td><%=foodList.get(i).getMember_nickname()%></td></tr>'
        +'<tr><td class="text-center" colspan="2">'  
        +'<button id="one-note" class="btn btn-info">쪽지보내기</button>'
        +'&nbsp;&nbsp;&nbsp;<button id="one-to-one" class="btn btn-info">채팅하기</button>'
        +'</td></tr><table></div>'
           +'<input type="hidden" id="TO_MEMBER_NICKNAME" value="<%=foodList.get(i).getMember_nickname()%>">'
           +'<input type="hidden" id="TO_MEMBER_CODE" value="<%=foodList.get(i).getMember_code()%>">',
            
        iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
         
        var infowindow = new kakao.maps.InfoWindow({   
            content : iwContent,
            removable : iwRemoveable
            
        });


        
        kakao.maps.event.addListener(markers, 'click', makeClickListener(map, markers, infowindow));
   
        
        function makeClickListener(map, markers, infowindow) {
           return function() {
           infowindow.open(map, markers);
           };
           
           
           }
        <% 
       }
       %>
       

       

       
       function searchDetailAddrFromCoords(coords, callback) {
           // 좌표로 법정동 상세 주소 정보를 요청합니다
           geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
       }

       // 인포윈도우를 닫는 클로저를 만드는 함수입니다 
       function makeOutListener(infowindow) {
           return function() {
               infowindow.close(); 
           };
       } 
       

      
   
      //팝업 Close 기능
      function close_pop(flag) {
         $('#myModal').hide();
      };
      
      
      //팝업 Close 기능
      function close_pop(flag) {
         $('#myModal2').hide();
      };
      

      
      
       $(document).on('click', '#one-note', function() {
         var url = "/SINGLE/views/note/sendnote.jsp";
         var title = "";
         var prop = "top=200px,left=600px,width=580px,height=620px";
         window.open(url, title, prop);
       });   
       
       $(document).on('click', '#one-to-one', function() {
          
          var MY_MEMBER_CODE = $("#MY_MEMBER_CODE").val();
          
          $.ajax({
             type: "POST",
             url: "/SINGLE/chat/oneChatRoompage.do",
             data: {
                MY_MEMBER_CODE : MY_MEMBER_CODE,
                TO_MEMBER_CODE : $("#TO_MEMBER_CODE").val()
             },
             dataType: "JSON",
             success: function(msg) {
                
                if(msg.result > 0) {
                   alert("기존 채팅방을 불러옵니다.");
                   $("#CHATROOM_CODE").val(msg.CHATROOM_CODE);
                } else {
                   alert("채팅방을 새로 생성합니다.");
                   $("#CHATROOM_CODE").val(msg.CHATROOM_CODE);
                }
                
                
                // 채팅방 팝업창 띄우기
                var url = "/SINGLE/views/chat/chatroom.jsp";
                 var title = "";
                 var prop = "top=150px,left=600px,width=500px,height=670px";
                 window.open(url, title, prop);
             }
          });
      });
      
       
       
      
      <%
      if(myFoodList.isEmpty()){
         
      }else{
         
	      for (int i = 0; i < myFoodList.size(); i++) {
	      %>
	      
	      var url = "/SINGLE/food/myFoodDelete.do?marker_code="+<%=myFoodList.get(i).getMarker_code()%>;
	      console.log(url);   
	      
	         $('.slidemenuinner').append('<div class="menulink">'
	            +'<img src="/SINGLE/resources/images/uploadImg/<%=myFoodList.get(i).getFood_image_name()%>" width="60" height="60">'
	            + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a style="font-size:15px; font-weight:bold;"><%=myFoodList.get(i).getFood_name()%></a>'  
	            +'<div class="right"><button id="update" style="width:40pt; font-size:11px; height:18pt;" class="btn btn-success">수정</button>&nbsp;&nbsp;&nbsp;<button style="width:40pt; font-size:11px; height:18pt;" class="btn btn-danger" onClick="location.href=url">삭제</button></div>'
	            +'</div>' 
	            +'<input type="hidden" id="MARKER_CODE" value="<%=myFoodList.get(i).getMarker_code()%>">' 
	            +'<input type="hidden" id="IMAGE_NAME" value="<%=myFoodList.get(i).getFood_image_name()%>">'
	            +'<input type="hidden" id="FOOD_NAME" value="<%=myFoodList.get(i).getFood_name()%>">'
	            +'<input type="hidden" id="FOOD_CONTENT" value="<%=myFoodList.get(i).getFood_content()%>">');
	      <%
	         }
      }
      %>
      $(document).on('click', '#update', function() {
         var url = "/SINGLE/views/map/foodUpdate.jsp";
         var title = "";
         var prop = "top=200px,left=600px,width=580px,height=620px";
         window.open(url, title, prop);
      });
       

      

      $('#behind').click(function() {
         location.href = "/SINGLE/map/map.do";
      });

      $('#food').click(function() {
         location.href = "/SINGLE/food/foodList.do";
      });
      $('#sc').click(function() {
         location.href = "/SINGLE/map/sc.do";
      });

      $('#search').click(function() {
         location.href = "/SINGLE/map/search.do";
      });
      $('#mask').click(function(){
         location.href="/SINGLE/map/mask.do";
      });  
      
      
       // 장소 검색 객체 생성
      var ps = new kakao.maps.services.Places();
       
       $(function() {
          
          // 주소로 검색하기
          $("#myLocation").keyup(function(e) {
             e.preventDefault();
             
             var loc = $("#myLocation").val();
             
             var code = e.keyCode ? e.keyCode : e.which;
             
             if(code == 13) {   // 엔터키
                searchLocation();
                ps.keywordSearch(loc, placesSearchCB);
             }
          });
       });
      
      function searchLocation() {
         var loc = $("#myLocation").val();
         ps.keywordSearch(loc, placesSearchCB);
      }
      
      // 키워드 검색 완료 시 호출되는 콜백함수
      function placesSearchCB(data, status, pagination) {
         if(status === kakao.maps.services.Status.OK) {
            
            // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기 위해 객체에 좌표 추가
            var bounds = new kakao.maps.LatLngBounds();
            
            for(var i=0; i<data.length; i++) {
               bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
            }
            
            // 검색된 장소 위치를 기준으로 지도 범위 재설정
            map.setBounds(bounds);
         }
      }   
   </script>
</body>
</html>