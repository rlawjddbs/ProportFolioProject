<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	article{ width:1210px; margin:0 auto; overflow:hidden; min-height:700px; padding:20px 10px;}
	article > #board_title{ font-size:30px; float:left; }
	article > #seeMyWriting{ float:right; margin-top:50px; margin-bottom:0;}
	#inquiryBoard{ border-collapse:collapse; width:100%; margin:20px auto; margin-bottom:30px; border-bottom:10px solid #3dd3ae;
						box-shadow:0 0 5px rgba(0, 0, 0, 0.52); overflow:hidden; }
	#inquiryBoard th{ background-color:#e84393; padding-top:10px; padding-bottom:10px; font-size:16px; font-weight:bold; color:#fff; font-weight:300; }
	#inquiryBoard td{ padding-top:10px; padding-bottom:10px; font-size:16px; text-align:center; color:#535c68; border-bottom:1px solid #f1f1f1; }
	#inquiryBoard tr:nth-child(2n){ /* background-color:#f6f6f6; */ }
	#inquiryBoard tr{ transition:background-color 0.3s;  }
	#inquiryBoard tr:hover{ background-color: #f6f6f6; }
	#inquiryBoard tr:hover td{ color: #000; }
	#inquiryBoard tr:hover a{ color: #000; }
	
	#inquiryBoard a { }
	
	#titleRow > th{ text-align:center; }
	#titleRow > th:nth-child(1){ width:80px; }
	#titleRow > th:nth-child(2){ width:480px; }
	#titleRow > th:nth-child(3){ width:80px; }
	#titleRow > th:nth-child(4){ width:80px; }
	#titleRow > th:nth-child(5){ width:120px; }
	#titleRow > th:nth-child(6){ width:80px; }
	
	#inquiryIndexList{ margin-bottom:20px; }
	#inquiryIndexList div{
		display:inline-block;
		padding:0 8px;
		transition-duration:0.3s;
		vertical-align: middle;
		margin:0 3px;
		box-sizing:border-box;
		border-radius:50%;
	}
	#inquiryIndexList div:hover{
		background-color:#3dd3ae;
		color:#fff;
	}
	
	article > #seeMyWriting{ float:right; margin-top:50px; margin-bottom:20px; font-size:16px; font-weight:bold; }
	#condition, #keyword, #searchBtn{ text-align:center; vertical-align: middle; height:40px; font-size:16px; }
	#condition{ width: 120px; }
	#keyword{ height:40px; }
	#searchBtn{ padding-left:20px; padding-right:20px; }
	
	#frm{ margin-bottom:150px; }
	
	#inquiryBoard #inquirySubject{ padding:0 20px; text-align:left; }
	

	.btnWrap{
		display:inline-block;
		overflow:hidden;
		position:relative;
		transition:box-shadow 0.3s;
		border-radius:5px;
	}
	
	.btnWrap:hover{
		box-shadow:rgba(27, 156, 252, 0.78);
	}
	.btnWrap:hover .btn{
		background-color:rgba(27, 156, 252,1.0);
	}
	.btnWrap::before{
		content:"";
		width:1px;
		height:100%;
		position:absolute;
		top:0;
		left:-100%;
		background-color:white;
		transition:left 0.7s;
		cursor:pointer;
		transform:skewX(-40deg);
		box-shadow:0 0 20px 40px rgba(255, 255, 255, 0.78);
	}
	
	#writeInquiry{ cursor:pointer; float:right; }
	
	.btn {
		padding-left:20px; 
		padding-right:20px; 
		height:40px; 
		background-color:#5e5e5e; 
		color:white; 
		font-weight:bold; 
		border:0; 
		border-radius:5px; 
		font-size:17px;
		transition:background-color 0.3s;
		font-weight:400;
	}
</style>	
<script type="text/javascript">
	window.onload = function(){
		var frm = document.frm;
		var writeInquiryBtn = document.getElementById("writeInquiry");
		var searchBtn = document.getElementById("searchBtn");
		
		frm.addEventListener("submit", searchProcess)
		searchBtn.addEventListener("click", searchProcess);
		writeInquiryBtn.addEventListener("click", moveInqWritePage);
		
		
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
			frm.action = "/proportfolio/inquiry/inquiry_board.do";
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
				<h1 id="board_title">문의하기</h1>
				<c:if test="${ memberInform.user_id ne null }">
					<h4 id="seeMyWriting"><a href="/proportfolio/inquiry/inquiry_board.do?condition=id&keyword=${ memberInform.user_id }">내가 쓴 문의</a></h4>
				</c:if>
				<table id="inquiryBoard">
					<tr id="titleRow">
						<th>번호</th>
						<th>제목</th>
						<th>아이디</th>
						<th>작성날짜</th>
						<th>조회수</th>
						<th>상태</th>
					</tr>
					<c:if test="${ empty inquiryList }">
						<tr>
							<td colspan="5">작성된 문의사항이 존재하지 않습니다. <a href="inquiry_board.do">전체 문의사항 보기</a></td>
						</tr>
					</c:if>
					<c:forEach var="inquiry" items="${ inquiryList }">
						<tr>
							<td>
								<c:out value="${ inquiry.num }" />
							</td>
							<td id="inquirySubject">
								<a href="/proportfolio/inquiry/inquiry_detail.do?num=${ inquiry.num }"><c:out value="${ inquiry.subject }" /></a>
							</td>
							<td>
								<c:out value="${ inquiry.user_id }" />
							</td>
							<td>
								<c:out value="${ inquiry.w_date }" />
							</td>
							<td>
								<c:out value="${ inquiry.views }" />
							</td>
							<td>
								<c:out value="${ inquiry.status }" />
							</td>
						</tr>
					</c:forEach>
				</table>
				<div id="inquiryIndexList" style="text-align:center;">
					<c:out value="${ indexList }" escapeXml="false" />
				</div>	
				<form id="frm" name="frm" method="get">	
				<select id="condition" name="condition">
					<option value="contents"${ param.condition eq 'contents'?' selected="selected"':'' }>내용</option>
					<option value="sbjContents"${ param.condition eq 'sbjContents'?' selected="selected"':'' }>제목+내용</option>
					<option value="id"${ param.condition eq 'id'?' selected="selected"':'' }>회원아이디</option>
				</select><input type="text" placeholder="검색할 내용 입력" id="keyword" name="keyword" /><input type="button" value="검색" id="searchBtn" class="btn" />
				<c:if test="${ memberInform.user_id ne null }">
					<div style="float:right;"><span class="btnWrap"><input type="button" value="문의 남기기" id="writeInquiry" class="btn" /></span></div>
				</c:if>
				</form>
			</article>
			
			<%-- <h1>세션 아이디 ${ session.getAttribute("session_id") } <%= session.getAttribute("session_id") %></h1> --%>
			
			
		</section>
	</div>
</body>
</html>