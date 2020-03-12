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
<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
</script>
<!-- END :: JAVACRIPT -->
<!-- START :: CSS -->
<style type="text/css">

.container {
	height: auto;
	padding: 20px;
}

.box{
	grid-template-columns : repeat(4, 1fr);
	display : grid;
	margin: 0px;
	padding: 0px;
	width: auto;
}
	
.item_body {
	margin-top: 30px;
	grid-template-columns : repeat(4, 1fr);
	display : grid;
}

#interest{
	float: right;
	color: #6495ed;
}

.image{
	width: 100%;
	height: 100%;
	overflow: hidden;
	cursor: pointer;
}

.img{
	width: 100%;
	height: 180px;
}

.more{
	width: 100%;
	line-height: 80%;
	text-align: center;
}

h1{
	display:inline-block;
}

h3{
	display:inline-block;
}

.contents{
	cursor: pointer;
	padding : 16px;
	padding-bottom : 0px;
}

.container_list:hover{
	box-shadow: 0 3px 6px 0 rgba(0, 0, 0, 0.2), 0 5px 18px 0 rgba(0, 0, 0, 0.19);
}

.container_list{
	padding: 3px;
	border: 1px solid #dcdcdc;    
	border-top-left-radius: 3px; 
    border-bottom-left-radius: 3px;
    border-top-right-radius: 3px;
    border-bottom-right-radius: 3px;
    margin:5px;
}

.info{
	margin: 3px;
	color: #c0c0c0;
}

#item_title{
	color: #00bfff;
	font-size: 20px;
	font-weight: bold;
}

#item_price{
	color: #ff7f50;
	font-weight: bold;
}
	
b{
	font-size: 25px;
	color: #fa8072;
}

</style>
<!-- END :: CSS -->

</head>
<body>

<body>

	<div class="container">
	
		<div style="text-align: center;">
			<a id="resale" href="/SINGLE/board/resaleMainList.do">
				<img style="width:42px; height:42px;"src="${pageContext.request.contextPath}/resources/images/icon/buy.png">
			</a>
		</div>
		
		<div style="margin-top: 30px;">
			<div style="float: left;">
				<input type="button" class="btn btn-info" value="매물 등록하기" onclick="location.href='/SINGLE/board/resaleWrite.do';">
			</div>	
			
			<div style="float:right;">
				<a id="interest" href="/SINGLE/board/resaleInterestList.do?&MEMBER_CODE=${sessionLoginMember.MEMBER_CODE }${sessionLoginKakao.MEMBER_CODE }${sessionLoginNaver.MEMBER_CODE }">관심 페이지로 가기</a>
			</div>
			
			<div style="text-align: center;">
				<form action="/SINGLE/board/resalepage.do" method="post">
					<select name="option">
						<option value="0" <c:if test="${option=='0' }">selected</c:if>>제목</option>
						<option value="1" <c:if test="${option=='1' }">selected</c:if>>내용</option>
						<option value="2" <c:if test="${option=='2' }">selected</c:if>>제목+내용</option>
						<option value="3" <c:if test="${option=='3' }">selected</c:if>>작성자</option>
					</select>
					<c:choose>
						<c:when test="${condition eq null }">
							<input type="text" size="30" name="condition"/>
						</c:when>
						<c:otherwise>
							<input type="text" size="30" name="condition" value="${condition }"/>
						</c:otherwise>
					</c:choose>
					&nbsp;
					<span><input class="btn btn-secondary btn-sm" type="submit" value="검색"/></span>
				</form>
			</div>
			
			<div class="item_body">
				<c:choose>
					<c:when test="${empty ResaleBoardList }">
						<div class="container_item">작성된 아이템이 없습니다.</div>
					</c:when>
					<c:otherwise>
						<c:forEach items="${ResaleBoardList}" var="dto">
							<div class="container_list">
								<div class="img"><img class="image" src="${pageContext.request.contextPath}/resources/resaleImages/${dto.RESALE_IMG_ORIGINAL }" onclick="location.href='/SINGLE/board/resaleDetail.do?RESALE_CODE=${dto.RESALE_CODE}'"/></div>
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
		
			<ul class="pagination justify-content-center">
				<c:set var="option" value="${option }"/>
				<c:set var="condition" value="${condition }"/>
				
				<c:if test="${curPageNum > 5 }">
					<c:if test="${condition != null }">
						<p>${condition }</p>
						<li class="page-item">
							<a class="page-link" href="/SINGLE/board/resalepage.do?curPage=${blockStartNum -1 }&option=${option}&condition=${condition}">Previous</a>
						</li>
					</c:if>
					<c:if test="${condition == null }">
						<li class="page-item">
							<a class="page-link"href="/SINGLE/board/resalepage.do?curPage=${blockStartNum -1 }">Previous</a>
						</li>
					</c:if>
				</c:if>
				<c:forEach var="i" begin="${blockStartNum }" end="${blockLastNum }">
					<c:choose>
						<c:when test="${i > lastPageNum }">
							<li class="page-item">${i }</li>
						</c:when>
						
						<c:when test="${i == curPageNum }">
							<li class="page-item">${i }</li>
						</c:when>
						
						<c:otherwise>
							<c:if test="${condition != null }">
								<li class="page-item">
									<a class="page-link" href="/SINGLE/board/resalepage.do?curPage=${i }&option=${option}&condition=${condition}">${i }</a>
								</li>
							</c:if>
							<c:if test="${condtion == null }">
								<li class="page-item">
									<a class="page-link" href="/SINGLE/board/resalepage.do?curPage=${i }">${i }</a>
								</li>
							</c:if>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${lastPageNum > blockNum }">
					<li class="page-item">
						<a class="page-link" href="/SINGLE/board/resalepage.do?curPage=${blockLastNum + 1 }&option=${option}&condition=${condition}">Next</a>
					</li>
				</c:if>
			</ul>
		</div>
		
	</div>

<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->

</body>
</html>