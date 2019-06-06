<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>문의사항 게시판</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="/proportfolio/common/css/main_css190520.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<!-- 구글 웹 폰트 Noto Sans -->
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400,500,700,900" rel="stylesheet">

<style type="text/css">
	body{ margin:0; font-family: 'Noto Sans KR', sans-serif; }
	#wrap{ overflow:hidden; margin:0 auto; padding-top:50px; }
</style>	
<script type="text/javascript">
	window.onload = function(){
		var frm = document.frm;
		var writeInquiryBtn = document.getElementById("writeInquiry");
		var searchBtn = document.getElementById("searchBtn");
		var writeInquiryXsBtn = document.getElementById("writeInquiryXs");
		
		frm.addEventListener("submit", searchProcess)
		searchBtn.addEventListener("click", searchProcess);
		writeInquiryBtn.addEventListener("click", moveInqWritePage);
		writeInquiryXsBtn.addEventListener("click", moveInqWritePage);
		
		
		function searchProcess(evt){
			evt.preventDefault();
			var keyword = frm.keyword.value.trim();
						
			if( keyword == "" ){
				alert( "먼저 검색 키워드를 입력해주세요." );
				frm.keyword.value = "";
				frm.keyword.focus();
				return;
			} // end if
			
			var condition = frm.condition.value;
			frm.action = "/proportfolio/inquiry_board.do";
			frm.submit();
		} // searchProcess 
		
		function moveInqWritePage(){
			window.location.href = "inquiry_write.do";	
		} // InquiryWrite
		
	} // onload function
</script>

</head>

<body>
	<header id="header">
		<c:import url="/common/jsp/navbar.jsp"/>
	</header>
	<div id="wrap">
		<section>
			<article>
				<div class="container">
					<div id="tabHeaderWrap">
						<c:choose>
							<c:when test="${ memberInform.user_id ne null }">
								<input type="button" value="문의 남기기" id="writeInquiryXs" class="btnKjy visible-xs"/>
								<h3 class="board_title hidden-xs">문의하기</h3>
							</c:when>
							<c:otherwise>
								<h3 class="board_title">문의하기</h3>
							</c:otherwise>
						</c:choose>
						<c:if test="${ memberInform.user_id ne null }">
							<h4 id="seeMyWriting"><a href="/proportfolio/inquiry_board.do?condition=id&keyword=${ memberInform.user_id }">내가 쓴 문의</a></h4>
						</c:if>
					</div>
					<table class="table" id="inquiryBoard">
						<tr id="titleRow" class="hidden-xs">
							<th style="background-color:#e84393; color:#fff;">
								<h4 class="col-sm-2 col-md-1 tbCenter">번호</h4>
								<h4 class="col-sm-4 col-md-5 tbCenter">제목</h4>
								<h4 class="col-sm-2 col-md-2 tbCenter">아이디</h4>
								<h4 class="col-sm-2 col-md-1 tbCenter">작성일</h4>
								<h4 class="col-sm-2 col-md-1 tbCenter hidden-sm">조회수</h4>
								<h4 class="col-sm-2 col-md-2 tbCenter">상태</h4>
							</th>
						</tr>
						<c:if test="${ empty inquiryList }">
							<tr>
								<th style="background-color:#e84393; color:#fff;">작성된 문의사항이 존재하지 않습니다. <a href="inquiry_board.do">전체 문의사항 보기</a></td>
							</tr>
						</c:if>
						<c:forEach var="inquiry" items="${ inquiryList }">
							<tr>
								<td>
									<p class="col-sm-2 hidden-xs col-md-1 tbCenter inquiryNum"><c:out value="${ inquiry.num }" /></p>
									<p class="col-xs-12 col-sm-4 col-md-5 tbCenter inquirySubj"><a href="/proportfolio/inquiry_detail.do?num=${ inquiry.num }"><c:out value="${ inquiry.subject }" /></a></p>
									<p class="col-xs-4 col-sm-2 tbCenter inquiryUser"><c:out value="${ inquiry.user_id }" /></p>
									<p class="col-xs-4 col-sm-2 col-md-1 tbCenter wDate"><c:out value="${ inquiry.w_date }" /></p>
									<p class="col-sm-2 tbCenter col-md-1 hidden-xs hidden-sm inquiryViews"><c:out value="${ inquiry.views }" /></p>
									<p class="col-xs-4 col-sm-2 col-md-2 tbCenter inquiryStatus"><c:out value="${ inquiry.status }" /></p>
								</td>
							</tr>
						</c:forEach>
					</table>
					<div id="inquiryIndexList" style="text-align:center;">
						<c:out value="${ indexList }" escapeXml="false" />
					</div>	
				</div>
				<div class="container" style="padding-top:20px;">
					<div class="row">
						<div class="col-xs-12">
							<form id="frm" name="frm" method="get" class="searchFrm">
							<div id="searchWrap" class="col-xs-12" style="padding-left:0; padding-right:0;">
							<select id="condition" class="col-xs-3 col-sm-2" name="condition">
								<option value="contents"${ param.condition eq 'contents'?' selected="selected"':'' }>내용</option>
								<option value="sbjContents"${ param.condition eq 'sbjContents'?' selected="selected"':'' }>제목+내용</option>
								<option value="id"${ param.condition eq 'id'?' selected="selected"':'' }>회원아이디</option>
							</select><input type="text" class="col-xs-6 col-sm-4" placeholder="검색할 내용 입력" id="keyword" name="keyword" /><input type="button" value="검색" id="searchBtn" class="btnKjy col-xs-3 col-sm-2 col-md-1"  />
							<c:if test="${ memberInform.user_id ne null }">
								<div style="float:right;"><span class="btnWrap"><input type="button" value="문의 남기기" id="writeInquiry" class="btnKjy hidden-xs" /></span></div>
							</c:if>
							</div>
							
							</form>
						</div>
					</div>
				</div>
			</article>
			
			<%-- <h1>세션 아이디 ${ session.getAttribute("session_id") } <%= session.getAttribute("session_id") %></h1> --%>
			
			
		</section>
	</div>
</body>
</html>