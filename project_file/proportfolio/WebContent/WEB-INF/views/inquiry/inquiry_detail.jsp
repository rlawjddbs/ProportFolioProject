<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>문의글 확인</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="/proportfolio/common/css/main_css190520.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<style>
	body{ font-family: 'Noto Sans KR', sans-serif; }
	html{ font-size:16px; }
	body{ margin:0; }
	#inquirySubject{ margin:0; display:inline-block; vertical-align: middle; padding-left:0; } 
	section{ width:1200px; overflow:hidden; padding-top:56px; margin:0 auto; box-sizing:border-box; padding-bottom:30px; }
	article{ padding:30px 0 }
	.headerZone{
		overflow:hidden;
		margin-bottom:20px;
	}
	.headerZone > p{ display:inline-block; padding-left:20px; margin:0; vertical-align: middle;}
	/* .headerZone > h3{ float: left; } */
	.headerZone #imgWrap{
		width:46px; 
		height:46px; 
		display:inline-block; 
		background-color:orange;
		vertical-align: middle;
		overflow:hidden;
		border-radius:50%;
		/* margin-left:20px; */
	}
	.headerZone #imgWrap img{
		display:block;
		width:100%;
	}
	
	.description { position:relative; }
	.description > textarea{ width:100%; min-height:300px; }
	#bottomZone{ text-align:center; }
	
	.btn {
		padding-left:20px; padding-right:20px; height:40px; background-color:#5e5e5e; color:white; font-weight:bold; border:0; border-radius:5px; font-size:17px;
		transition:background-color 0.3s;
	}
	.btn:nth-of-type(2){ margin-left:10px; margin-right:10px; }
	
	#taBlock{ position:absolute; top:0; left:0; width:100%; height:100%; z-index:999;}
	
	#popupBg{ position:fixed; width:100%; height:100%; background-color:rgba(0, 0, 0, 0); display:none; top:0; left:0; transition:background-color 0.3s; z-index:1000;}
	#popupBody{ 
		position:absolute; 
		width:500px; 
		height:400px; 
		padding:20px;
		top:30%; 
		left:50%; 
		background-color:rgba(255, 255, 255, 0.78); 
		opacity:0; 
		transform:translate(-50%, -50%); 
		transform-origin:50% 50%;
		-webkit-transition:width 0.5s, height 0.5s, opacity 0.3s; 
		/* transition:width 0.5s, height 0.5s, opacity 0.3s, font-size 0.3s; */
		transition-duration:0.3s; 
		text-align:center;
		font-size:1.7em;
	}
	#popupBody > #popupTitle{
		transition-duration:0.3s; 
		/* transition:font-size 0.3s; */ 
		font-size:1.2em; 
		text-align: center;
		padding-bottom:10px;
		margin-bottom:10px;
		border-bottom:1px solid #ccc; 
	}
	#popupBody > #popupDesc{
		transition-duration:0.3s; 
		/* transition:font-size 0.3s;  */
		text-align:center;
		font-size:1em;
	}
	#popupBtn{
		transition-duration:0.3s;
		background-color:#1B9CFC;
		transform-origin:0% 50%;
	}
	
	textarea:readonly {
		background-color:#fff;
		outline:none;
	}
	
	
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
	.btnWrap.over::before{
		left:150%;
	}
	
	@keyframes twinkle{
		0%{
			left:-100%;			
		}
		
		100%{
			left:100%;
		}
	}
	
	#tfSubject{
    	/* display: block; */
	    float: left;
	    height: 33px;
	}
	span.impact{
		font-size:16px; 
		font-weight:bold;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$(".btnWrap").mouseover(function() {
			$(this).addClass("over");
		});
		$(".btnWrap").mouseout(function() {
			$(this).removeClass("over");
		});
		
		$("#taBlock").click(function(){
			if($("#correctiveInquiry").text("문의 수정")){
				loadModal("잘못된 수정 시도", "문의 사항을 수정하시려면<br /> 먼저 '문의 수정' 버튼을 눌러주세요.");
			} // end if
		}); // click
		
		$("#correctiveInquiry").click(function(){
			if($("#correctiveInquiry").val()=="문의 수정"){
				$(this).val("수정 완료");
				$("#taBlock").remove();
				$("#userContents").attr("readonly", null);
				var subjectTxt = $("#inquirySubject").text();
				var $tfSubject = $('<div class="col-xs-12 col-md-4" style="padding-left:0;"><input type="text" class="form-control" value="'+subjectTxt+'" id="tfSubject" name="subject" style="margin-top:6.5px; margin-bottom:6.5px; margin-right:20px;"/></div>'); 
				// var $tfSubject = $('<input type="text" class="form-control" value="'+subjectTxt+'" id="tfSubject" name="subject" style="line-height:46px; display:inline-block; vertical-align:middle; margin-top:6.5px; margin-bottom:6.5px; margin-right:20px;"/>');
				
				$("#inquirySubject").before($tfSubject);
				$("#inquirySubject").remove();
			} else {
				var confirmMsg = confirm("문의 사항을 수정하시겠습니까?");
				if( confirmMsg ){
					var frm = document.frm;
					frm.action = "inquiry_edit.do"
					frm.submit();
				} // end if
			} // end else
		}); // click
		
		$("#deleteInquiry").click(function() {
			var confirmMsg = confirm("문의 사항을 삭제하시겠습니까?");
			if(confirmMsg){
				var frm = document.frm;
				frm.action = "inquiry_delete.do"
				frm.submit();
			} // end if
		}); // click

		$("#backInquiryList").click(function(){
			window.location.replace("inquiry_board.do");
		}); // click
		
		$("#popupBtn").click(function(){
			closeModal();
		}); // click
		
		
		function loadModal(title, desc){
			$("#popupTitle").html(title);
			$("#popupDesc").html(desc);
			$("#popupBg").css("display","block");
			setTimeout(function() {
				$("#popupBg").css("background-color","rgba(0, 0, 0, 0.22)");
			}, 50);
			setTimeout(function() {
				$("#popupBody").css("font-size","1em");
				$("#popupBody").css({
					width:"300px",
					height:"200px",
					opacity:1
				});
			}, 150);
			return;
		} // loadModal
		
		function closeModal(){
			setTimeout(function() {
				$("#popupBg").css("background-color","rgba(0, 0, 0, 0)");
			}, 50);
			setTimeout(function() {
				$("#popupBody").css("font-size","1.7em");
				$("#popupBody").css({
					width:"500px",
					height:"400px",
					opacity:0
				});
			}, 150);
			setTimeout(function() {
				$("#popupBg").css("display","none");
			}, 450);
		} // closeModal
		
	}); // ready
</script>
</head>
<body>
	<header id="header">
		<c:import url="/common/jsp/navbar.jsp"/>
	</header>
	<section class="container">
		<article id="inquiry" style="padding-bottom:0px;">
			<form name="frm">
				<div class="headerZone row">
					<div class="col-xs-12">
						<h3 id="inquirySubject" class="col-xs-12 col-md-4" style="line-height:46px;"><c:out value="${ inquiryDetail.subject }" /></h3>
						<p class="col-xs-9 col-md-7" style="line-height:46px; padding-left:0;" id="detailP">
							<input type="hidden" name="num" value="${ inquiryDetail.num }" />
							<span id="inquiryNum"># <span class="impact"><c:out value="${ inquiryDetail.num }" /></span>번 글</span>
							<span id="inquiryWriter"> | 작성자 <span class="impact"><c:out value="${ inquiryDetail.user_id }" /></span></span> <span class="hidden-xs">|</span><br class="visible-xs" />
							<span id="wDate">작성일 <span class="impact">${ inquiryDetail.w_date }</span></span>
							<span id="views"><span class="hidden-xs">| </span><br class="visible-xs" />조회수 <span class="impact">${ inquiryDetail.views }</span>회</span>
						</p>
						<div class="col-xs-3 col-md-1" style="padding-right:0; text-align:right;">
							<div id="imgWrap">
								<img src="/proportfolio/common/profile_img/${ inquiryDetail.profile_pic }" />
							</div>
						</div>
					</div>
				</div>
				<div class="description">
					<c:if test="${ inquiryDetail.status eq 'N' and session_id eq inquiryDetail.user_id }">
						<div id="taBlock"></div>
					</c:if>
					<textarea id="userContents" readonly="readonly" name="user_contents">${ inquiryDetail.user_contents }</textarea>
				</div>
			</form>
		</article>
		<c:choose>
			<c:when test="${ not empty inquiryDetail.r_contents }">
				<article id="answer">
					<div class="headerZone">
						<h3 id="answerSubject">답변</h3>
						<p style="padding-left:0;">
							<span id="answerWriter">관리자 <span class="impact"><c:out value="${ inquiryDetail.admin_id }" /></span></span> |
							<span id="rDate">답변일 <span class="impact"><c:out value="${ inquiryDetail.r_date }" /></span></span>
						</p>
					</div>
					<div class="description">
						<textarea id="rContents" readonly="readonly"><c:out value="${ inquiryDetail.r_contents }"></c:out></textarea>
					</div>
				</article>
			</c:when>
			<c:otherwise>
				<h3 id="answerSubject" style="margin-top:20px; margin-bottom:50px;">현재 <c:out value="${inquiryDetail.user_id }" />고객님의 문의는 답변대기 중입니다.<br class="hidden-xs" /> 문의사항에 성심 성의껏 답변드리겠습니다.</h3>
			</c:otherwise>
		</c:choose>
		<div id="bottomZone">
			<span class="btnWrap"><input type="button" id="backInquiryList" value="문의 목록" class="btn" /></span>
			<c:if test="${ empty inquiryDetail.r_contents and inquiryDetail.user_id eq memberInform.user_id }">
				<span class="btnWrap"><input type="button" id="correctiveInquiry" value="문의 수정" class="btn" /></span>
				<span class="btnWrap"><input type="button" id="deleteInquiry" value="문의 삭제" class="btn" /></span>
			</c:if>
		</div>
		<div id="popupBg">
			<div id="popupBody">
				<h4 id="popupTitle"></h4>
				<p id="popupDesc"></p>
				<input type="button" class="btn" id="popupBtn" value="확인" />
			</div>
		</div>
	</section>
</body>
</html>