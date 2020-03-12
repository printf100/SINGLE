<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

	.company-info {
	    font-size: 15px;
	    color: #333333;
	    line-height: 1.7em;
	    position: relative;
	    bottom: auto;
	}
	
	.company-info p {
	    padding-bottom: 2%;
	}

</style>

</head>
<body>

	<div class="jumbotron text-center main company-info" style="margin-bottom:0">
		<p class="address">
            <span style="font-size: 20pt;"><strong>(주) SINGLE</strong></span>
            <br>
            <span>서울특별시 강남구 강남구 테헤란로14길 6</span>
        </p>
        <p class="contact">
            <span>전자금융분쟁처리</span>
            <br>
            <span>대표전화 : 1544-9970</span>
            <br>
            <span class="link-mail">대표메일 : single@single.com
            </span>
        </p>
	</div>

</body>
</html>