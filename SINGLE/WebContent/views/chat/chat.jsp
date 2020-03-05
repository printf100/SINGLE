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
	
	.find-member {
		position: relative;
		padding-top: 200px;
		padding-left: 50px;
		width: 50%;
		height: 100vh;
		float: left;
	}
	
	.chatroom {
		padding-top: 100px;
		position: relative;
		margin-left: 50%;
		width: 100%;
		height: 100vh;
	}
	
	.find-list {
		height: 150px;
	}
	
	.find-profile-img {
		position: relative;
		float: left;
		width: 50px;
		height: 50px;
		border-radius: 30%;
		overflow: hidden;
	}
	
	#find-img {
		width: 100%;
		height: 100%;
		object-fit: cover;
	}

	.find-info {
		position: relative;
		margin-left: 50px;
	}
	
	.chatroom-verify {
		list-style: none;
		height: 50px;
		width: 100%;
	}
	
	.chatroom-verify li {
		display: inline-block;
		text-align: center;
		vertical-align: middle;
		cursor: pointer;
		height: 50px;
		width: 200px;
		font-weight: bold;
		overflow: hidden;
	    position: relative;
	    border: 1px solid lightgray;
	}
	
	.chatroom-list {
		list-style: none;
		height: 50px;
		width: 100%;
	}
	
	.chatroom-list .chatroom-list-detail {
		vertical-align: middle;
		background: lightgray;
		cursor: pointer;
		height: 50px;
		width: 390px;
		font-weight: bold;
		overflow: hidden;
		padding: 10px;
	}

</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

	$(function() {
		
		$("#findbtn").click(function() {
			
			// 회원 찾기
			$.ajax({
				type: "POST",
				url: "/SINGLE/chat/findMember.do",
				data: {	MEMBER_EMAIL : $("#MEMBER_EMAIL").val() },
				dataType: "JSON",
				success: function(msg) {
					
					if(msg.result > 0) {
						alert("회원 찾기를 성공하였습니다.");
						$(".find-result").text("회원 찾기를 성공하였습니다.");
						
						$("#TO_MEMBER_CODE").val(msg.TO_MEMBER_CODE);
							
						if(msg.profileimg != null) {
							$(".find-profile-img").children().remove();
							$(".find-profile-img").append($("<img id='find-img'>").attr("src", "../resources/images/profileimg/" + msg.profileimg));							
						} else {
							$(".find-profile-img").children().remove();
							$(".find-profile-img").append($("<img id='find-img'>").attr("src", "../resources/images/member/profileimg.png"));
						}
								
						$(".find-nickname").text(msg.nickname);
						$(".find-introduce").text(msg.introduce);
						$("#one-to-one").text("채팅하기");
								
					} else {
						alert("회원을 찾을 수 없습니다.");
						$(".find-result").text("회원을 찾을 수 없습니다.");
					}
				},
				error: function() {
					alert("회원 찾기 통신 실패");
				}
			});
		});

		// 내가 참여중인 일대일 채팅방 리스트 가져오기
		$("#myOnetoOneList").click(function() {
			
			$(".chatroom-list").children().remove();
			
			$.getJSON("/SINGLE/chat/getMyOnetoOneChatList.do", {
				MY_MEMBER_CODE : $("#MY_MEMBER_CODE").val()
			}).done(function(data) {
				
				$.each(data, function(index, item) {
					console.log(item);
					console.log(item.MEMBER_NICKNAME);
					console.log(item.MEMBER_CODE);
					console.log(item.CHATROOM_CODE);
					
					// 각각의 리스트 div
					var list = $("<li>").attr({
						"class" : "chatroom-list-detail"
					}).append($("<input>").attr({
						"type" : "hidden",
						"name" : "CHATROOM_CODE",
						"value" : item.CHATROOM_CODE
					}).append($("<input>").attr({
						"type" : "hidden",
						"name" : "TO_MEMBER_CODE",
						"value" : item.MEMBER_CODE
					})));
					
					// 채팅방 제목 div
					var list_title = $("<a>").attr({
						"class" : "chatroom-title"
					}).text(item.MEMBER_NICKNAME);
					// 읽지 않은 메세지 갯수도 추가해주기!!!!!! 누르면 채팅창 뜨는 것도
					
					$(".chatroom-list").append(list.append(list_title));
				});
			});			
		});
		
		// 채팅방 들어가기
		$(document).on("click", ".chatroom-list-detail", function() {
			var CHATROOM_CODE = $(this).find("input[name='CHATROOM_CODE']").val();
			$("#CHATROOM_CODE").val(CHATROOM_CODE);
			var TO_MEMBER_CODE = $(this).find("input[name='TO_MEMBER_CODE']").val();
			$("#TO_MEMBER_CODE").val(TO_MEMBER_CODE);
			var MY_MEMBER_CODE = $("#MY_MEMBER_CODE").val();
			$("#MY_MEMBER_CODE").val(MY_MEMBER_CODE);
			
			// 채팅방 팝업창 띄우기
			var url = "/SINGLE/views/chat/chatroom.jsp";
			var title = "";
			var prop = "top=200px,left=600px,width=500px,height=500px";
			window.open(url, title, prop);
		});
		
		// 내가 참여중인 다대다 채팅방 리스트 가져오기
		$("#myNtoNList").click(function() {
			
			$(".chatroom-list").children().remove();
			
			$.getJSON("/SINGLE/chat/getMyNtoNChatList.do", {
				MY_MEMBER_CODE : $("#MY_MEMBER_CODE").val()
			}).done(function(data) {
				
				$.each(data, function(index, item) {
					console.log(item);
					console.log(item.CHATROOM_CODE);
					console.log(item.CHATROOM_TITLE);
					
					// 각각의 리스트 div
					var list = $("<li>").attr({
						"class" : "chatroom-list-detail"
					});
					
					// 채팅방 제목 div
					var list_title = $("<a>").attr({
						"class" : "chatroom-title"
					}).text(item.CHATROOM_TITLE);
					// 읽지 않은 메세지 갯수도 추가해주기!!!!!! 누르면 채팅창 뜨는 것도
					
					$(".chatroom-list").append(list.append(list_title));
				});
			});
		});
		
 		$("#one-to-one").click(function() {
 			
 			alert($("#MY_MEMBER_CODE").val());
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
 						alert("기존 채팅방을 불러옵니다. " + msg.CHATROOM_CODE);
 						$("#CHATROOM_CODE").val(msg.CHATROOM_CODE);
 					} else {
 						alert("채팅방을 새로 생성합니다.");
 						$("#CHATROOM_CODE").val(msg.CHATROOM_CODE);
 					}
 					
 					// 채팅방 팝업창 띄우기
 					var url = "/SINGLE/views/chat/chatroom.jsp";
 				    var title = "";
 				    var prop = "top=200px,left=600px,width=500px,height=500px";
 				    window.open(url, title, prop);
 				}
 			});
		});
 		
 		
 		
	});
	
</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>
	
	<div class="container">
	
		<!-- 회원 찾기 -->
		<div class="find-member">
			<form>
				<div>
					<label for="MEMBER_EMAIL">회원 이메일</label>
				</div>
				<div>
					<input type="text" id="MEMBER_EMAIL" name="MEMBER_EMAIL" placeholder="찾을 이메일을 입력해주세요." required="required">
					<input type="button" id="findbtn" value="검색">
				</div>
			</form>
			
			<!-- 찾은 회원 정보 -->
			<div class="find-list">
				<div class="find-result"></div>
				<div class="find-profile-img"></div>
				<div class="find-info">
					<h4 class="find-nickname"></h4>
					<h5 class="find-introduce"></h5>
				</div>
				<a id="one-to-one"></a>
			</div>
		</div>
		
		
		<!-- 내가 참여중인 채팅방 리스트 -->
		<div class="chatroom">
			<ul class="chatroom-verify">
				<li><a id="myOnetoOneList">1:1 채팅방</a>
				<li><a id="myNtoNList">단체 채팅방</a>
			</ul>
			<ul class="chatroom-list">
			</ul>
		</div>
	</div>
	
	<!-- 채팅창에 전달할 값들 -->
	<input type="hidden" id="MY_MEMBER_CODE" value="${profile.MEMBER_CODE }">
	<input type="hidden" id="TO_MEMBER_CODE">
	<input type="hidden" id="CHATROOM_CODE">

<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->

</body>
</html>