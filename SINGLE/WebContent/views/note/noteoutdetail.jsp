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

<!-- START :: CSS -->
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
	
	ul .nav-pills {
    	top: 20px;
    	position: fixed;
    }
    
    .col-sm-8 {
    	height: 500px;
    }
    
    .contents-btn {
    	margin-bottom: 20px;
    }
    
    .contents {
    	border-top: 1px solid rgba(0,0,0,.2);
    	padding: 10px;
    }
    
    .info {
    	margin-left: 20px;
    }

</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

	$(function() {
		
		/*
		* 안 읽은 받은 쪽지 갯수
		*/
		
		$.ajax({
			type: "POST",
			url: "/SINGLE/note/noteInUnread.do",
			data: {
				MEMBER_CODE : $("#MY_MEMBER_CODE").val()
			},
			dataType: "JSON",
			success: function(msg) {
				
				$(".badge").text(msg.inUnread);
			},
			error: function() {
				alert("통신 실패");
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
		* 쪽지 삭제하기
		*/
		
		$("#delete").click(function() {
			
			if(confirm("쪽지를 삭제할까요?")) {
				
				$.ajax({
					type: "POST",
					url: "/SINGLE/note/deleteNote.do",
					data: {
						NOTE_CODE : $("#NOTE_CODE").val()
					},
					dataType: "JSON",
					success: function(msg) {
						
						if(msg.result > 0) {
							alert("쪽지를 삭제했어요!");
							
							location.href="/SINGLE/note/noteInList.do";
						} else {
							alert("쪽지 삭제를 실패하였습니다.");
						}
					},
					error: function() {
						alert("쪽지 삭제 통신 실패");
					}
				});
			}
		});
	});

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>

	<div class="container">
		<div class="row">
		
			<!-- 왼쪽 메뉴 바 -->
			<div class="col-sm-3">
				<ul class="list-group" id="myScrollspy">
					<li class="list-group-item d-flex justify-content-between align-items-center">
						<a class="nav-link active" href="/SINGLE/note/noteInList.do">받은 쪽지함</a>
						<span class="badge badge-primary badge-pill"></span>
			        </li>
			        <li class="list-group-item d-flex justify-content-between align-items-center">
			        	<a class="nav-link" href="/SINGLE/note/noteOutList.do">보낸 쪽지함</a>
			        </li>
			     </ul>
			</div>
			
			<!-- 콘텐츠 -->
			<div class="col-sm-8">
				<div class="contents-btn">
					<button type="button" id="delete" class="btn btn-outline-warning btn-sm">삭제</button>
					<button type="button" id="one-note" class="btn btn-info btn-sm">쪽지 보내기</button>
				</div>
				
				<div class="contents">
					<div class="form-group">
						<span style="font-size: 15pt;"><strong>${out.NOTE_TITLE }</strong></span><span style="color: #666666; font-size: 10pt; float: right;">${out.NOTE_SENDDATE }</span>
					</div>
					
					<div class="form-group">
						<label for="NOTE_TO_NICKNAME">받는 사람</label><span class="info" style="color: #666666;">${out.NOTE_TO_NICKNAME }</span>
					</div>
					
					<hr>
					
					<div class="form-group">
					    <p>${out.NOTE_CONTENT }
					</div>
				</div>
				
			</div>
		</div>
	</div>
	
	<input type="hidden" id="MY_MEMBER_CODE" value="${sessionLoginMember.MEMBER_CODE }${sessionLoginKakao.MEMBER_CODE }${sessionLoginNaver.MEMBER_CODE }">
	
	<input type="hidden" id="TO_MEMBER_NICKNAME" value="${out.NOTE_TO_NICKNAME }">
	<input type="hidden" id="TO_MEMBER_CODE" value="${out.NOTE_TO_CODE }">

	<input type="hidden" id="NOTE_CODE" value="${out.NOTE_CODE }">


<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->

</body>
</html>