<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SINGLE</title>

<!-- START :: CSS -->
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<style type="text/css">

	html {
		overflow: hidden;
	}

	body{
	    background:#eee;
	    font-family: 'Noto Sans KR';
	}
	
	.container {
		margin: auto;
	}
	
	.nano {
	    position: relative;
	    width: 100%;
	    height: 100%;
	    overflow: hidden;
	}

	.nano>.nano-content {
	    position: absolute;
	    overflow: scroll;
	    overflow-x: hidden;
	    top: 0;
	    right: 0;
	    bottom: 0;
	    left: 0;
	}
	
	.pad-all {
	    padding: 15px;
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
	    -webkit-border-radius: 50px;
	    -moz-border-radius: 50px;
	    border-radius: 50px;
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
	    margin-left: 20px;
	    float: left;
	    width: 70%;
	}
	
	.chat-list .in .chat-message:before {
	    left: -12px;
	    border-bottom: 20px solid transparent;
	    border-right: 20px solid #5a99ee;
	}
	
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
	
	.chat-list .out .chat-message:before {
	    right: -12px;
	    border-bottom: 20px solid transparent;
	    border-left: 20px solid #fc6d4c;
	}
	
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
	
	.portlet-footer {
		z-index: 10;
	    padding: 10px 15px;
	    background: #e0e7e8;
	}
	
	/* 오른쪽 메뉴바 */
	#bar-open-btn {
		float: right;
		cursor: pointer;
	}
	
	.menu-wrap {
		position: absolute;
		display: inline-block;
		width: 60%;
		min-height: 100%;
		height: 100%;
		z-index: 999;
		top: 0px;
		right: -100%;
		background-color: #fff;
	}
	
	#cover-close-btn {
		width: 100%;
		height: 100%;
		position: absolute;
		top: 0px;
		left: 0px;
		background-color: rgba(0, 0, 0, 0.6);
		z-index: 998;
		display: none;
	}
	
	#member-list {
		margin: 10px;
	}
	
	.profile-img-div {
		position: relative;
		float: left;
		width: 2.0rem;
		height: 2.0rem;
		border-radius: 0.25rem;
	}
	
	.profile-img {
		width: 100%;
		height: 100%;
		object-fit: cover;
	}
	
	.profile-nickname {
		margin-left: 40px;
	}

</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">	
	
	$(function() {
		
		// 스크롤 페이징
		$(".nano-content").scroll(function(){
		      let scrollTop = $(".nano-content").scrollTop();
		      
		      if(scrollTop == 0){
		    	  selectMsgList(true);
		      }
		});

		
		// hidden에 값 셋팅
		$("#MY_MEMBER_CODE").val($(opener.document).find("#MY_MEMBER_CODE").val());
		$("#MY_NICKNAME").val($(opener.document).find("#MY_NICKNAME").val());
		$("#MY_IMG").val($(opener.document).find("#MY_IMG").val());
		
		$("#TO_MEMBER_CODE").val($(opener.document).find("#TO_MEMBER_CODE").val());
		
		$("#CHATROOM_CODE").val($(opener.document).find("#CHATROOM_CODE").val());		
		
		// 상대방 프로필 정보 가져오기
		$.ajax({
			type: "POST",
			url: "/SINGLE/chat/getOneChatMember.do",
			data: {
				TO_MEMBER_CODE : $("#TO_MEMBER_CODE").val()
			},
			dataType: "JSON",
			success: function(msg) {
				
				if(msg.result > 0) {
					
					// hidden에 값 셋팅 (불러쓰기 편하려고)
					$("#TO_IMG").val("${pageContext.request.contextPath}/resources/images/profileimg/" + msg.to_img);
					$("#TO_NICKNAME").val(msg.to_nickname);
					$(".card-title").text(msg.to_nickname);
					
					// 메세지가 있으면 20개 뿌려주기
					selectMsgList(false);
					
					// 각각의 리스트 li
					var mylist = $("<li>").attr({
						"class" : "to-info-detail list-group-item"
					});
							
					// 리스트 안의 내용
					var myimg = $("<div>").attr({
						"class" : "profile-img-div"
					}).append($("<img>").attr({
						"class" : "profile-img",
						"src" : $("#MY_IMG").val()
					}));
					
					var mynickname = $("<div>").attr({
						"class" : "profile-nickname"
					}).append($("<h6>").text($("#MY_NICKNAME").val()));

					var my = mylist.append(myimg).append(mynickname);

					var tolist = $("<li>").attr({
						"class" : "to-info-detail list-group-item"
					});
					
					var toimg = $("<div>").attr({
						"class" : "profile-img-div"
					}).append($("<img>").attr({
						"class" : "profile-img",
						"src" : $("#TO_IMG").val()
					}));
					
					var tonickname = $("<div>").attr({
						"class" : "profile-nickname"
					}).append($("<h6>").text($("#TO_NICKNAME").val()));
					
					var to = tolist.append(toimg).append(tonickname);
							
					$(".member-info").append(my).append(to);
					
				} else {
					alert("가져오기 실패");
				}
			},
			error: function() {
				alert("프로필 가져오기 통신 실패");
			}
		});
		
		
		/*
		* 웹 소켓
		*/
		var ws = new WebSocket("ws://qclass.iptime.org:8787/SINGLE/websocket");
		
		// 웹 소켓이 연결됐을 때
		ws.onopen = function(e) {
			console.log(e.data);
			$(".chat-list").append('<li class="out">' +
											'<p style="color:black;">연결되었습니다.');
		};
		
		// 웹 소켓 연결이 해제됐을 때
		ws.onclose = function(e) {
			if(e.type == "close") {
				$(".chat-list").append('<li class="out">' +
												'<p style="color:black;">연결이 해제되었습니다.');				
			}
		};
		
		// 웹 소켓 에러
		ws.onerror = function(e) {
			$(".chat-list").append('<li class="out">' +
											'<p style="color:black;">ERROR');
		};
		
		// 메세지가 온 경우
		ws.onmessage = function(e) {
			var data = JSON.parse(e.data);
			
			// 현재 시간
			var date = new Date();
			var dateInfo = isTwo(date.getHours()) + ":" + isTwo(date.getMinutes());
			
			console.log(data.chatroom_code);
			
			if(data.chatroom_code == $("#CHATROOM_CODE").val()) {
				
				$(".chat-list").append('<li class="in">' +
												'<div class="chat-img">' +
													'<img class="to" src="${pageContext.request.contextPath}/resources/images/profileimg/' + data.profileimg + '">' +
												'</div>' +
												'<div class="chat-body">' +
													'<div class="chat-message">' +
														'<h5>' + data.nickname + '</h5>' +
														'<p>' + data.message + '</p>' +
														'<small class="timestamp">' + dateInfo + '</small>' +
													'</div>' +
												'</div>');				
			}
			
			// 스크롤 하단 고정
			$('.nano-content').scrollTop($('.nano-content').prop('scrollHeight'));
		};
		
		
		// 메세지 전송		
		$("#sendMessage").attr("disabled", "disabled");
		
		$("input").keyup(function(e) {
			e.preventDefault();
			
			var CHAT_CONTENT = $("#CHAT_CONTENT").val();
			
			if(CHAT_CONTENT != null && CHAT_CONTENT != ""){
				
				$("#sendMessage").removeAttr("disabled");
				
				var code = e.keyCode ? e.keyCode : e.which;
				
				if(code == 13) {	// 엔터키
					
					if(e.shiftKey == true) {	// shift키 눌린 상태에서는 다음 라인으로
						
					} else {	// 메세지전송
						
						// 현재 시간
						var date = new Date();
						var dateInfo = isTwo(date.getHours()) + ":" + isTwo(date.getMinutes());
						
						// 웹 소켓
						var obj = {};
						var jsonStr;
						
						obj.CHATROOM_CODE = $("#CHATROOM_CODE").val();
						obj.CHAT_CONTENT = CHAT_CONTENT;
						obj.MEMBER_CODE = $("#MY_MEMBER_CODE").val();
						jsonStr = JSON.stringify(obj);
						ws.send(jsonStr); // 전송
	
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
								
								if(msg.result > 0) {
									$(".chat-list").append('<li class="out">' +
																	'<div class="chat-img">' +
																		'<img class="from" src="' + $("#MY_IMG").val() + '">' +
																	'</div>' +
																	'<div class="chat-body">' +
																		'<div class="chat-message">' +
																			'<h5>' + $("#MY_NICKNAME").val() + '</h5>' +
																			'<p>' + msg.content + '</p>' +
																			'<small class="timestamp">' + dateInfo + '</small>' +
																		'</div>' +
			    													'</div>');						
								}
								
								$('.nano-content').scrollTop($('.nano-content').prop('scrollHeight'));
								
							},
							error: function() {
								alert("메세지 전송 통신 실패");
							}
						});
						
						$("#CHAT_CONTENT").val("");
						
					}
				
					return false;
				}
			}
			
		});
		
		
	});
	
	
	// 채팅메세지 리스트 불러오기
	var isEnd = false;
	var startNo = 1;
	
	function selectMsgList(bool) {
		
		var MY_MEMBER_CODE = $("#MY_MEMBER_CODE").val();
		
		if(isEnd == true) {
			return;
		}		
		
		$.ajax({
			type: "POST",
			url: "/SINGLE/chat/getMessageList.do",
			data: {
				CHATROOM_CODE : $("#CHATROOM_CODE").val(),
				MEMBER_CODE : MY_MEMBER_CODE,
				startNo : startNo
			},
			dataType: "JSON",
			success: function(msg) {
				
				startNo += msg.item.length;
				
				if(msg.item.length < 20) {
					isEnd = true;
				}
				
				if(bool) {	// 스크롤 페이징
					$.each(msg.item.reverse(), function(index, item) {
						console.log(item);
						
						if(item.CHATMESSAGE_FROM != MY_MEMBER_CODE) { // in
	
							$(".chat-list").prepend('<li class="in">' +
															'<div class="chat-img">' +
																'<img class="to" src="' + $("#TO_IMG").val() + '">' +
															'</div>' +
															'<div class="chat-body">' +
																'<div class="chat-message">' +
																	'<h5>' + $("#TO_NICKNAME").val() + '</h5>' +
																	'<p>' + item.CHATMESSAGE_CONTENT + '</p>' +
																	'<small class="timestamp">' + item.TIME + '</small>' +
																'</div>' +
															'</div>');
							
						} else if(item.CHATMESSAGE_FROM == MY_MEMBER_CODE) { // out
	
							$(".chat-list").prepend('<li class="out">' +
															'<div class="chat-img">' +
																'<img class="from" src="' + $("#MY_IMG").val() + '">' +
															'</div>' +
															'<div class="chat-body">' +
																'<div class="chat-message">' +
																	'<h5>' + $("#MY_NICKNAME").val() + '</h5>' +
																	'<p>' + item.CHATMESSAGE_CONTENT + '</p>' +
																	'<small class="timestamp">' + item.TIME + '</small>' +
																'</div>' +
															'</div>');
						}
						
					});
				}
				
				else {
					$.each(msg.item, function(index, item) {
						console.log(item);
						
						if(item.CHATMESSAGE_FROM != MY_MEMBER_CODE) { // in
	
							$(".chat-list").append('<li class="in">' +
															'<div class="chat-img">' +
																'<img class="to" src="' + $("#TO_IMG").val() + '">' +
															'</div>' +
															'<div class="chat-body">' +
																'<div class="chat-message">' +
																	'<h5>' + $("#TO_NICKNAME").val() + '</h5>' +
																	'<p>' + item.CHATMESSAGE_CONTENT + '</p>' +
																	'<small class="timestamp">' + item.TIME + '</small>' +
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
																	'<small class="timestamp">' + item.TIME + '</small>' +
																'</div>' +
															'</div>');
						}
						
						$('.nano-content').scrollTop($('.nano-content').prop('scrollHeight'));
					});
				}
				
			},
			error: function() {
				alert("메세지 가져오기 통신 실패");
			}
		});
	}
	

	// 채팅방 나간 순간 mylist의 CHATROOM_OUTDATE 수정하기
	function updateDate() {
		
		$.ajax({
			type: "POST",
			url: "/SINGLE/chat/updateOutDate.do",
			data: {
				CHATROOM_CODE : $("#CHATROOM_CODE").val(),
				MEMBER_CODE : $("#MY_MEMBER_CODE").val()
			},
			dataType: "JSON",
			success: function(msg) {
				
				if(msg.result > 0) {
					console.log("OUTDATE 수정 성공");
				} else {
					console.log("OUTDATE 수정 실패");
				}
			},
			error: function() {
				alert("OUTDATE 수정 통신 실패");
			}
		});
	}
	
	
	// 시간 00 포맷
	function isTwo(str) {
		return (str < 10) ? "0" + str : str;
	}
	
	
	// 오른쪽 메뉴
	function barOpen() {
		showMenu();
	}
	
	function showMenu() {
		$(".menu-wrap").animate({
			right: "0px"
		}, 500, function() {
			$("#cover-close-btn").css("display", "block");
		});
	}
	
	function hideMenu() {
		$(".menu-wrap").animate({
			right: "-100%"
		}, 500, function() {
			$("#cover-close-btn").css("display", "none");
		});
	}

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body onunload="updateDate();">

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
	<div class="container content">
	   	<div class="card">
	   	
	   		<!-- 헤더 -->
	      	<div class="card-header">
	      		<span class="card-title"></span><span id="bar-open-btn" onclick="barOpen();">참여자</span>
	      	</div>	      	
	      	
	      	<!-- 오른쪽 메뉴 -->
	      	<div class="menu-wrap">
	      		<a id="bar-close-btn" onclick="hideMenu();">닫기</a>
	      		
	      		<div id="member-list">
		      		<div>대화상대</div>
		      		<ul class="member-info list-group"></ul>
		      	</div>
	      	</div>
	      	
	      	<a id="cover-close-btn" onclick="hideMenu();"></a>
	      	
	      	<!-- 메세지 내용 창 -->
	      	<div class="nano has-scrollbar" style="height:570px">
	      		<div class="nano-content pad-all">
		        	<ul class="chat-list">        				
		        	</ul>
	        	</div>
	        </div>
	        
	        <!-- 메세지 입력/전송 창 -->
	        <div class="portlet-footer">
	        	<div class="row">
  						<div class="col-xs-9">
  							<input type="text" id="CHAT_CONTENT" placeholder="메세지를 입력해주세요." class="form-control form-control-sm">
  						</div>
   					<div class="col-xs-3">
   						<button class="btn btn-primary btn-sm" id="sendMessage" type="submit">전송</button>
   					</div>
  					</div>
	        </div>
			        
		</div>
	</div>
	<!-- END :: 채팅방 부트스트랩 -->

</body>
</html>