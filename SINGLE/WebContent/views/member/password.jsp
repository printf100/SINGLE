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

<script type="text/javascript" src="../resources/js/RSA/rsa.js"></script>
<script type="text/javascript" src="../resources/js/RSA/jsbn.js"></script>
<script type="text/javascript" src="../resources/js/RSA/prng4.js"></script>
<script type="text/javascript" src="../resources/js/RSA/rng.js"></script>

<script type="text/javascript">

	$(function() {
		var rsa = new RSAKey();
		rsa.setPublic("${modulus}", "${exponent}");
		
		$("#SUBMIT").attr("disabled", "disabled");
			
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
	
		// 입력된 값들을 서버에 전송
		$("#resetForm").submit(function(e) {
			e.preventDefault();
			
			var ORIGINAL_PASSWORD = $(this).find("#ORIGINAL_PASSWORD").val();
			var MEMBER_PASSWORD = $(this).find("#MEMBER_PASSWORD").val();
	
			// 사용자가 입력한 form에서 hidden form으로 셋팅
			// 비밀번호 암호화
			$("#resethiddenForm input[name='ORIGINAL_PASSWORD']").val(rsa.encrypt(ORIGINAL_PASSWORD));
			$("#resethiddenForm input[name='MEMBER_PASSWORD']").val(rsa.encrypt(MEMBER_PASSWORD));
						
			$("#resethiddenForm").submit();
		});
	});
	
</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>

	<h1>비밀번호</h1>
	
	<div id="container">
		<div id="side-menu">
			<div>
				<a href="/SINGLE/member/profilepage.do">프로필 정보</a>
			</div>
			<div>
				<a href="/SINGLE/member/infopage.do">회원 정보</a>
			</div>
			<!-- 사이트로 가입한 회원일 때만 보여주기 -->
			<c:if test="${not empty sessionLoginMember }">
				<div>
					<a href="/SINGLE/member/pwpage.do">비밀번호</a>
				</div>
			</c:if>
		</div>

		<div id="mypage-detail">
			<form action="/SINGLE/member/pwReset.do" method="post" id="resetForm">
				<input type="hidden" name="MEMBER_CODE" value="${sessionLoginMember.MEMBER_CODE }">
				<div>
					<label for="ORIGINAL_PASSWORD">현재 비밀번호</label>
				</div>
				<div>
					<input type="password" name="ORIGINAL_PASSWORD" id="ORIGINAL_PASSWORD" autocomplete="off" required="required">
				</div>
				<div>
					<p style="color: gray; font-size: 9pt;">기존 비밀번호를 잊으셨나요?
					<a href="/SINGLE/member/pwResetpage.do" style="color: blue; font-size: 8pt;">비밀번호 재설정</a>
				</div>
				
				<div>
					<label for="MEMBER_PASSWORD">새로운 비밀번호</label>
				</div>
				<div>
					<input type="password" name="MEMBER_PASSWORD" id="MEMBER_PASSWORD" autocomplete="off" required="required">
				</div>				
				
				<div>
					<label for="PW_CONFIRM">비밀번호 확인</label>
				</div>
				<div>
					<input type="password" id="PW_CONFIRM" autocomplete="off" required="required">
				</div>
				<div class="check_font" id="pw_check"></div><!-- 경고문이 들어갈 공간 -->
				
				<div>
					<input type="submit" id="SUBMIT" value="비밀번호 변경">
				</div>
			</form>
		</div>
	</div>
	
	<form action="/SINGLE/member/pwReset.do" method="post" id="resethiddenForm">
		<input type="hidden" name="MEMBER_PASSWORD">
		<input type="hidden" name="ORIGINAL_PASSWORD">
	</form>

<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->

</body>
</html>