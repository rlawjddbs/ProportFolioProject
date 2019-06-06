<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 아이디 찾기</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="common/css/main_css190520.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function(){
		var frm = document.frm;
		var name = frm.name;
		var birthYear = frm.birthYear;
		var birthMonth = frm.birthMonth;
		var birthDate = frm.birthDate;
		var phon1 = frm.phone1;
		var phon2 = frm.phone2;
		var phon3= frm.phone3;
		
		$("#submitBtn").click(function(){
			if(name.value.trim() == ""){
				alert("이름을 입력해 주세요.");
				name.value = "";
				name.focus();
				return;
			} // end if
			
			$.ajax({
				url : "find_member_passwd_process.do",
				type : "post",
				data : $("#frm").serialize(),
				dataType : "json",
				success : function(jsonObj) {
					if (jsonObj.searchResult) {
						$("#resultId").text(jsonObj.user_id);
						$("#mypageWrap").fadeOut(300);
						setTimeout(function(){
							$("#invisible").fadeIn(300);	
						}, 300);
					} else {
						var txtNode = "일치하는 회원 정보를 찾을 수 없습니다.";
						$("#errMsg2").text(txtNode);
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
<body style="background-color:#f1f2f6;">
	<header id="header" style="position:fixed; top:0; left:0; width:100%;">
		<c:import url="/common/jsp/navbar.jsp"/>
	</header>
	<div class="container" id="mypageWrap" style="padding-top:70px;">
		<form name="frm" id="frm" method="post">
			<div class="row">
				<h3 class="col-xs-12">내 비밀번호 찾기</h3>
				<p class="col-xs-12">회원 가입 시 작성한 정보를 입력해 주세요.</p>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<br />
					<label for="password">아이디</label><br />
					<input type="text" placeholder="아이디를 입력해 주세요." class="form-control" name="user_id" id="user_id"/>
					<br />
					<label for="password">이름</label><br />
					<input type="text" placeholder="이름을 입력해 주세요." class="form-control" name="name" id="name"/>
					<span  id="errMsg1" style="color:#ff0000;"></span>
					<br />
					<label for="chgpasswd">메일 주소</label><br />
					<input type="text" placeholder="이메일을 입력해 주세요." class="form-control" name="email" id="email"/>
					<span  id="errMsg2" style="color:#ff0000;"></span>
					
					<input type="button" id="submitBtn" class="btn btn-default form-control" value="비밀번호 찾기" style="background:#000; color:#fff; margin-top:20px;" />
					
					<ul style="margin-top:10px;">
						<li>본인 확인을 위한 정보를 입력해주세요. <a href="javascript:location.href='/proportfolio/index.do'">메인 화면</a></li>
					</ul>
				</div>
			</div>
		</form>
	</div>
	<div class="container" id="invisible">
		<div class="row">
			<div class="col-xs-12" style="padding-top:70px;">
				<input type="hidden" name="user_id" value="${ memberInform.user_id }" />
				<h4 id="markupId" style="margin:20px 0;">
					고객님의 메일 계정으로 임시 비밀번호가 발송 되었습니다.
				</h4>
				<br />
				<p id="resultMsg">고객님의 메일 계정을 통해 발송된 임시 비밀번호를 확인하신 후 로그인하여 비밀번호를 변경해 주시기 바랍니다.</p>
				<input type="button" id="moveFindPasswd" class="btn btn-warning form-control" value="확인" style="margin-top:20px;" onclick="location.replace('/proportfolio/login.do')" />
				<ul style="margin-top:10px;">
					<li>확인 버튼 클릭시 로그인 페이지로 이동합니다.</li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>