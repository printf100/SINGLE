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

<style type="text/css">

	body{
	    background:#eee;    
	}
	.chat-list {
	    padding: 0;
	    font-size: .8rem;
	}
	
	.chat-list li {
	    margin-bottom: 10px;
	    overflow: auto;
	    color: #ffffff;
	}
	
	.chat-list .chat-img {
	    float: left;
	    width: 48px;
	}
	
	.chat-list .chat-img img {
	    -webkit-border-radius: 50px;
	    -moz-border-radius: 50px;
	    border-radius: 50px;
	    width: 100%;
	}
	
	.chat-list .chat-message {
	    -webkit-border-radius: 30px;
	    -moz-border-radius: 30px;
	    border-radius: 30px;
	    background: #5a99ee;
	    display: inline-block;
	    padding: 10px 20px;
	    position: relative;
	}
	
	.chat-list .chat-message:before {
	    content: "";
	    position: absolute;
	    top: 15px;
	    width: 0;
	    height: 0;
	}
	
	.chat-list .chat-message h5 {
	    margin: 0 0 5px 0;
	    font-weight: 600;
	    line-height: 100%;
	    font-size: .9rem;
	}
	
	.chat-list .chat-message p {
	    line-height: 18px;
	    margin: 0;
	    padding: 0;
	}
	
	.chat-list .chat-body {
	    margin-left: 5px;
	    float: left;
	    width: 70%;
	}
	
	/* .chat-list .in .chat-message:before {
	    left: -12px;
	    border-bottom: 20px solid transparent;
	    border-right: 20px solid #5a99ee;
	} */
	
	.chat-list .out .chat-img {
	    float: right;
	}
	
	.chat-list .out .chat-body {
	    float: right;
	    margin-right: 20px;
	    text-align: right;
	}
	
	.chat-list .out .chat-message {
	    background: #fc6d4c;
	}
	
	/* .chat-list .out .chat-message:before {
	    right: -12px;
	    border-bottom: 20px solid transparent;
	    border-left: 20px solid #fc6d4c;
	} */
	
	.card .card-header:first-child {
	    -webkit-border-radius: 0.3rem 0.3rem 0 0;
	    -moz-border-radius: 0.3rem 0.3rem 0 0;
	    border-radius: 0.3rem 0.3rem 0 0;
	}
	.card .card-header {
	    background: #17202b;
	    border: 0;
	    font-size: 1rem;
	    padding: .65rem 1rem;
	    position: relative;
	    font-weight: 600;
	    color: #ffffff;
	}
	
	.content{
	    margin-top:40px;    
	}
	
	.portlet-footer {
	    padding: 10px 15px;
	    background: #e0e7e8;
	}

</style>

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

	$(function() {
		
		// hidden에 값 셋팅
		var MY_MEMBER_CODE = $(opener.document).find("#MY_MEMBER_CODE").val();
		$("#MY_MEMBER_CODE").val(MY_MEMBER_CODE);
		
		var TO_MEMBER_CODE = $(opener.document).find("#TO_MEMBER_CODE").val();
		$("#TO_MEMBER_CODE").val(TO_MEMBER_CODE);

		alert("FROM " + MY_MEMBER_CODE + " TO " + TO_MEMBER_CODE);
		
		var CHATROOM_CODE = $(opener.document).find("#CHATROOM_CODE").val();
		$("#CHATROOM_CODE").val(CHATROOM_CODE);
		
		// 채팅방에 참여하고 있는 회원들 프로필 정보 가져오기
		$.ajax({
			type: "POST",
			url: "/SINGLE/chat/getchatMember.do",
			data: {
				MY_MEMBER_CODE : MY_MEMBER_CODE,
				TO_MEMBER_CODE : TO_MEMBER_CODE
			},
			dataType: "JSON",
			success: function(msg) {
				
				if(msg.result > 0) {
					alert("가져오기 성공");
					console.log(msg.my_img + " " + msg.my_nickname);
					console.log(msg.to_img + " " + msg.to_nickname);
					
					// hidden에 값 셋팅 (불러쓰기 편하려고)
					$("#TO_IMG").val("../../resources/images/profileimg/" + msg.to_img);
					$("#TO_NICKNAME").val(msg.to_nickname);
					$("#MY_IMG").val("../../resources/images/profileimg/" + msg.my_img);
					$("#MY_NICKNAME").val(msg.my_nickname);
					
					// 메세지가 있으면 20개 뿌려주기		
					$.getJSON("/SINGLE/chat/getMessageList.do", {
						CHATROOM_CODE : CHATROOM_CODE
					}).done(function(data) {
						
						$.each(data, function(index, item) {
							console.log(item);
							console.log(item.CHATMESSAGE_CONTENT);
							
							// 각각의 메세지 div
							/* var div = $("<div>").attr({
								"class" : "chat-message"
							});
							
							// 각각의 메세지 내용
							var msg = $("<p>").text(item.CHATMESSAGE_CONTENT);
							
							$(".chat-body").append(div.append(msg)); */
							
							if(item.CHATMESSAGE_FROM != MY_MEMBER_CODE) { // in
								
								$(".chat-list").append('<li class="in">' +
																'<div class="chat-img">' +
																	'<img class="to" src="' + $("#TO_IMG").val() + '">' +
																'</div>' +
																'<div class="chat-body">' +
																	'<div class="chat-message">' +
																		'<h5>' + $("#TO_NICKNAME").val() + '</h5>' +
																		'<p>' + item.CHATMESSAGE_CONTENT + '</p>' +
																	'</div>' +
																'</div>');
								
							} else if(item.CHATMESSAGE_FROM == MY_MEMBER_CODE) { // out
								
								$(".chat-list").append('<li class="out">' +
																'<div class="chat-img">' +
																	'<img class="from" src="' + $("#MY_IMG").val() + '">' +
																'</div>' +
																'<div class="chat-body">' +
																	'<div class="chat-message">' +
																		'<h5>' + $("#MY_NICKNAME").val() + '</h5>' +
																		'<p>' + item.CHATMESSAGE_CONTENT + '</p>' +
																	'</div>' +
																'</div>');
							}
						});
					});
					
				} else {
					alert("가져오기 실패");
				}
			},
			error: function() {
				alert("프로필 가져오기 통신 실패");
			}
		});
		
		// 메세지 전송
		$("#sendMessage").click(function() {
			
			var CHAT_CONTENT = $("#CHAT_CONTENT").val();

			$.ajax({
				type: "POST",
				url: "/SINGLE/chat/sendMessage.do",
				data: {
					CHATROOM_CODE : $("#CHATROOM_CODE").val(),
					CHATMESSAGE_FROM : $("#MY_MEMBER_CODE").val(),
					CHAT_CONTENT : CHAT_CONTENT
				},
				dataType: "JSON",
				success: function(msg) {
					
					console.log(msg.content);
					
					if(msg.result > 0) {
						$(".chat-list").append('<li class="out">' +
														'<div class="chat-img">' +
															'<img class="from" src="' + $("#MY_IMG").val() + '">' +
														'</div>' +
														'<div class="chat-body">' +
															'<div class="chat-message">' +
																'<h5>' + $("#MY_NICKNAME").val() + '</h5>' +
																'<p>' + msg.content + '</p>' +
															'</div>' +
    													'</div>');
					}
				},
				error: function() {
					alert("메세지 전송 통신 실패");
				}
			});
			
			$("#CHAT_CONTENT").val("");
		});
		
		
		// setInterval로 메세지 계속 뿌려주기
	});

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>
	<!-- START :: 가져온 값들을 셋팅해 둘 곳 -->
	<input type="hidden" id="CHATROOM_CODE">
	
	<input type="hidden" id="TO_MEMBER_CODE">
	<input type="hidden" id="TO_IMG">
	<input type="hidden" id="TO_NICKNAME">
	
	<input type="hidden" id="MY_MEMBER_CODE">
	<input type="hidden" id="MY_IMG">
	<input type="hidden" id="MY_NICKNAME">
	<!-- END :: 가져온 값들을 셋팅해 둘 곳 -->
	
	<!-- START :: 채팅방 부트스트랩 -->
	<div class="container content bootstrap snippet">
	    <div class="row">
	        <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12">
	        	<div class="card">
	        		<div class="card-header">Chat</div>
	        		<div class="card-body height3">
	        			<ul class="chat-list">        				
	        			</ul>
	        		</div>
	        		<div class="portlet-footer">
	        			<form role="form">
	                    	<div class="form-group">
	                        	<textarea class="form-control" id="CHAT_CONTENT" placeholder="메세지를 입력해주세요."></textarea>
	                        </div>
	                        <div class="form-group">
	                        	<button type="button" id="sendMessage" class="btn btn-default pull-right">전송</button>
	                        	<div class="clearfix"></div>
	                 		</div>
	                     </form>
	                 </div>
	             </div>
	      	</div>
	    </div>
	</div>
	<!-- END :: 채팅방 부트스트랩 -->

</body>
</html>