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

#reply_textarea, #reply_text_button{
	display:inline-block;
}

#resaleImage{
	width: 250px;
	height: 200px;
	text-align: center;
	overflow: hidden;
	-webkit-transform:scale(1);
    -moz-transform:scale(1);
    -ms-transform:scale(1); 
    -o-transform:scale(1);  
    transform:scale(1);
    -webkit-transition:.3s;
    -moz-transition:.3s;
    -ms-transition:.3s;
    -o-transition:.3s;
    transition:.3s;
}

#resaleImage:hover{
	-webkit-transform:scale(1.2);
    -moz-transform:scale(1.2);
    -ms-transform:scale(1.2);   
    -o-transform:scale(1.2);
    transform:scale(1.2);
}

#replyContent{
	resize: none;
}

#interest_list{
	float: right;
	color: #6495ed;
}

.title_bold{
	font-weight: bold;
}

#hope_price{
	color: #ff7f50;
	font-weight: bold;
}

thead{
	text-align:center;
}

#content{
	padding: 15px;
	height: 300px;
}

#img_box{
	text-align: center;
	margin: 30px;
}

.replyNickname{
	text-align: center;
} 

.replyRegdate{
	text-align: center;
}

.replyDelete{
	text-align: center;
}


</style>

<!-- END :: CSS -->
<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

	$(function(){
	
		$("#interest").click(function(){
			var RESALE_CODE = $("#RESALE_CODE").val();
			var MEMBER_CODE = $("#MEMBER_CODE").val();
			var confirmInterest = window.confirm("관심 등록 하시겠습니까?");
			
			// 관심등록
			if(confirmInterest){			
				// 관심등록 컨트롤러로 이동
				location.href="/SINGLE/board/interest.do?RESALE_CODE="+RESALE_CODE+"&MEMBER_CODE="+MEMBER_CODE;
			}
		});
	
		$("#alreadyInterest").click(function(){
			alert("본인의 매물은 관심등록 할 수 없습니다.");
			return false;
		});
	
		// 댓글 작성
		$('#replyWrite').click(function(){			
			
			var content = $("#replyContent").val();
			console.log(content);
			if(content.trim() == "" || content == null){
				alert("작성된 댓글이 없습니다.");
				return false;
			}
			
			$.ajax({
				type: "POST",
				url : "/SINGLE/board/replyWrite.do",
				data : {
					RESALE_CODE : $("#RESALE_CODE").val(),
					MEMBER_CODE : $("#MEMBER_CODE").val(),
					REPLY_CONTENT : content
				},
				dataType : "JSON",
				success : function(msg) {
					
					//SetLoadAjax_js(gubun);
					
					console.log("글쓰기 가져오기 성공");

						// alert(msg.REPLY_CODE);
						
						$("#replyTable").append(
							"<tr class='replyList'>"+
								"<td class='replyNickname'>"+msg.MEMBER_NICKNAME+"</td>"+
								"<td class='replyContent'>"+msg.REPLY_CONTENT+"</td>"+
								"<td class='replyRegdate'>"+msg.REPLY_REGDATE+"</td>"+
								"<td class='replyDelete'>"+
								"<form class='replyDelete' method='post'>"+
									"<input type='hidden' name='REPLY_CODE' value='${replyDto.REPLY_CODE }'/>"+
									"<input type='submit' class='btn btn-default btn-sm' value='삭제'/>"+
								"</form>"+
								"</td>"+
							"</tr>"					
						);   
						
					$("#replyContent").val('');	

				},
				error : function(request, status, error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
	
	
		// 댓글 삭제
		$('.replyDelete').submit(function(){
			
			var confirmDelete = window.confirm("삭제 하시겠습니까?");
			
			if(confirmDelete){
				
				$.ajax({
					type: "POST",
					url : "/SINGLE/board/replyDelete.do",
					data : {
						REPLY_CODE : $(this).find("input[name='REPLY_CODE']").val(),
					},
					dataType : "JSON",
					success : function(msg){
						
						if(msg.result > 0) {
							console.log(msg.result);
							$(".replyDelete").parent().parent().parent().parent().remove(); 
						} // if
						
					}, // success
					error : function(request, status, error){
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				}); // ajax
			}	
		});
	
	});
	


</script>
<!-- END :: JAVASCRIPT -->
</head>
<body>
	<input type="hidden" id="RESALE_CODE" value="${dto.RESALE_CODE }">
	<input type="hidden" id="MEMBER_CODE" value="${sessionLoginMember.MEMBER_CODE }${sessionLoginKakao.MEMBER_CODE }${sessionLoginNaver.MEMBER_CODE }">
	
	<div class="container">
		<a id="interest_list" href="/SINGLE/board/resaleInterestList.do?&MEMBER_CODE=${sessionLoginMember.MEMBER_CODE }${sessionLoginKakao.MEMBER_CODE }${sessionLoginNaver.MEMBER_CODE }" >관심 페이지로 가기</a>

		<!-- START :: 중고 게시판 글 목록 -->
		<div id="img_box">
			<img class="img-thumbnail" id="resaleImage" src="${pageContext.request.contextPath}/resources/resaleImages/${dto.RESALE_IMG_ORIGINAL }" style="float:none; margin:0 auto; text-align: center;" />
		</div>
	
		<table class="table table-bordered">
			<thead>
				<tr>
					<td class="title_bold">제목</td>
					<td>${dto.RESALE_TITLE }</td>
					<td class="title_bold" colspan="2">조회수</td>
					<td>${dto.RESALE_COUNTVIEW }</td>
				</tr>
				<tr>
					<td class="title_bold">작성자</td>
					<td>${memdto.MEMBER_NICKNAME }</td>
					<td class="title_bold" colspan="2">관심등록</td>
					<c:choose>
						<c:when test="${dto.MEMBER_CODE ne sessionLoginMember.MEMBER_CODE || dto.MEMBER_CODE ne sessionLoginKakao.MEMBER_CODE || dto.MEMBER_CODE ne sessionLoginNaver.MEMBER_CODE }">
							<td>
								<a href="#" id="interest">
									<img src="${pageContext.request.contextPath}/resources/images/icon/star.png" style="width:20px; height:20px;" />
								</a>
							</td>
						</c:when>
						<c:otherwise>
							<td>
								<a href="#" id="alreadyInterest">
									<img src="${pageContext.request.contextPath}/resources/images/icon/black_star.png" style="width:20px; height:20px;"/>
								</a>
							</td>
						</c:otherwise>
					</c:choose>
				</tr>
				<tr>
					<td class="title_bold">희망 가격</td>
					<td id="hope_price" colspan="5">${dto.RESALE_PRICE }원</td>
				</tr>
				<tr>
					<td class="title_bold">희망 주소</td>
					<td colspan="5">${dto.RESALE_ADDRESS }</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td id="content" colspan="6">
					 ${dto.RESALE_CONTENT }
					</td>
				</tr>
			</tbody>
		</table>

		<div style="text-align: center;">
			<input type="button" class="btn btn-outline-info" value="목록" onclick="location.href='/SINGLE/board/resalepage.do'"/>
			
			<c:if test="${dto.MEMBER_CODE eq sessionLoginMember.MEMBER_CODE || dto.MEMBER_CODE eq sessionLoginKakao.MEMBER_CODE || dto.MEMBER_CODE eq sessionLoginNaver.MEMBER_CODE }">
				<input type="button" class="btn btn-warning" value="수정" onclick="location.href='/SINGLE/board/resaleUpdate.do?&RESALE_CODE=${dto.RESALE_CODE }&RESALE_IMG_SERVER=${dto.RESALE_IMG_SERVER }'"/>
				<input type="button" class="btn btn-danger" value="삭제" onclick="location.href='/SINGLE/board/resaleDelete.do?&RESALE_CODE=${dto.RESALE_CODE }&RESALE_IMG_SERVER=${dto.RESALE_IMG_SERVER }'"/>
			</c:if>
		</div>
		<!-- END :: 중고 게시판 글 목록 -->
		
		<!-- START :: 중고 게시판 댓글 목록 -->
		<table id="replyTable" class="table table-bordered">
			
			<col width="20%"/>
			<col width="50%"/>
			<col width="20%"/>
			<col width="10%"/>
			
			<c:choose>
				<c:when test="${empty replyList }">
				</c:when>
				<c:otherwise>
						<c:forEach items="${replyList }" var="replyDto">
								<tr class="replyList">
									<td class="replyNickname">${replyDto.MEMBER_NICKNAME }</td>
									<td class="replyContent">${replyDto.REPLY_CONTENT }</td>
									<td class="replyRegdate">${replyDto.REPLY_REGDATE }</td>
									
										<c:if test="${replyDto.MEMBER_CODE eq sessionLoginMember.MEMBER_CODE || replyDto.MEMBER_CODE eq sessionLoginKakao.MEMBER_CODE || replyDto.MEMBER_CODE eq sessionLoginNaver.MEMBER_CODE}">
											<td class="replyDelete">
												<form class="replyDelete" method="post">
													<input type="hidden" name="REPLY_CODE" value="${replyDto.REPLY_CODE }"/>
													<span><input type="submit" class='btn btn-default btn-sm' value="삭제"/></span>
												</form>
											</td>	
										</c:if>
								</tr>								
						</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
		<!-- END :: 중고 게시판 댓글 목록 -->
		
		<!-- START :: 중고 게시판 댓글 입력 칸 -->
		<div id="reply_text_button" class="input-group mb-3 input-group-lg">
			<textarea class="form-control" rows="5" id="replyContent" placeholder="댓글을 입력하세요."></textarea>
			<div class="input-group-append">
				<button class="btn btn-info" type="submit" id="replyWrite">댓글 등록</button>
			</div>
		</div>
		<!-- END :: 중고 게시판 댓글 입력 칸 -->

	</div>
	
</body>
</html>