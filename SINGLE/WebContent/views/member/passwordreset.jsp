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

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>

<script type="text/javascript" src="../resources/js/RSA/rsa.js"></script>
<script type="text/javascript" src="../resources/js/RSA/jsbn.js"></script>
<script type="text/javascript" src="../resources/js/RSA/prng4.js"></script>
<script type="text/javascript" src="../resources/js/RSA/rng.js"></script>

<script type="text/javascript">
	
	$(function() {
		var rsa = new RSAKey();
		rsa.setPublic("${modulus}", "${exponent}");
		
		$("#SUBMIT").attr("disabled", "disabled");
		
		if($("#MEMBER_EMAIL").val() != null && $("#MEMBER_EMAIL").val() != ""){
			
			//비밀번호 체크
			$("#MEMBER_PASSWORD,#PW_CONFIRM").keyup(function() {
				var MEMBER_PASSWORD = $("#MEMBER_PASSWORD").val();
				var PW_CONFIRM = $("#PW_CONFIRM").val();
				
				if(MEMBER_PASSWORD != "" && PW_CONFIRM != "") {
					
					if(MEMBER_PASSWORD != PW_CONFIRM) {
						$("#pw_check").text("비밀번호가 일치하지 않습니다.");
						$("#pw_check").attr("style", "color:red");
					} else {
						$("#SUBMIT").removeAttr("disabled");
						
						$("#pw_check").text("비밀번호가 일치합니다.");
						$("#pw_check").attr("style", "color:green");
					}
				}
			});
		}
		
		// 입력된 값들을 서버에 전송
		$("#resetForm").submit(function(e) {
			e.preventDefault();
			
			var MEMBER_PASSWORD = $(this).find("#MEMBER_PASSWORD").val();
	
			// 사용자가 입력한 form에서 hidden form으로 셋팅
			// 비밀번호 암호화
			$("#resethiddenForm input[name='MEMBER_PASSWORD']").val(rsa.encrypt(MEMBER_PASSWORD));
						
			$("#resethiddenForm").submit();
		});
	});

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>

	<div id="container">

		<h1>비밀번호 재설정</h1>
		
		<h4 style="color: gray;">
			비밀번호를 다시 설정합니다. 비밀번호는 적어도 하나의 소문자와 숫자를 포함해야 하며, 최소 7자 이상 되어야 합니다.
		</h4>
		
		<div>
			<form action="/SINGLE/member/pwReset.do" method="post" id="resetForm">
				
				<div>
					<label for="MEMBER_PASSWORD">새로운 비밀번호</label>
				</div>
				<div>
					<input type="text" name="MEMBER_PASSWORD" id="MEMBER_PASSWORD" autocomplete="off" required="required">
				</div>				
				
				<div>
					<label for="PW_CONFIRM">비밀번호 확인</label>
				</div>
				<div>
					<input type="text" id="PW_CONFIRM" autocomplete="off" required="required">
				</div>
				<div class="check_font" id="pw_check"></div><!-- 경고문이 들어갈 공간 -->
				
				<div>
					<input type="submit" id="SUBMIT" value="완료">
				</div>
			</form>
		</div>
	</div>
	
	<form action="/SINGLE/member/pwReset.do" method="post" id="resethiddenForm">
		<input type="hidden" name="MEMBER_PASSWORD">
	</form>


<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->

</body>
</html>