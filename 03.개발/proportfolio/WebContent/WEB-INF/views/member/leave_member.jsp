<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴에 대한 안내</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="common/css/main_css190520.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#confirmBtn").click(function(){
			if($("#confirmChkBox").is(":checked") == true ){
				$("#mypageWrap").fadeOut(300);
				setTimeout(function(){
					$("#invisible").fadeIn(300);
					$("#password").focus();
				}, 300);
			} else {
				alert("안내 사항에 대한 확인을 해주세요.");
			} // end else
		}); // click
		
		$("#submitBtn").click(function(){
			var password = $("#password").val();
			if( password.trim() == "" ){
				alert("비밀번호를 입력해주세요.");
				$("#password").val("");
				$("#password").focus();
				return;
			} // end if
			$.ajax({
				url : "leave_member_process.do",
				type : "post",
				data : "user_id="+$("input[type=hidden]").val()+"&password="+$("#password").val(),
				dataType : "json",
				success : function(jsonObj) {
					if (jsonObj.updateResult) {
						location.href= "/proportfolio/goodbye.do";
					} else {
						var txtNode = "비밀번호가 일치하지 않습니다.";
						$("#errMsg1").text(txtNode);
						passwd.value = "";
						passwd.focus();
						return;
					} // end else
				}, // success
				error : function(xhr) {
					alert(xhr.status + "///" + xhr.statusText);
					alert("에러발생. 기술 지원에 문의하세요.");
					// location.replace("index.do");
				} // error
			}); // ajax
			
		}); // click
		
	}); // ready
</script>
</head>
<body>
	<header id="header">
		<c:import url="/common/jsp/navbar.jsp" />
	</header>
	<div class="container" id="mypageWrap" style="padding-top:70px;">
		<h3 class="col-xs-12">회원 탈퇴 전 확인해 주세요.</h3>
		<div class="col-xs-12" style="border:1px solid #ccc; padding:15px; margin-bottom:20px;">
			<ol style="padding-left:15px; border-radius:5px">
				<li>
					회원 탈퇴시 동일한 아이디로 재가입이 불가능합니다.
				</li>
				<li>
					고객님이 회원 탈퇴를 하셔도 문의 사항 게시글은 남아있습니다.<br />
					이를 원치 않는다면 탈퇴전 고객님의 게시글을 삭제 후 탈퇴 해주세요.<br />
				</li>
			</ol>
		</div>
		<div class="col-xs-12">
			<label for="confirmChkBox">안내 사항을 확인하였으며 이에 동의합니다.</label>
			<input type="checkbox" name="confirmCh Box" id="confirmChkBox" />
		</div>
		<input type="button" value="확인" id="confirmBtn" class="btn btn-default form-control" style="background:#000; color:#fff" />
	</div>
	<div class="container" id="invisible">
		<form name="frm" id="frm" method="post">
			<div class="row">
				<div class="col-xs-12" style="padding-top:70px;">
					<input type="hidden" name="user_id" value="${ memberInform.user_id }" />
					<h4 class="col-xs-12" id="markupId" style="margin:20px 0;">
						회원 탈퇴 처리를 위해 비밀번호를 재 입력 해주세요.
					</h4>
					<br />
					<label for="password">비밀번호</label><br />
					<input type="password" placeholder="비밀번호 입력" class="form-control" name="currentPasswd" id="password"/>
					<span  id="errMsg1" style="color:#ff0000;"></span>
					<input type="button" id="submitBtn" class="btn btn-danger	 form-control" value="회원 탈퇴" style="margin-top:20px;" />
					<ul style="margin-top:10px;">
						<li>확인 버튼 클릭시 회원 탈퇴 처리 됩니다.</li>
					</ul>
				</div>
			</div>
		</form>
	</div>
</body>
</html>