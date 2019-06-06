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
			
			if(birthYear.value.trim() == ""){
				alert("출생년도를 입력해 주세요.");
				name.value = "";
				name.focus();
				return;
			} // end if
			
			if(birthMonth.value.trim() == ""){
				alert("출생월을 입력해 주세요.");
				name.value = "";
				name.focus();
				return;
			} // end if
			
			if(birthDate.value.trim() == ""){
				alert("출생일을 입력해 주세요.");
				name.value = "";
				name.focus();
				return;
			} // end if
			
			if(phone1.value.trim() == ""){
				alert("휴대폰 번호 앞 자리를 입력해 주세요.");
				name.value = "";
				name.focus();
				return;
			} // end if
			
			if(phone2.value.trim() == ""){
				alert("휴대폰 번호 중간 자리를 입력해 주세요.");
				name.value = "";
				name.focus();
				return;
			} // end if
			
			if(phone3.value.trim() == ""){
				alert("휴대폰 번호 뒷 자리를 입력해 주세요.");
				name.value = "";
				name.focus();
				return;
			} // end if
			
			$.ajax({
				url : "find_member_id_process.do",
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
						$("#errMsg3").text(txtNode);
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
		
		$("#moveFindPasswd").click(function(){
			location.href = "/proportfolio/find_member_passwd.do";
		});
		
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
					<h3 class="col-xs-12">내 아이디 찾기</h3>
					<p class="col-xs-12">회원 가입 시 작성한 정보를 입력해 주세요.</p>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<br />
					<label for="password">이름</label><br />
					<input type="text" placeholder="이름을 입력해 주세요." class="form-control" name="name" id="password"/>
					<span  id="errMsg1" style="color:#ff0000;"></span>
					<br />
					<label for="chgpasswd">생년월일</label><br />
					<div class="col-xs-3" style="padding:0;">
						<input type="text" placeholder="출생년도" class="form-control" name="birthYear" id="birthYear" maxlength="4" style="text-align:center;"/>
					</div>
					<div class="col-xs-1" style="padding:0; text-align:center; line-height:34px;">년</div>
					<div class="col-xs-3" style="padding:0;">
						<input type="text" placeholder="출생월" class="form-control" name="birthMonth" id="birthMonth" maxlength="2" style="text-align:center;"/>
					</div>
					<div class="col-xs-1" style="padding:0; text-align:center; line-height:34px;">월</div>
					<div class="col-xs-3" style="padding:0;">
						<input type="text" placeholder="출생일" class="form-control" name="birthDate" id="birthDate" maxlength="2" style="text-align:center;"/>
					</div>
					<div class="col-xs-1" style="padding:0; text-align:center; line-height:34px;">일</div>
					<span  id="errMsg2" style="color:#ff0000;"></span>
					<br />
					<br />
					<br />
					<label for="confirmChgPasswd">휴대폰 번호</label><br />
					<div class="col-xs-3" style="padding:0;">
						<input type="text" class="form-control" name="phone1" id="phone1" maxlength="3" style="text-align:center;"/>
					</div>
					<div class="col-xs-1" style="padding:0; text-align:center; line-height:34px;"> - </div>
					<div class="col-xs-3" style="padding:0;">
						<input type="text" class="form-control" name="phone2" id="phone2" maxlength="4" style="text-align:center;"/>
					</div>
					<div class="col-xs-1" style="padding:0; text-align:center; line-height:34px;"> - </div>
					<div class="col-xs-4" style="padding:0;">
						<input type="text" class="form-control" name="phone3" id="phone3" maxlength="4" style="text-align:center;"/>
					</div>
					<span  id="errMsg3" style="color:#ff0000;"></span>
					<input type="button" id="submitBtn" class="btn btn-default form-control" value="아이디 찾기" style="background:#000; color:#fff; margin-top:20px;" />
					
					<ul style="margin-top:10px;">
						<li>본인 확인을 위한 정보를 입력해주세요. <a href="javascript:history.back()">이전 화면</a></li>
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
					아이디 찾기 조회 결과
				</h4>
				<br />
				<p id="resultMsg">고객님의 아이디는 [ <span  id="resultId" style="color:#079992; font-size:22px; font-weight:bold;"></span> ] 입니다.</p>
				<input type="button" id="moveFindPasswd" class="btn btn-warning form-control" value="비밀번호 찾기" style="margin-top:20px;" />
				<ul style="margin-top:10px;">
					<li>확인 버튼 클릭시 비밀번호 찾기 페이지로 이동합니다.</li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>