<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SINGLE 회원가입</title>

<!-- START :: CSS -->
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link href="/SINGLE/resources/css/master.css" rel="stylesheet" type="text/css">
<style type="text/css">

	body {
		background: #F5F5F5;
	}
	
	.container {
		height: auto;
		background: white;
		min-width: 300px;
		max-width: 780px;
		padding: 30px 100px 30px 100px;
		margin-top: 50px;
		box-shadow: 5px 5px 5px #999;
		border: 10px solid #46b8da;
		border-radius: 5px;
	}
	
	#kakao-login-btn {
		margin-right: 20px;
	}
	
	.sns-join {
		text-align: center;
		margin: 30px;
	}
	
	.hr-sect {
		display: flex;
		flex-basis: 100%;
		align-items: center;
		color: rgba(0, 0, 0, 0.35);
		font-size: 12px;
		margin: 8px 0px;
	}
	
	.hr-sect::before,
	.hr-sect::after {
		content: "";
		flex-grow: 1;
		background: rgba(0, 0, 0, 0.35);
		height: 1px;
		font-size: 0px;
		line-height: 0px;
		margin: 0px 16px;
	}
	
	#joinForm {
		margin-top: 20px;
	}
	
	label.required::before {
		content: '*';
	    display: inline-block;
	    vertical-align: top;
	    font-weight: 700;
	    -webkit-font-smoothing: antialiased;
	    color: #F44336;
	    margin: 0 0.125rem 0 0;
	    font-size: 1.25rem;
	    line-height: 1.25rem;
	}
	
	.join-btn {
		text-align: center;
	}

</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>

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

		/*
		* 이메일
		*/
		
		$("#email_auth").attr("disabled", "disabled");
		
		// 이메일 정규식
		var regExpEm = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;	
		
		// 이메일 체크
		$("#MEMBER_EMAIL").keyup(function() {
			
			if($("#MEMBER_EMAIL").val() != null && $("#MEMBER_EMAIL").val() != ""){
				
				// 이메일 형식인지 체크
				if(regExpEm.test($("#MEMBER_EMAIL").val())) {
					
					// 이메일 중복 체크
					$.ajax({
						type: "POST",
						url: "/SINGLE/member/emailCheck.do",
						data: { MEMBER_EMAIL : $("#MEMBER_EMAIL").val() },
						dataType: "JSON",
						success: function(msg) {
							
							if(msg.result > 0) {
								$("#email_check").text("이미 사용중인 이메일입니다.");
								$("#email_check").attr("style", "color:red");
								
							} else {
								$("#email_auth").removeAttr("disabled");
								
								$("#email_check").text("사용 가능한 이메일입니다. 이메일 인증을 진행해주세요.");
								$("#email_check").attr("style", "color:blue");
							}
						},
						error: function() {
							alert("이메일 중복체크 통신 실패");
						}
					});
					
				} else {
					$("#email_auth").attr("disabled", "disabled");
					
					$("#email_check").text("이메일 형식이 아닙니다.");
					$("#email_check").attr("style", "color:red");
				}
				
			} else {
				$("#email_check").text("필수 정보입니다.");
				$("#email_check").attr("style", "color:red");
			}
		});
		
		// 이메일 인증
		$("#email_auth").click(function() {
			
			$("#email_check").text("이메일 인증 진행중...");
			$("#email_check").attr("style", "color:green");
			
			// 이메일 인증
			$.ajax({
				type: "POST",
				url: "/SINGLE/member/emailAuth.do",
				data: { MEMBER_EMAIL : $("#MEMBER_EMAIL").val() },
				dataType: "JSON",
				success: function(msg) {
					alert("입력하신 이메일로 인증번호가 전송되었습니다.");
					
					$("#emailAuthHiddenForm input[name='authNum']").val(msg.authNum);
					
					// 인증번호 입력 팝업창
					var url = "/SINGLE/views/member/joinemailauth.jsp";
            		var title = "";
            		var prop = "top=200px,left=600px,width=585px,height=400px";
            		window.open(url, title, prop);
				},
				error: function() {
					alert("이메일 인증 통신 실패");
				}
			});
		});
		
		
		/*
		* 비밀번호
		*/
		
		// 비밀번호 정규식 (숫자와 영문자 조합으로 최소 8자리)
		var regExpPw = /^[a-zA-Z0-9]{8,}$/;
		
		// 비밀번호 체크
		$("#MEMBER_PASSWORD,#PW_CONFIRM").keyup(function() {
			
			if($("#MEMBER_PASSWORD").val() != null && $("#MEMBER_PASSWORD").val() != "") {
				
				// 비밀번호 형식인지 체크
				if(regExpPw.test($("#MEMBER_PASSWORD").val())) {
					$("#pw_check").text("");
					
					// 비밀번호 확인 체크
					if($("#MEMBER_PASSWORD").val() != "" && $("#PW_CONFIRM").val() != "") {
						
						if($("#MEMBER_PASSWORD").val() != $("#PW_CONFIRM").val()) {
							$("#pw_confirm").text("비밀번호가 일치하지 않습니다.");
							$("#pw_confirm").attr("style", "color:red");
						} else {	
							$("#pw_confirm").text("비밀번호가 일치합니다.");
							$("#pw_confirm").attr("style", "color:green");
						}
					}
					
				} else {
					$("#pw_check").text("적어도 하나의 영문자와 숫자, 최소 8자 이상");
					$("#pw_check").attr("style", "color:red");
				}
			}
		});
		
		// 닉네임 체크
		$("#MEMBER_NICKNAME").keyup(function() {
			
			if($("#MEMBER_NICKNAME").val() != null && $("#MEMBER_NICKNAME").val() != "") {			
				// 닉네임 중복 체크
				$.ajax({
					type: "POST",
					url: "/SINGLE/member/nickCheck.do",
					data: { MEMBER_NICKNAME : $("#MEMBER_NICKNAME").val() },
					dataType: "JSON",
					success: function(msg) {
						
						if(msg.result > 0) {
							$("#nick_check").text("이미 사용중인 닉네임입니다.");
							$("#nick_check").attr("style", "color:red");
							
							$("#SUBMIT").attr("disabled", "disabled");
						} else {
							$("#nick_check").text("사용 가능한 닉네임입니다.");
							$("#nick_check").attr("style", "color:blue");
							
							$("#SUBMIT").removeAttr("disabled");
						}
					},
					error: function() {
						alert("닉네임 중복 체크 통신 실패");
					}
				});
			} else {
				$("#nick_check").text("필수 정보입니다.");
				$("#nick_check").attr("style", "color:red");
			}
		});

		// 입력된 값들을 서버에 전송
		$("#joinForm").submit(function(e) {
			e.preventDefault();
			
			var MEMBER_EMAIL = $(this).find("#MEMBER_EMAIL").val();
			var MEMBER_PASSWORD = $(this).find("#MEMBER_PASSWORD").val();
			var MEMBER_NAME = $(this).find("#MEMBER_NAME").val();
			var MEMBER_NICKNAME = $(this).find("#MEMBER_NICKNAME").val();
			var MEMBER_GENDER = $(this).find("input:radio[name='MEMBER_GENDER']:checked").val();
	
			// 사용자가 입력한 form에서 hidden form으로 셋팅
			$("#joinhiddenForm input[name='MEMBER_EMAIL']").val(MEMBER_EMAIL);
			$("#joinhiddenForm input[name='MEMBER_PASSWORD']").val(rsa.encrypt(MEMBER_PASSWORD)); // 비밀번호 암호화
			$("#joinhiddenForm input[name='MEMBER_NAME']").val(MEMBER_NAME);
			$("#joinhiddenForm input[name='MEMBER_NICKNAME']").val(MEMBER_NICKNAME);
			$("#joinhiddenForm input[name='MEMBER_GENDER']").val(MEMBER_GENDER);
						
			$("#joinhiddenForm").submit();
		});
	});
	
	
</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>

	<div class="container">
		<div class="text-center">
			<p style="color:#46b8da; font-size: 30pt;"><strong>회원가입</strong>
		</div>
		
		<!-- START :: SNS 로그인 버튼 -->
		<div class="sns-join">
			<span id="kakao-login-btn"></span><span id="naver_id_login"></span>
		</div>
		<!-- END :: SNS 로그인 버튼 -->
		
		<div class="hr-sect">또는</div>
		
		<!-- START :: 사용자에게 입력받는 form -->
		<form id="joinForm" method="post" action="/SINGLE/member/join.do">
			<div class="form-group">
				<label class="required" for="MEMBER_EMAIL">이메일</label>
				<div class="input-group">
				    <input type="text" class="form-control" id="MEMBER_EMAIL" name="MEMBER_EMAIL" placeholder="example@example.com" autofocus autocomplete="off" required="required" />
					<div class="input-group-btn">
					    <button type="button" id="email_auth" class="btn btn-info">이메일 인증</button>
					</div>
				</div>
				<div class="check_font" id="email_check"></div><!-- 경고문이 들어갈 공간 -->
			</div>

			<div class="form-group">
				<label class="required" for="MEMBER_PASSWORD">비밀번호</label>
			    <input type="password" class="form-control" id="MEMBER_PASSWORD" name="MEMBER_PASSWORD" placeholder="최소 8자, 영문자, 숫자" autocomplete="off" required="required" />
				<div class="check_font" id="pw_check"></div><!-- 경고문이 들어갈 공간 -->
			</div>
			
			<div class="form-group">
				<label class="required" for="MEMBER_PASSWORD">비밀번호 확인</label>
			    <input type="password" class="form-control" id="PW_CONFIRM" placeholder="비밀번호 확인" autocomplete="off" required="required" />
				<div class="check_font" id="pw_confirm"></div><!-- 경고문이 들어갈 공간 -->
			</div>

			<div class="form-group">
				<label class="required" for="MEMBER_NAME">이름</label>
				<input type="text" class="form-control" id="MEMBER_NAME" name="MEMBER_NAME" placeholder="이름" autocomplete="off" required="required" />
			</div>
			
			<div class="form-group">
				<label class="required" for="MEMBER_NICKNAME">닉네임</label>
				<input type="text" class="form-control" id="MEMBER_NICKNAME" name="MEMBER_NICKNAME" placeholder="별명" autocomplete="off" required="required" />
				<div class="check_font" id="nick_check"></div><!-- 경고문이 들어갈 공간 -->
			</div>
			
			<div class="form-group">
				<label class="required">성별</label>
				<div class="form-check">
					<input type="radio" class="form-check-input" name="MEMBER_GENDER" value="M" required="required">
					<label class="form-check-label">남자</label>
				</div>
				<div class="form-check">
					<input type="radio" class="form-check-input" name="MEMBER_GENDER" value="F" required="required">
					<label class="form-check-label">여자</label>
				</div>
			</div>

			<div class="join-btn form-group">
				<button type="button" class="btn btn-default" onclick="location.href='/SINGLE/main/mainpage.do'">취소</button>
				<input type="submit" class="btn btn-info" id="SUBMIT" value="가입하기">
			</div>
		</form>
		<!-- END :: 사용자에게 입력받는 form -->
		
		<!-- START :: 이메일 인증번호 hidden form -->
		<form action="#" id="emailAuthHiddenForm">
			<input type="hidden" name="authNum">
		</form>
		<!-- END :: 이메일 인증번호 hidden form -->
		
		<!-- START :: 사이트 회원가입시 컨트롤러로 실제 전송되는 form -->
		<form action="/SINGLE/member/join.do" method="post" id="joinhiddenForm">
			<input type="hidden" name="MEMBER_VERIFY" value="2">
			<input type="hidden" name="MEMBER_EMAIL">
			<input type="hidden" name="MEMBER_PASSWORD">
			<input type="hidden" name="MEMBER_NAME">
			<input type="hidden" name="MEMBER_NICKNAME">
			<input type="hidden" name="MEMBER_GENDER">
			<input type="hidden" name="SNS_ID">
			<input type="hidden" name="SNS_NICKNAME">
			<input type="hidden" name="SNS_EMAIL">
			<input type="hidden" name="access_token">
		</form>
		<!-- END :: 사이트 회원가입시 컨트롤러로 실제 전송되는 form -->
		
		<!-- START :: SNS 회원가입 -->
		<!-- SNS 회원가입시 팝업창으로 전송되는 form (SNS 회원가입은 무조건 일반회원으로 가입) -->
		<form action="/SINGLE/user/join.do" method="post" id="snshiddenForm">
			<input type="hidden" name="snsType">
			<input type="hidden" name="SNS_ID">
			<input type="hidden" name="SNS_NICKNAME">
			<input type="hidden" name="SNS_EMAIL">
			<input type="hidden" name="access_token">
			<input type="hidden" name="MEMBER_VERIFY" value="2">
		</form>
		
		<!-- 팝업창에서 전송된 form -->
		<form action="/SINGLE/member/snsjoin.do" method="post" id="snsjoinhiddenForm">
			<input type="hidden" name="snsType">
			<input type="hidden" name="MEMBER_VERIFY" value="2">
			<input type="hidden" name="MEMBER_EMAIL">
			<input type="hidden" name="MEMBER_NAME">
			<input type="hidden" name="MEMBER_NICKNAME">
			<input type="hidden" name="MEMBER_GENDER">
			<input type="hidden" name="SNS_ID">
			<input type="hidden" name="SNS_NICKNAME">
			<input type="hidden" name="SNS_EMAIL">
			<input type="hidden" name="access_token">
		</form>
		
		<!-- 가입이력이 있어서 SNS 로그인될 때 전송되는 form -->
		<form action="/SINGLE/member/snslogin.do" method="post" id="snsloginhiddenForm">
			<input type="hidden" name="snsType">
			<input type="hidden" name="SNS_ID">
			<input type="hidden" name="access_token">
		</form>
		<!-- END :: SNS 회원가입 -->
		
	</div>
</body>

	<script type='text/javascript'>
        Kakao.init('e279f4719a19c18fde6278302eaeb6d8');
        Kakao.Auth.createLoginButton({
          container: '#kakao-login-btn',
          success: function(authObj) {
            Kakao.API.request({
            	url:'/v1/user/me',
            	success:function(res) {
            		console.log(res.id);
            		console.log(res.properties.nickname);
            		console.log(res.kaccount_email);
            		console.log(authObj.access_token);

            		$.ajax({
            			type: "POST",
            			url: "/SINGLE/member/snschk.do",
            			data: {
            				KAKAO_ID : res.id,
            				snsType : "KAKAO"
            			},
            			dataType: "JSON",
            			success: function(msg) {
            				if(msg.result == 1) {	// 가입한 회원 -> 바로 로그인
            					alert("이미 카카오로 가입한 회원입니다.");
            				
            					$("#snsloginhiddenForm input[name='snsType']").val("KAKAO");
                        		$("#snsloginhiddenForm input[name='SNS_ID']").val(res.id);
                        		$("#snsloginhiddenForm input[name='access_token']").val(authObj.access_token);
            					
                        		$("#snsloginhiddenForm").submit();
                        		
            				} else {	// 회원가입 팝업 띄우고 회원가입 진행
            					alert("가입 이력이 없습니다. 회원가입을 진행합니다.");
            				
            					// snshiddenForm에 value값 셋팅
                        		$("#snshiddenForm input[name='snsType']").val("KAKAO");
                        		$("#snshiddenForm input[name='SNS_ID']").val(res.id);
                        		$("#snshiddenForm input[name='SNS_NICKNAME']").val(res.properties.nickname);
                        		$("#snshiddenForm input[name='SNS_EMAIL']").val(res.kaccount_email);
                        		$("#snshiddenForm input[name='access_token']").val(authObj.access_token);
                        		
                        		var url = "/SINGLE/views/member/snsjoin.jsp";
                        		var title = "";
                        		var prop = "top=200px,left=600px,width=600px,height=650px";
                        		window.open(url, title, prop);
            				}
            			},
            			error: function() {
            				alert("통신 실패");
            			}
            		})
            	}
            });
          },
          fail: function(err) {
             alert(JSON.stringify(err));
          }
        });
      
	      // 카카오톡 로그아웃
	      function kakaologout() {
	    	  Kakao.Auth.logout(function() {
	    		  setTimeout(function() {
	    			  location.href="/SINGLE/main/mainpage.do";
	    		  }, 1000);
	    	  });
	      }
	      
	    /*
    		네이버 로그인
		*/
		var naver_id_login = new naver_id_login("tl7_MvP2GoSrA_PE_reP",
				"http://localhost:8090/SINGLE/views/member/navercallback.jsp");

		var state = naver_id_login.getUniqState();

		naver_id_login.setButton("green", 3, 48);
		naver_id_login.setDomain("http://localhost:8090/SINGLE");
		naver_id_login.setState(state);
		naver_id_login.setPopup();
		naver_id_login.init_naver_id_login();
		
	</script>
</html>