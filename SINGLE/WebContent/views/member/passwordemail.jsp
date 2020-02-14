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
<title>Insert title here</title>

<!-- START :: CSS -->
<style type="text/css">

	#container {
		height: 100%;
	}
	
	#side-menu {
		position: relative;
		float: left;
		border: 1px solid green;
	}
	
	#mypage-detail {
		position: relative;
		margin-left: 150px;
	}

</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

	$(function() {
		$("#email_auth").attr("disabled", "disabled");
		
		// 이메일 정규식
		var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;	
		
		// 이메일 체크
		$("#CONFIRM_EMAIL").keyup(function() {
			
			if($("#CONFIRM_EMAIL").val() != null && $("#CONFIRM_EMAIL").val() != ""){
				
				// 이메일 형식인지 체크
				if(regExp.test($("#CONFIRM_EMAIL").val())) {
					$("#email_auth").removeAttr("disabled");
					$("#email_check").text("");
				
				} else {
					$("#email_auth").attr("disabled", "disabled");
					
					$("#email_check").text("이메일 형식이 아닙니다.");
					$("#email_check").attr("style", "color:red");
				}
			}
		});
	});

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>
	
	<div id="container">

		<h1>비밀번호 찾기</h1>
		
		<h4 style="color: gray;">
			비밀번호를 재설정 할 이메일을 입력하세요. 자세한 안내가 담긴 메일을 보내드리겠습니다.
		</h4>
		
		<div>
			<form action="/SINGLE/member/pwResetEmail.do" method="post">
				<input type="hidden" name="MEMBER_NAME" value="${sessionLoginMember.MEMBER_NAME }">
				
				<div>
					<label for="CONFIRM_EMAIL">비밀번호를 재설정 할 이메일</label>
				</div>
				<div>
					<input type="text" id="CONFIRM_EMAIL" name="CONFIRM_EMAIL" placeholder="example@example.com" autofocus autocomplete="off" required="required" />
				</div>
				<div class="check_font" id="email_check"></div><!-- 경고문이 들어갈 공간 -->
				<div>
			    	<input type="submit" value="비밀번호 재설정 메일 보내기" >
				</div>
			</form>
		</div>
	</div>


<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->

</body>
</html>