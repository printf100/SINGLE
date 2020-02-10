<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<!-- javaScript library load -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>

<script type="text/javascript" src="resources/js/RSA/rsa.js"></script>
<script type="text/javascript" src="resources/js/RSA/jsbn.js"></script>
<script type="text/javascript" src="resources/js/RSA/prng4.js"></script>
<script type="text/javascript" src="resources/js/RSA/rng.js"></script>

	<script type="text/javascript">

		$(function() {
			var rsa = new RSAKey();
			rsa.setPublic("${modulus}", "${exponent}");

			$("#SUBMIT").attr("disabled", "disabled");
			
			$("#USERID").blur(function() {
			
				if($("#USERID").val() == null || $("#USERID").val() == "") {
					$("#id_check").text("필수 정보입니다.");
					$("#id_check").attr("style", "color:red");
				}
				
				$.ajax({
					
					type: "POST",
					url: "/Basic_Board_Project/UserController?action=idCheck",
					data: { USERID : $("#USERID").val() },
					datatype: "JSON",
					
					success: function(args) {
						var res = JSON.parse(args).result;
						
						if(res == 1) {
							$("#id_check").text("이미 사용중인 아이디입니다.");
							$("#id_check").attr("style", "color:red");
							
							$("#SUBMIT").attr("disabled", "disabled");
						} else {
							$("#id_check").text("사용 가능한 아이디입니다.");
							$("#id_check").attr("style", "color:blue");
							
							$("#SUBMIT").removeAttr("disabled");
						}
					},
					
					error : function(request, status, error) {
						alert("통신 실패");
						alert("code : " + request.status + "\n" +
								"message : " + request.responseText + "\n" +
								"error : " + error);
					}
				})
			})
			
			$("#NAME").blur(function() {
			
				if($("#NAME").val() == null || $("#NAME").val() == "") {
					$("#name_check").text("필수 정보입니다.");
					$("#name_check").attr("style", "color:red");
				}
				
				$.ajax({
					
					type: "POST",
					url: "/Basic_Board_Project/UserController?action=nameCheck",
					data: { NAME : $("#NAME").val() },
					datatype: "JSON",
					
					success: function(args) {
						var res = JSON.parse(args).result;
						
						if(res == 1) {
							$("#name_check").text("이미 사용중인 닉네임입니다.");
							$("#name_check").attr("style", "color:red");
							
							$("#SUBMIT").attr("disabled", "disabled");
						} else {
							$("#name_check").text("사용 가능한 닉네임입니다.");
							$("#name_check").attr("style", "color:blue");
							
							$("#SUBMIT").removeAttr("disabled");
						}
					},
					
					error : function(request, status, error) {
						alert("통신 실패");
						alert("code : " + request.status + "\n" +
								"message : " + request.responseText + "\n" +
								"error : " + error);
					}
				})
			})
			
			$("#PW_CONFIRM,#PASSWORD").blur(function() {
				var PASSWORD = $("#PASSWORD").val();
				var PW_CONFIRM = $("#PW_CONFIRM").val();
				
				if(PASSWORD != "" && PW_CONFIRM != "") {
					
					if(PASSWORD != PW_CONFIRM) {
						$("#pw_check").text("비밀번호가 일치하지 않습니다.");
						$("#pw_check").attr("style", "color:red");						
					} else {	
						$("#pw_check").text("비밀번호가 일치합니다.");
						$("#pw_check").attr("style", "color:green");
					}
				} 
			})

			$("#insertForm").submit(function(e) {
				
				e.preventDefault();
				// 실제 유저 입력 form은 event 취소
				// javaScript가 작동되지 않는 환경에서는 유저 입력 form이 submit됨 -> server 측에서 검증되므로 로그인 불가.
				
				var USERID = $(this).find("#USERID").val();
				var PASSWORD = $(this).find("#PASSWORD").val();
				var NAME = $(this).find("#NAME").val();

				$("#hiddenForm input[name='USERID']").val(rsa.encrypt(USERID));
				$("#hiddenForm input[name='PASSWORD']").val(rsa.encrypt(PASSWORD));
				$("#hiddenForm input[name='NAME']").val(rsa.encrypt(NAME));

				// 임시 출력 alert!!//////////////////////////////////////
				alert("userid : " + $("#hiddenForm input[name='USERID']").val() + "\n" 
						+ "password : " + $("#hiddenForm input[name='PASSWORD']").val() + "\n"
						+ "name : " + $("#hiddenForm input[name='NAME']").val() + "\n");
				//////////////////////////////////////////////////////
				
				$("#hiddenForm").submit();
			})
		})
	</script>

</head>

<body>
	<div style="width: 50%">
	<a href="/SINGLE/home/home.do">돌아가기</a>
		<P>
		<H2>USER :: 회원가입</H2>
		<HR>
		
		<!-- 사용자에게 입력받는 form -->
		<form id="insertForm" name="form1" method="post" action="user/join.do">
			<input type="hidden" name="action" value="insert">
			<div>
				<label for="USERID">ID : </label>
			    <input type="text" id="USERID" name="USERID" placeholder="아이디를 입력해주세요" maxlength="10" autofocus autocomplete="off" required />
				<div class="check_font" id="id_check"></div>	<!-- 경고문이 들어갈 공간 -->
			</div>

			<div>
				<label for="PASSWORD">PW : </label>
			    <input type="password" id="PASSWORD" name="PASSWORD" placeholder="비밀번호를 입력해주세요" autocomplete="off" required />
			</div>
			
			<div>
				<label for="PASSWORD">PW : </label>
			    <input type="password" id="PW_CONFIRM" placeholder="비밀번호를 확인해주세요" autocomplete="off" required />
				<div class="check_font" id="pw_check"></div>
			</div>

			<div>
				<label for="NAME">NICKNAME : </label>
				<input type="text" id="NAME" name="NAME" placeholder="닉네임을 입력해주세요" autocomplete="off" required/>
				<div class="check_font" id="name_check"></div>
			</div>

			<button type="submit" id="SUBMIT">가입</button>
			<button onclick="">취소</button>
		</form>
		
		<!-- 실제 서버로 전송되는 FORM -->
		<form action="/Basic_Board_Project/UserController?action=insert" method="post" id="hiddenForm">
			<fieldset>
				<input type="hidden" name="USERID">
				<input type="hidden" name="PASSWORD">
				<input type="hidden" name="NAME">
			</fieldset>
		</form>
		
	</div>

</body>
</html>