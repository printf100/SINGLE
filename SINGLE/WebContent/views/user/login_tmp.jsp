<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<!-- javaScript library load -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>

<!-- 카카오 로그인 API -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<script type="text/javascript" src="resources/js/RSA/rsa.js"></script>
<script type="text/javascript" src="resources/js/RSA/jsbn.js"></script>
<script type="text/javascript" src="resources/js/RSA/prng4.js"></script>
<script type="text/javascript" src="resources/js/RSA/rng.js"></script>

<script type="text/javascript">
	$(function() {
		var rsa = new RSAKey();
		rsa.setPublic("${modulus}", "${exponent}");

		$("#insertForm").submit(
						function(e) {

							e.preventDefault();
							// 실제 유저 입력 form은 event 취소
							// javaScript가 작동되지 않는 환경에서는 유저 입력 form이 submit됨 -> server 측에서 검증되므로 로그인 불가.

							var USERID = $(this).find("#USERID").val();
							var PASSWORD = $(this).find("#PASSWORD").val();

							$("#hiddenForm input[name='USERID']").val(
									rsa.encrypt(USERID));
							$("#hiddenForm input[name='PASSWORD']").val(
									rsa.encrypt(PASSWORD));

							// 임시 출력 alert!!//////////////////////////////////////
							alert("userid : "
									+ $("#hiddenForm input[name='USERID']")
											.val()
									+ "\n"
									+ "password : "
									+ $("#hiddenForm input[name='PASSWORD']")
											.val() + "\n");
							//////////////////////////////////////////////////////

							//$("#hiddenForm").submit();

							$
									.ajax({

										type : "POST",
										url : "/Basic_Board_Project/UserController?action=login",
										data : {
											USERID : $(
													"#hiddenForm input[name='USERID']")
													.val(),
											PASSWORD : $(
													"#hiddenForm input[name='PASSWORD']")
													.val()
										},
										datatype : "JSON",

										success : function(args) {
											var res = JSON.parse(args).result;

											if (res == 0 || res == -1) {
												$("#login_check").text(
														"ID, PW를 확인해주세요.");
												$("#login_check").attr("style",
														"color:red");
											} else if (res == 1) {
												location.href = "/Basic_Board_Project/BoardController?action=listBoard";
											}
										},

										error : function(request, status, error) {
											alert("통신 실패");
											alert("code : " + request.status
													+ "\n" + "message : "
													+ request.responseText
													+ "\n" + "error : " + error);
										}
									})
						})
	})
</script>

</head>
<body>

	<div style="width: 50%">
		<a href="/SINGLE/home/home.do">돌아가기</a>
		<p>
		<H2>USER :: 로그인</H2>
		
		<!-- 카카오 로그인 버튼 -->
		<a id="kakao-login-btn"></a>
		<input type="button" value="카카오톡 로그아웃" onclick="kakaologout()"></a>
		<a href="https://developers.kakao.com/logout">완전로그아웃</a>
		<script type='text/javascript'>
	      //<![CDATA[
	        // 사용할 앱의 JavaScript 키를 설정해 주세요.
	        Kakao.init('e279f4719a19c18fde6278302eaeb6d8');
	        // 카카오 로그인 버튼을 생성합니다.
	        Kakao.Auth.createLoginButton({
	          container: '#kakao-login-btn',
	          success: function(authObj) {
	            alert(JSON.stringify(authObj));
	            Kakao.API.request({
	            	url:'/v1/user/me',
	            	success:function(res) {
	            		alert(JSON.stringify(res));
	            		console.log(res.id);
	            		console.log(res.account_email);
	            		//console.log(res.kakao_account.gender);
	            		//alert(res.kakao_account.gender);
	            		console.log(res.properties.nickname);

	            		console.log(authObj.access_token);
	            	}
	            });
	          },
	          fail: function(err) {
	             alert(JSON.stringify(err));
	          }
	        });
	      //]]>
	      
	      // 카카오톡 로그아웃
	      function kakaologout() {
	    	  Kakao.Auth.logout(function() {
	    		  setTimeout(function() {
	    			  location.href="/SINGLE/home/home.do";
	    		  }, 1000);
	    	  });
	      }
	    </script>

		<!-- 사용자에게 입력받는 form -->
		<form id=insertForm action="/Basic_Board_Project/UserController?action=login" method="post">
			<div>
				<label for="USERID">ID </label> <input id="USERID" type="text" name="USERID">
			</div>

			<div>
				<label for="PASSWORD">PW : </label> <input id="PASSWORD" type="password" name="PASSWORD">
			</div>

			<div class="check_font" id="login_check"></div>

			<input type="submit" value="로그인">
		</form>

		<!-- 실제 서버로 전송되는 form -->
		<form id=hiddenForm action="/Basic_Board_Project/UserController?action=login" method="post">
			<input type="hidden" name="USERID" /> <input type="hidden" name="PASSWORD" />
		</form>
	</div>

</body>
</html>