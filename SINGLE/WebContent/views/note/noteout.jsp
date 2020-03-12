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
<title>SINGLE</title>

<style type="text/css">

	body {
		position: relative;
	}

	.col-sm-3 {
		margin: 20px;
	}
	
	.list-group a {
		color: #263747;
	}
  	
  	table a {
		color: #263747;
	}
	
  	ul .nav-pills {
    	top: 20px;
    	position: fixed;
    }
  	
  	#noteSearch {
  		margin-top: 20px;
  		margin-bottom: 20px;
  	}
  	
  	 /* 회원 찾기 */
  	#find-member {
		margin-top: 20px;
		height: 150px;
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

</style>

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">

	$(function() {
		
		// 쪽지 검색하기
		$("#noteSearch").keyup(function() {
			var value = $(this).val().toLowerCase();
		    
			$("#outList tr").filter(function() {
				$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
		    });
		});
		
		
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
				"src" : "${pageContext.request.contextPath}/resources/images/profileimg/" + item.profileimg
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
									$(".find-profile-img").append($("<img id='find-img'>").attr("src", "${pageContext.request.contextPath}/resources/images/profileimg/" + item.profileimg));							
									
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
		
	});

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body data-spy="scroll" data-target="#myScrollspy" data-offset="1">

	<div class="container">
		<div class="row">
		
			<!-- 왼쪽 메뉴 바 -->
			<div class="col-sm-3">
				<ul class="list-group" id="myScrollspy">
					<li class="list-group-item d-flex justify-content-between align-items-center">
						<a class="nav-link active" href="/SINGLE/note/noteInList.do">받은 쪽지함</a>
						<span class="badge badge-primary badge-pill">${inUnread }</span>
			        </li>
			        <li class="list-group-item d-flex justify-content-between align-items-center">
			        	<a class="nav-link" href="/SINGLE/note/noteOutList.do">보낸 쪽지함</a>
			        </li>
			     </ul>
			</div>
			
			<!-- 콘텐츠 -->
			<div class="col-sm-8">
				<p style="font-size: 25pt;"><strong>보낸 쪽지함</strong>	<span style="color: black; font-size: 15pt;">${outAll }</span>
				
				<input class="form-control" id="noteSearch" type="text" placeholder="쪽지 검색">
				
				<table class="table table-bordered">
					<col width="50">
					<col width="100">
					<col width="50">
					<col width="50">
					<thead>
						<tr>
							<th>받는 사람</th>
							<th>제목</th>
							<th>날짜</th>
							<th>읽음</th>
						</tr>
					</thead>
					
					<tbody id="outList">
						<c:choose>
							<c:when test="${empty outList }">
								<tr>
									<th colspan="4">보낸 쪽지가 없습니다.</th>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${outList }" var="out">
									<tr>
										<td>${out.NOTE_TO_NICKNAME }</td>
										<td><a href="/SINGLE/note/noteOutDetailpage.do?NOTE_CODE=${out.NOTE_CODE }">${out.NOTE_TITLE }</a></td>
										<td>${out.NOTE_SENDDATE }</td>
										<td>${out.NOTE_READ }</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				
				<!-- START :: 회원 찾기 -->
				<button type="button" class="btn btn-info btn-sm" data-toggle="collapse" data-target="#find-member">회원 찾기</button>
				
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
				
			</div>
		</div>
	</div>
	
	<input type="hidden" id="MY_MEMBER_CODE" value="${sessionLoginMember.MEMBER_CODE }${sessionLoginKakao.MEMBER_CODE }${sessionLoginNaver.MEMBER_CODE }">
	<input type="hidden" id="MY_IMG" value="${pageContext.request.contextPath}/resources/images/profileimg/${sessionLoginMember.MPROFILE_IMG_SERVERNAME }${sessionLoginKakao.MPROFILE_IMG_SERVERNAME }${sessionLoginNaver.MPROFILE_IMG_SERVERNAME }">
	<input type="hidden" id="MY_NICKNAME" value="${sessionLoginMember.MEMBER_NICKNAME }${sessionLoginKakao.MEMBER_NICKNAME }${sessionLoginNaver.MEMBER_NICKNAME }">
	
	<input type="hidden" id="TO_MEMBER_CODE">
	<input type="hidden" id="TO_MEMBER_NICKNAME">
	
	<input type="hidden" id="CHATROOM_CODE">

<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->

</body>
</html>