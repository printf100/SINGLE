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
	
	.col-lg-5 {
		margin-right: 30px;
	}
	
	#find-member {
		margin-top: 20px;
	}
	
	.find-list {
		height: 150px;
	}
	
	.find-result {
		margin-top: 5px;
	}

	.find-info {
		margin-top: 5px;
		display: flex;
		margin-bottom: 0.25rem;
		padding: 0.6875rem 1rem 1rem 1rem;
		border-top: 0.0625rem solid #E9ECF3;
		border-bottom: 0.0625rem solid #E9ECF3;
		color: #263747;
	}
	
	.find-profile-img {
		position: relative;
		float: left;
		width: 2.5rem;
		height: 2.5rem;
		border-radius: 0.25rem;
	}
	
	#find-img {
		width: 100%;
		height: 100%;
		object-fit: cover;
	}	
	
	.chatnote {
		float: right;
	}
	
	.chatroom-verify li {
		cursor: pointer;
	}
	
	#createNtoN {
		margin-top: 10px;
		right: 5px;
	}
	
	.my-chatroom {
		margin-top: 30px;
	}
	
	.my-chatroom-list li {
		cursor: pointer;
		margin-top: 5px;
	}
	
	.nton-chatroom-list {
		margin-top: 30px;
	}
	
	.nton-chatroom-list li {
		cursor: pointer;
		margin-top: 5px;
	}
	
	.refresh {
		margin: 10px;
		text-align: center;
	}
	
	.refresh-icon {
		margin-left: 3px;
		width: 1.0rem;
		height: 1.0rem;
	}
	
	.ui-helper-hidden-accessible {
		position: absolute;
		left: -9999px;
	}
	
	.auto-list:hover {
		background: #E0FFFF;
	}
	
	.auto-list .ui-state-active {
	    background: #E0FFFF !important;
	    font-weight: bold !important;
	    color: black;
	    border: none;
	}

</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">

	$(function() {
		
		/*
		* 회원 찾기
		*/
		
		// 자동완성
		$("#MEMBER_ACCOUNT").autocomplete({
			source: function(request, response) {
				$.ajax({
					type: "POST",
					url: "/SINGLE/chat/findMember.do",
					data: {
						MEMBER_ACCOUNT : request.term,
						MEMBER_CODE : $("#MY_MEMBER_CODE").val()
					},
					dataType: "JSON",
					success: function(msg) {
						response(
							$.map(msg.jArray, function(item) {
								//console.log(item);
								//console.log(item.nickname);
								return {
									profileimg: item.profileimg,
									nickname: item.nickname,
									email: item.email,
									value: item.nickname
								}
							})
						);
					}
				});
			},
			minLength: 1,
			select: function(event, ui) {
				event.preventDefault();
				$("#MEMBER_ACCOUNT").val(ui.item.label);
				
				 $("#MEMBER_ACCOUNT").keyup(function(e){
					 if(e.keyCode == 13) {
						 $("#MEMBER_ACCOUNT").val(ui.item.label);
					 }
				 });
			},
			focus: function(event, ui) {
				event.preventDefault();
				$("#MEMBER_ACCOUNT").val(ui.item.label);
				
				$("#MEMBER_ACCOUNT").keyup(function(e){
					 if(e.keyCode == 13) {
						 $("#MEMBER_ACCOUNT").val(ui.item.label);
					 }
				 });
			}
			
		}).autocomplete("instance")._renderItem = function(ul, item) {
			ul.attr({
				"class" : "auto-ul list-group"
			});
			
			var list = $("<div>");
			
			var img = $("<div>").attr({
				"class" : "find-profile-img"
			}).append("<img>").attr({
				"src" : "../resources/images/profileimg/" + item.profileimg
			});
			
			var info = $("<div>").attr({
				"class" : "info-text"
			});
			
			var nickname = $("<h6>").text(item.nickname);
			var email = $("<h6>").text(item.email);
			
			return $("<li>").attr({
				"class" : "auto-list list-group-item",
				"style" : "width: 500px"
			}).append(list.append(img).append(info.append(nickname).append(email)))
			.appendTo(ul);
		};
		
		
		// 회원 검색 버튼 클릭
		$(".chatnote button").css("display", "none");
		$("#findbtn").attr("disabled", "disabled");
		
		$("#MEMBER_ACCOUNT").keyup(function(e) {
			e.preventDefault();
			
			var MEMBER_ACCOUNT = $("#MEMBER_ACCOUNT").val();
			
			if(MEMBER_ACCOUNT != null && MEMBER_ACCOUNT != ""){
				
				$("#findbtn").removeAttr("disabled");
				
				var code = e.keyCode ? e.keyCode : e.which;
				
				if(code == 13) {	// 엔터키
					
					// 회원 찾기
					$.ajax({
						type: "POST",
						url: "/SINGLE/chat/findMember.do",
						data: {
							MEMBER_ACCOUNT : $("#MEMBER_ACCOUNT").val(),
							MEMBER_CODE : $("#MY_MEMBER_CODE").val()
						},
						dataType: "JSON",
						success: function(msg) {
							
							if(msg.result > 0) {
								$(".find-result").text("회원 찾기를 성공하였습니다.");
								
								$.each(msg.jArray, function(index, item) {
									
									$("#TO_MEMBER_CODE").val(item.TO_MEMBER_CODE);
									$("#TO_MEMBER_NICKNAME").val(item.nickname);
									
									$(".find-profile-img").children().remove();
									$(".find-profile-img").append($("<img id='find-img'>").attr("src", "../resources/images/profileimg/" + item.profileimg));							
									
									$(".find-nickname").text(item.nickname);
									$(".find-email").text(item.email);
									$(".find-introduce").text(item.introduce);
								});
														
								$(".chatnote button").css("display", "");
								
							} else {
								$(".find-result").text("회원을 찾을 수 없습니다.");
							}
						},
						error: function() {
							alert("회원 찾기 통신 실패");
						}
					});
				}
			}
		});
		
		
		/*
		* 쪽지 보내기
		*/
		
		$("#one-note").click(function() {
			
			console.log($("#TO_MEMBER_NICKNAME").val());
			
			// 쪽지 팝업창 띄우기
			var url = "/SINGLE/views/note/sendnote.jsp";
			var title = "";
			var prop = "top=200px,left=600px,width=580px,height=620px";
			window.open(url, title, prop);
		});
		
		
		/*
		* 내 일대일 채팅
		*/
		// 회원찾기 후 채팅하기 눌러서 일대일 채팅하기
 		$("#one-to-one").click(function() {
 			
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
 						alert("기존 채팅방을 불러옵니다.");
 						$("#CHATROOM_CODE").val(msg.CHATROOM_CODE);
 					} else {
 						alert("채팅방을 새로 생성합니다.");
 						$("#CHATROOM_CODE").val(msg.CHATROOM_CODE);
 					}
 					
 					// 채팅방 팝업창 띄우기
 					var url = "/SINGLE/views/chat/chatroom.jsp";
 				    var title = "";
 				    var prop = "top=150px,left=600px,width=500px,height=670px";
 				    window.open(url, title, prop);
 				}
 			});
		});

		// 내가 참여중인 일대일 채팅방 리스트 가져오기
		$("#myOnetoOneList").click(function() {
			
			$(".my-chatroom-list").children().remove();
			
			$.getJSON("/SINGLE/chat/getMyOnetoOneChatList.do", {
				MY_MEMBER_CODE : $("#MY_MEMBER_CODE").val()
			}).done(function(data) {				
				console.log(data);
				
				$.each(data.list, function(index, item) {
					console.log(item);
					
					// 각각의 리스트 div
					var list = $("<li>").attr({
						"class" : "onechatroom-list-detail list-group-item d-flex justify-content-between align-items-center"
					}).append($("<input>").attr({
						"type" : "hidden",
						"name" : "CHATROOM_CODE",
						"value" : item.CHATROOM_CODE
					}).append($("<input>").attr({
						"type" : "hidden",
						"name" : "TO_MEMBER_CODE",
						"value" : item.MEMBER_CODE
					})));
					
					// 상대방 닉네임
					var list_title = $("<a>").attr({
						"class" : "chatroom-title nav-link active"
					}).text(item.MEMBER_NICKNAME);
					
					// 읽지 않은 메세지 갯수
					var unread = $("<span>").attr({
						"class" : "badge badge-primary badge-pill"
					}).text(item.UNREAD);
					
					$(".my-chatroom-list").append(list.append(list_title).append(unread));
				});
			});			
		});
		
		// 일대일 채팅방 들어가기
		$(document).on("click", ".onechatroom-list-detail", function() {
			
			var CHATROOM_CODE = $(this).find("input[name='CHATROOM_CODE']").val();
			$("#CHATROOM_CODE").val(CHATROOM_CODE);
			
			var TO_MEMBER_CODE = $(this).find("input[name='TO_MEMBER_CODE']").val();
			$("#TO_MEMBER_CODE").val(TO_MEMBER_CODE);
			
			var MY_MEMBER_CODE = $("#MY_MEMBER_CODE").val();
			$("#MY_MEMBER_CODE").val(MY_MEMBER_CODE);
			
			// 채팅방 팝업창 띄우기
			var url = "/SINGLE/views/chat/chatroom.jsp";
			var title = "";
			var prop = "top=150px,left=600px,width=500px,height=670px";
			window.open(url, title, prop);
		});
		
		
		/*
		* 내 다대다 채팅방
		*/
		// 내가 참여중인 다대다 채팅방 리스트 가져오기
		$("#myNtoNList").click(function() {
			
			$(".my-chatroom-list").children().remove();
			
			var createNtoN = $("<button>").attr({
				"type" : "button",
				"id" : "createNtoN",
				"class" : "btn btn-info",
				"style" : "width: 100%;"
			}).text("단체 채팅방 만들기 +");
			
			$(".my-chatroom-list").append(createNtoN);
			
			$.getJSON("/SINGLE/chat/getMyNtoNChatList.do", {
				MY_MEMBER_CODE : $("#MY_MEMBER_CODE").val()
			}).done(function(data) {
				
				$.each(data.list, function(index, item) {
					console.log(item);
					
					// 각각의 리스트 div
					var list = $("<li>").attr({
						"class" : "nchatroom-list-detail list-group-item d-flex justify-content-between align-items-center"
					}).append($("<input>").attr({
						"type" : "hidden",
						"name" : "CHATROOM_CODE",
						"value" : item.CHATROOM_CODE
					}).append($("<input>").attr({
						"type" : "hidden",
						"name" : "CHATROOM_TITLE",
						"value" : item.CHATROOM_TITLE
					}).append($("<input>").attr({
						"type" : "hidden",
						"name" : "CHATROOM_MEMBER_COUNT",
						"value" : item.CHATROOM_MEMBER_COUNT
					}).append($("<input>").attr({
						"type" : "hidden",
						"name" : "CHATROOM_CHIEF_CODE",
						"value" : item.CHATROOM_CHIEF_CODE
					})))));
					
					// 채팅방 제목
					var list_title = $("<a>").attr({
						"class" : "chatroom-title nav-link active",
						"name" : "CHATROOM_TITLE"
					}).text(item.CHATROOM_TITLE + "  ");
					
					// 채팅방 참여자수
					var member_count = $("<span>").attr({
						"class" : "chatroom-member",
						"name" : "CHATROOM_MEMBER_COUNT",
						"style" : "font-size: 5pt; color: gray;"
					}).text(item.CHATROOM_MEMBER_COUNT);

					// 읽지 않은 메세지 갯수
					var unread = $("<span>").attr({
						"class" : "badge badge-primary badge-pill"
					}).text(item.UNREAD);
					
					$(".my-chatroom-list").append(list.append(list_title.append(member_count)).append(unread));
				});
			});
		});
		
		// 다대다 채팅방 들어가기
		$(document).on("click", ".nchatroom-list-detail", function() {
			
			var CHATROOM_CODE = $(this).find("input[name='CHATROOM_CODE']").val();
			$("#CHATROOM_CODE").val(CHATROOM_CODE);
			
			var CHATROOM_TITLE = $(this).find("input[name='CHATROOM_TITLE']").val();
			$("#CHATROOM_TITLE").val(CHATROOM_TITLE);
			
			var CHATROOM_MEMBER_COUNT = $(this).find("input[name='CHATROOM_MEMBER_COUNT']").val();
			$("#CHATROOM_MEMBER_COUNT").val(CHATROOM_MEMBER_COUNT);
			
			var CHATROOM_CHIEF_CODE = $(this).find("input[name='CHATROOM_CHIEF_CODE']").val();
			$("#CHATROOM_CHIEF_CODE").val(CHATROOM_CHIEF_CODE);
			
			var MY_MEMBER_CODE = $("#MY_MEMBER_CODE").val();
			$("#MY_MEMBER_CODE").val(MY_MEMBER_CODE);
			
			// 참여했던 채팅방인지 검사
			$.ajax({
				type: "POST",
				url: "/SINGLE/chat/nChatChk.do",
				data: {
					CHATROOM_CODE : CHATROOM_CODE,
					MEMBER_CODE : MY_MEMBER_CODE
				},
				dataType: "JSON",
				success: function(msg) {
					
					if(msg.result > 0) {
						alert("이미 참여중인 채팅방이에요!");

						// 채팅방 팝업창 띄우기
						var url = "/SINGLE/views/chat/nchatroom.jsp";
						var title = "";
						var prop = "top=150px,left=600px,width=500px,height=670px";
						window.open(url, title, prop);
						
					} else {
						// 예 누를 시 mylist에 insert
						if(confirm("채팅방에 참여할까요?")) {
							alert("채팅방에 참여합니다!");
							
							$.ajax({
								type: "POST",
								url: "/SINGLE/chat/nChatRoompage.do",
								data: {
									CHATROOM_CODE : CHATROOM_CODE,
									MEMBER_CODE : MY_MEMBER_CODE
								},
								dataType: "JSON",
								success: function(msg) {
									
									if(msg.result > 0) {
										console.log("mylist insert 성공");
									} else {
										console.log("mylist insert 실패");
									}
									
								},
								error: function() {
									alert("채팅방 참여 통신 실패");
								}
							});
							
							// 채팅방 팝업창 띄우기
							var url = "/SINGLE/views/chat/nchatroom.jsp";
							var title = "";
							var prop = "top=150px,left=600px,width=500px,height=670px";
							window.open(url, title, prop);
						}
					}					
				},
				error: function() {
					alert("다대다 채팅방 검사 통신 실패");
				}
			});
			

		});
		
 		// 다대다 채팅방 만들기
 		$(document).on('click', "#createNtoN", function() {
 			
 			// 단체 채팅방 생성하는 팝업창 띄우기
			var url = "/SINGLE/views/chat/createNtoN.jsp";
			var title = "";
			var prop = "top=200px,left=600px,width=585px,height=300px";
			window.open(url, title, prop);
 		});
 		
 		// 다대다 채팅방 전체 리스트 불러오기
 		$.getJSON("/SINGLE/chat/getNChatList.do").done(function(data) {
 			
			$.each(data, function(index, item) {
				console.log(item);
				
				// 각각의 리스트 div
				var list = $("<li>").attr({
					"class" : "nchatroom-list-detail list-group-item"
				}).append($("<input>").attr({
					"type" : "hidden",
					"name" : "CHATROOM_CODE",
					"value" : item.CHATROOM_CODE
				}).append($("<input>").attr({
					"type" : "hidden",
					"name" : "CHATROOM_TITLE",
					"value" : item.CHATROOM_TITLE
				}).append($("<input>").attr({
					"type" : "hidden",
					"name" : "CHATROOM_MEMBER_COUNT",
					"value" : item.CHATROOM_MEMBER_COUNT
				}).append($("<input>").attr({
					"type" : "hidden",
					"name" : "CHATROOM_CHIEF_CODE",
					"value" : item.CHATROOM_CHIEF_CODE
				})))));
				
				// 채팅방 제목 div
				var list_title = $("<a>").attr({
					"class" : "chatroom-title",
				}).text(item.CHATROOM_TITLE + " ( " + item.CHATROOM_MEMBER_COUNT + "명 )");
				
				$(".nton-chatroom-list").append(list.append(list_title));
			});
		});
 		
 		
 		/*
 		* 전체 다대다 채팅방
 		*/
		// 다대다 채팅방 전체 리스트 새로고침
 		$(document).on("click", "#getNewList", function() {
 			$(".nton-chatroom-list").children().remove();
 			
 	 		$.getJSON("/SINGLE/chat/getNChatList.do").done(function(data) {
 				
 				$.each(data, function(index, item) {
 					console.log(item);
 					
	 				// 각각의 리스트 div
					var list = $("<li>").attr({
						"class" : "nchatroom-list-detail list-group-item"
					}).append($("<input>").attr({
						"type" : "hidden",
						"name" : "CHATROOM_CODE",
						"value" : item.CHATROOM_CODE
					}).append($("<input>").attr({
						"type" : "hidden",
						"name" : "CHATROOM_TITLE",
						"value" : item.CHATROOM_TITLE
					}).append($("<input>").attr({
						"type" : "hidden",
						"name" : "CHATROOM_MEMBER_COUNT",
						"value" : item.CHATROOM_MEMBER_COUNT
					}).append($("<input>").attr({
						"type" : "hidden",
						"name" : "CHATROOM_CHIEF_CODE",
						"value" : item.CHATROOM_CHIEF_CODE
					})))));
 					
 					// 채팅방 제목 div
 					var list_title = $("<a>").attr({
 						"class" : "chatroom-title"
 					}).text(item.CHATROOM_TITLE + " ( " + item.CHATROOM_MEMBER_COUNT + "명 )");
 					
 					$(".nton-chatroom-list").append(list.append(list_title));
 				});
 			});
 		});
		
		// 다대다 채팅방 검색 버튼 클릭
		$("#searchbtn").attr("disabled", "disabled");
		
		$("#SEARCH_CHATROOM_TITLE").keyup(function(e) {
			e.preventDefault();
			
			var SEARCH_CHATROOM_TITLE = $("#SEARCH_CHATROOM_TITLE").val();
			
			if(SEARCH_CHATROOM_TITLE != null && SEARCH_CHATROOM_TITLE != "") {
				
				$("#searchbtn").removeAttr("disabled");
				
				var code = e.keyCode ? e.keyCode : e.which;
				
				if(code == 13) {	// 엔터키
					
					$(".nton-chatroom-list").children().remove();
		 			
					$.ajax({
						type: "POST",
						url: "/SINGLE/chat/searchNChatRoom.do",
						data: {
							SEARCH_CHATROOM_TITLE : SEARCH_CHATROOM_TITLE
						},
						dataType: "JSON",
						success: function(msg) {
							
							if(msg.result > 0) {
								$(".find-result").text("채팅방 검색을 완료하였습니다.");
		 				
				 				$.each(data, function(index, item) {
				 					console.log(item);
				 					
					 				// 각각의 리스트 div
									var list = $("<li>").attr({
										"class" : "nchatroom-list-detail list-group-item"
									}).append($("<input>").attr({
										"type" : "hidden",
										"name" : "CHATROOM_CODE",
										"value" : item.CHATROOM_CODE
									}).append($("<input>").attr({
										"type" : "hidden",
										"name" : "CHATROOM_TITLE",
										"value" : item.CHATROOM_TITLE
									}).append($("<input>").attr({
										"type" : "hidden",
										"name" : "CHATROOM_MEMBER_COUNT",
										"value" : item.CHATROOM_MEMBER_COUNT
									}).append($("<input>").attr({
										"type" : "hidden",
										"name" : "CHATROOM_CHIEF_CODE",
										"value" : item.CHATROOM_CHIEF_CODE
									})))));
				 					
				 					// 채팅방 제목 div
				 					var list_title = $("<a>").attr({
				 						"class" : "chatroom-title"
				 					}).text(item.CHATROOM_TITLE + " ( " + item.CHATROOM_MEMBER_COUNT + "명 )");
				 					
				 					$(".nton-chatroom-list").append(list.append(list_title));
				 				
				 				});
				 				
							} else {
								alert("검색된 채팅방이 없습니다.");
							}
						},
						error: function() {
							alert("채팅방 검색 통신 실패");
						}
		 			});
				}
			}
		});
 		
	});
	
</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>
	
	<div class="container">
		<div class="row">
			<div class="my-list col-lg-6">
				<!-- START :: 회원 찾기 -->
				<button type="button" class="btn btn-info" data-toggle="collapse" data-target="#find-member">회원 찾기</button>
				
				<div id="find-member" class="form-group collapse">
					<div class="input-group input-group-sm">
						<input type="text" size="30" class="form-control" id="MEMBER_ACCOUNT" name="MEMBER_ACCOUNT" placeholder="찾을 회원의 닉네임 또는 이메일을 입력해주세요." required="required">
						<div class="input-group-append">
							<button type="button" id="findbtn" class="btn btn-info">
						    	<span class="glyphicon glyphicon-search"></span> 검색
						    </button>
						</div>
					</div>
					
					<!-- 찾은 회원 정보 -->
					<div class="find-list">
						<div class="find-result"></div>
						<div class="find-info">					
							<div class="find-profile-img"></div>
							<div class="info-text">
								<h6 class="find-nickname"></h6>
								<h6 class="find-email"></h6>
								<h6 class="find-introduce"></h6>
							</div>
							<div class="chatnote">
								<button type="button" class="btn btn-outline-info btn-sm" id="one-to-one">채팅하기</button>
								<button type="button" class="btn btn-outline-info btn-sm" id="one-note">쪽지 보내기</button>
							</div>
						</div>
					</div>
				</div>
				<!-- END :: 회원 찾기 -->
	
				<!-- START :: 내가 참여중인 채팅방 리스트 -->
				<div class="my-chatroom">
					<ul class="chatroom-verify nav nav-tabs nav-justified">
						<li class="nav-item"><a id="myOnetoOneList" class="nav-link" data-toggle="tab">1:1 채팅방</a>
						<li class="nav-item"><a id="myNtoNList" class="nav-link" data-toggle="tab">단체 채팅방</a>
					</ul>
					<ul class="my-chatroom-list list-group">
					</ul>
				</div>
				<!-- END :: 내가 참여중인 채팅방 리스트 -->
			</div>
			
			
			<!-- START :: 존재하는 모든 다대다 채팅방 리스트 -->
			<div class="nton-chatroom col-lg-6 form-group">
				<div class="input-group">
					<input type="text" size="30" class="form-control" id="SEARCH_CHATROOM_TITLE" placeholder="찾고 싶은 방 제목을 입력해주세요." required="required">
					<div class="input-group-append">
						<button type="button" class="btn btn-info" id="searchbtn">
					    	<span class="glyphicon glyphicon-search">채팅방 검색</span>
					    </button>
					</div>
				</div>
				
				<div class="refresh">
					<a id="getNewList">목록 새로고침<img class="refresh-icon" src="../resources/images/icon/refresh.png"></a>
				</div>
				
				<ul class="nton-chatroom-list list-group">
				</ul>
			</div>
			<!-- END :: 존재하는 모든 다대다 채팅방 리스트 -->
		</div>
	</div>
	
	<!-- 채팅창에 전달할 값들 -->
	<input type="hidden" id="MY_MEMBER_CODE" value="${sessionLoginMember.MEMBER_CODE }${sessionLoginKakao.MEMBER_CODE }${sessionLoginNaver.MEMBER_CODE }">
	<input type="hidden" id="MY_IMG" value="../resources/images/profileimg/${profile.MPROFILE_IMG_SERVERNAME }">
	<input type="hidden" id="MY_NICKNAME" value="${profile.MEMBER_NICKNAME }">
	
	<input type="hidden" id="TO_MEMBER_CODE">
	<input type="hidden" id="TO_MEMBER_NICKNAME">
	
	<input type="hidden" id="CHATROOM_CODE">
	<input type="hidden" id="CHATROOM_TITLE">
	<input type="hidden" id="CHATROOM_MEMBER_COUNT">
	<input type="hidden" id="CHATROOM_CHIEF_CODE">

<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->

</body>
</html>