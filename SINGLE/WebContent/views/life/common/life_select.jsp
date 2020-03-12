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


    .title{
        font-size: 45px;
        line-height: 30px;
        font-weight: ligher;
    }
    
    .innertext{
        font-weight: bold;
        color:#0000CD;
    }
    
    .sub_title{
        color: gray;
        font-size: 17px;
    }
    
    #box{
        height: 500px;
    }
    
    .cleaning{
        float: left;
    }
    
    .laundry{
        float: right;
    }
    
    .cleaning{
        position: absolute; 
    }

    .laundry{
        position: relative;
    }
    



    #img2{
        position: relative;
        display: inline-block;
        background-color: black;
        opacity: 0;
        transition:all .6s ease-in-out;
        -webkit-transition:all .6s ease-in-out;
        -moz-transition:all .6s ease-in-out;
        -ms-transition:all .6s ease-in-out;
        -o-transition:all .6s ease-in-out;
        cursor: pointer;
    }

    #wash_text1 {
    
        color:white;
        font-size: 30pt;
        margin-top: 50px;
        margin-left: 80px;
    }

    #wash_text2{

        color:grey;
        margin-left: 80px;
        font-size : 12pt;
    }

    #wash_text3{

        color:grey;
        margin-left: 80px;
        margin-top: 100px;
        font-size : 12pt;
    }



    #img2:hover {opacity: 0.8;}

    #img2:hover img
    {
    transition:all 1.2s ease-in-out;
    -webkit-transition:all 1.2s ease-in-out;
    -moz-transition:all 1.2s ease-in-out;
    -ms-transition:all 1.2s ease-in-out;
    -o-transition:all 1.2s ease-in-out;
    }

    #wash2_text1 {
    
        color:white;
        font-size: 30pt;
        margin-top: 50px;
        margin-left: 80px;
    }

    #wash2_text2{

        color:grey;
        margin-left: 80px;
        font-size : 12pt;
    }

    #wash2_text3{

        color:grey;
        margin-left: 80px;
        margin-top: 100px;
        font-size : 12pt;
    }

    #img4{
        margin-left:5.8%;
        position: absolute;
        display: inline-block;
        background-color: black;
        opacity: 0;
        transition:all .6s ease-in-out;
        -webkit-transition:all .6s ease-in-out;
        -moz-transition:all .6s ease-in-out;
        -ms-transition:all .6s ease-in-out;
        -o-transition:all .6s ease-in-out;
        cursor: pointer; 
    }

    #img4:hover {opacity: 0.8;}

    #img4:hover img
    {
    transition:all 1.2s ease-in-out;
    -webkit-transition:all 1.2s ease-in-out;
    -moz-transition:all 1.2s ease-in-out;
    -ms-transition:all 1.2s ease-in-out;
    -o-transition:all 1.2s ease-in-out;
    }
	
</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">


	$(function() {
		//청소예약 
		$("#img2").click(function(){
			location.href="/SINGLE/life/clean/cleanpage.do";
		})
		//픽업예약 
		$("#img4").click(function(){
			location.href="/SINGLE/life/wash/washpage.do";
		})
	});
	
	
</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>
	
	 <div class="container">
   
      <div style="margin-top: 30px;">
         <!-- TEXT AREA / BUTTON AREA-->      
         <p class="title">혼자 살면 제일 귀찮은 집안일</p>
         <p class="title">놀랍도록 간편한 <span class="innertext">예약 서비스 </span>를 받을 수 있다는 사실</p><br/>
         <p class="sub_title">전문가의 손길을 클릭 몇 번으로 받아보세요. 빨래? 가사도우미? 한 번 둘러볼까요? </p>
            
         <br>
         
         <div class="cleaning">
               <img id="img1" src="${pageContext.request.contextPath}/resources/images/clean/cleaning.jpg" width="500px" height="300px">
         </div>
         <div id="img2" style="width:500px; height:300px;">
            <p id="wash_text1">청소 예약하기</p>
            <p id="wash_text2">청소 예약 서비스를 이용해보세요</p>
            <p id="wash_text3">담당자 : 안재기 TEL ) 010 - 1234 -1234</p>
        </div>
         
         <div class="laundry">
               <img id="img3" src="${pageContext.request.contextPath}/resources/images/wash/laundry.jpg" width="500px" height="300px">
         </div>
         <div id="img4" style="width:500px; height:300px;"> 
            <p id ="wash2_text1">빨래 예약하기</p>
            <p id="wash2_text2">빨래 예약 서비스를 이용해보세요</p>
            <p id="wash2_text3">담당자 : 안재기 TEL ) 010 - 1234 -1234</p>
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