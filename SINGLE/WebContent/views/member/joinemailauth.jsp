<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- START :: CSS -->
<link href="/SINGLE/resources/css/master.css" rel="stylesheet" type="text/css">
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

	$(function() {
		
		$("#inputAuthNum").focus();
		
		$("#emailAuth").submit(function(e) {
			e.preventDefault();
			
			var authNum = $(opener.document).find("#emailAuthHiddenForm input[name='authNum']").val();
			var inputAuthNum = $("#inputAuthNum").val();
			
			if(authNum == inputAuthNum) {
				alert("이메일 인증을 성공하였습니다.");
				$(opener.document).find("#email_check").text("이메일 인증을 성공하였습니다.");
				$(opener.document).find("#email_check").attr("style", "color:green");
				
				$(opener.document).find("#email_auth").remove();
				$(opener.document).find("#MEMBER_EMAIL").attr("disabled", "disabled");
				
				$(opener.document).find("#MEMBER_PASSWORD").focus();

				close();
			} else {
				alert("인증번호가 일치하지 않습니다.");
			}
		});
	});
	
</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>

	<form action="#" id="emailAuth">
		<div>
			<label for="inputAuthNum">인증번호</label>
		</div>
		<div>
			<input type="text" id="inputAuthNum" name="inputAuthNum" placeholder="인증번호를 입력해주세요.">
		</div>
		<div>
			<input type="submit" value="인증하기">
		</div>
	</form>

</body>
</html>