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

.item_body {
	margin-top: 50px;
	grid-template-columns : repeat(4, 1fr);
	display : grid;
}

#interest {
	float: right;
	color: #6495ed;
}

.image {
	width: 100%;
	height: 100%;
	overflow: hidden;
	cursor: pointer;
}

.img {
	width: 100%;
	height: 180px;
}

.more {
	text-align: center;
	margin-top: 50px;
}

h1 {
	display:inline-block;
}

h3 {
	display:inline-block;
}

.contents {
	cursor: pointer;
	padding : 16px;
	padding-bottom : 0px;
}

.container_list:hover {
	box-shadow: 0 3px 6px 0 rgba(0, 0, 0, 0.2), 0 5px 18px 0 rgba(0, 0, 0, 0.19);
}

.container_list {
	padding: 3px;
	border: 1px solid #dcdcdc;    
	border-top-left-radius: 3px; 
    border-bottom-left-radius: 3px;
    border-top-right-radius: 3px;
    border-bottom-right-radius: 3px;
    margin:5px;
}

.info {
	margin: 3px;
	color: #c0c0c0;
}

#item_title {
	color: #00bfff;
	font-size: 20px;
	font-weight: bold;
}

#item_price {
	color: #ff7f50;
	font-weight: bold;
}
	
b {
	font-size: 25px;
	color: #fa8072;
}
	

</style>
<!-- END :: CSS -->
<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>

	<div class="container">
			
		<div style="text-align: center;">
			<p style="color:#46b8da; font-size: 20pt;"><strong>동네 마켓 인기 매물</strong>
		</div>

		<div style="float:right;">
			<a id="interest" href="/SINGLE/board/resaleInterestList.do?&MEMBER_CODE=${sessionLoginMember.MEMBER_CODE }${sessionLoginKakao.MEMBER_CODE }${sessionLoginNaver.MEMBER_CODE }">관심 페이지로 가기</a>
		</div>
		
		<div class="item_body">
			<c:choose>
				<c:when test="${empty list }">
					<div class="container_item">작성된 아이템이 없습니다.</div>
				</c:when>
				<c:otherwise>
					<c:forEach items="${list}" var="dto">
						<div class="container_list">
							<div class="img"><img class="image" src="../resources/resaleImages/${dto.RESALE_IMG_ORIGINAL }" onclick="location.href='/SINGLE/board/resaleDetail.do?RESALE_CODE=${dto.RESALE_CODE}'" /></div>
							<div class="contents" onclick="location.href='/SINGLE/board/resaleDetail.do?RESALE_CODE=${dto.RESALE_CODE}'">
								<div class="info">
									<span>조회수 ${dto.RESALE_COUNTVIEW }</span>
									<span>관심도 ${dto.RESALE_LIKE }</span>
								</div>
								<div id="item_title">${dto.RESALE_TITLE }</div>
								<div id="item_price">${dto.RESALE_PRICE }</div>
								<div>${dto.RESALE_ADDRESS }</div>
							</div>
						</div>					
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
		
		<div class="more"><a href="/SINGLE/board/resalepage.do"><b>+ 더 많은 매물 보러가기 +</b></a></div>
	</div>
	
	<br/><br/>

<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->
</body>
</html>