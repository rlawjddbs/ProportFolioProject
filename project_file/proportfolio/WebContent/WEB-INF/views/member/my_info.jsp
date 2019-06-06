<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보 수정하기</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="common/css/main_css190520.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript">

	$(function(){
		$("#chgNameBtn").click(function(){
			if( $("#name").attr("readonly") != null ){
				$("#name").attr("readonly", null);
				$("#name").removeClass("readOnlyForm");
				$("#name").focus();
			} else {
				$.ajax({
					url : "chg_name_process.do",
					type : "post",
					data : "name="+$("#name").val(),
					dataType : "json",
					success : function(jsonObj) {
						var txtNode = "";
						if (jsonObj.updateResult) {
							$("#name").attr("readonly", "readonly");
							$("#name").addClass("readOnlyForm");
							txtNode = "이름이 변경되었습니다.";
							$("#nameMsg").removeClass("negativeResult");
							$("#nameMsg").addClass("positiveResult");
							$("#nameMsg").text(txtNode);
						} else {
							txtNode = "이름이 변경되지 않았습니다.";
							$("#nameMsg").removeClass("positiveResult");
							$("#nameMsg").addClass("negativeResult");
							$("#nameMsg").text(txtNode);
							return;
						} // end else
					}, // success
					error : function(xhr) {
						alert(xhr.status + "///" + xhr.statusText);
						alert("에러발생. 기술 지원에 문의하세요.");
						// location.replace("index.do");
					} // error
				}); // ajax
			} // end else
		}); // click
		
		$("#chgEmailBtn").click(function(){
			if( $("#email").attr("readonly") != null ){
				$("#email").attr("readonly", null);
				$("#email").removeClass("readOnlyForm");
				$("#email").focus();
			} else {
				$.ajax({
					url : "chg_email_process.do",
					type : "post",
					data : "email="+$("#email").val(),
					dataType : "json",
					success : function(jsonObj) {
						var txtNode = "";
						if (jsonObj.updateResult) {
							$("#email").attr("readonly", "readonly");
							$("#email").addClass("readOnlyForm");
							txtNode = "이메일이 변경되었습니다.";
							$("#emailMsg").removeClass("negativeResult");
							$("#emailMsg").addClass("positiveResult");
							$("#emailMsg").text(txtNode);
						} else {
							txtNode = "이메일이 변경되지 않았습니다.";
							$("#emailMsg").removeClass("positiveResult");
							$("#emailMsg").addClass("negativeResult");
							$("#emailMsg").text(txtNode);
							return;
						} // end else
					}, // success
					error : function(xhr) {
						alert(xhr.status + "///" + xhr.statusText);
						alert("에러발생. 기술 지원에 문의하세요.");
						// location.replace("index.do");
					} // error
				}); // ajax
			} // end else
		}); // click
		
		$("#chgBirthBtn").click(function(){
			if( $("#birth").attr("readonly") != null ){
				$("#birth").attr("readonly", null);
				$("#birth").removeClass("readOnlyForm");
			} else {
				$.ajax({
					url : "chg_birth_process.do",
					type : "post",
					data : "birth="+$("#birth").val(),
					dataType : "json",
					success : function(jsonObj) {
						var txtNode = "";
						if (jsonObj.updateResult) {
							$("#birth").attr("readonly", "readonly");
							$("#birth").addClass("readOnlyForm");
							txtNode = "생년월일이 변경되었습니다.";
							$("#birthMsg").removeClass("negativeResult");
							$("#birthMsg").addClass("positiveResult");
							$("#birthMsg").text(txtNode);
						} else {
							txtNode = "생년월일이 변경되지 않았습니다.";
							$("#birthMsg").removeClass("positiveResult");
							$("#birthMsg").addClass("negativeResult");
							$("#birthMsg").text(txtNode);
							return;
						} // end else
					}, // success
					error : function(xhr) {
						alert(xhr.status + "///" + xhr.statusText);
						alert("에러발생. 기술 지원에 문의하세요.");
						// location.replace("index.do");
					} // error
				}); // ajax
			} // end else
		}); // click
		
		$("#chgPhoneBtn").click(function(){
			if( $("#phone").attr("readonly") != null ){
				$("#phone").attr("readonly", null);
				$("#phone").removeClass("readOnlyForm");
			} else {
					$.ajax({
						url : "chg_phone_process.do",
						type : "post",
						data : "phone="+$("#phone").val(),
						dataType : "json",
						success : function(jsonObj) {
							var txtNode = "";
							if (jsonObj.updateResult) {
								$("#phone").attr("readonly", "readonly");
								$("#phone").addClass("readOnlyForm");
								txtNode = "연락처가 변경되었습니다.";
								$("#phoneMsg").removeClass("negativeResult");
								$("#phoneMsg").addClass("positiveResult");
								$("#phoneMsg").text(txtNode);
							} else {
								txtNode = "연락처가 변경되지 않았습니다.";
								$("#phoneMsg").removeClass("positiveResult");
								$("#phoneMsg").addClass("negativeResult");
								$("#phoneMsg").text(txtNode);
								return;
							} // end else
						}, // success
						error : function(xhr) {
							alert(xhr.status + "///" + xhr.statusText);
							alert("에러발생. 기술 지원에 문의하세요.");
							// location.replace("index.do");
						} // error
					}); // ajax
				} // end else
			}); // click
		
	});
</script>
</head>
<body>
	
	<c:choose>
		<c:when test="${ memberInform ne null }">
			<header id="header">
				<c:import url="/common/jsp/navbar.jsp"/>
			</header>
			<div class="container" id="myInfoContainer">
				<form method="post" name="infoFrm" id="infoFrm">
					<div class="row">
						<div class="col-xs-12">
							<h1>내 정보 <span>수정하기</span></h1>
							<p>내 정보를 최신 정보로 관리해 주세요.</p>
						</div>
					</div>
					<div class="row mypageRow">
						<div class="col-xs-12">
							<label>아이디</label>
							<input type="text" name="user_id" value="${ memberInform.user_id }" readonly="readonly" class="readOnlyForm inputText" />
						</div>
					</div>
					<div class="row mypageRow">
						<div class="col-xs-12">
							<label>이름</label>
							<input type="text" value="${ memberInform.name }" name="name" id="name" readonly="readonly" class="readOnlyForm inputText" />
							<input type="button" value="변경" name="chgNameBtn" class="btn btn-info chgBtn" id="chgNameBtn" />
							<span id="nameMsg" class="msgPadding"></span>
						</div>
					</div>
					<div class="row mypageRow">
						<div class="col-xs-12">
							<label>이메일</label>
							<input type="text" value="${ memberInform.email }" name="email" id="email" readonly="readonly" class="readOnlyForm inputText" />
							<input type="button" value="변경" name="chgEmailBtn" class="btn btn-info chgBtn" id="chgEmailBtn" />
							<span id="emailMsg" class="msgPadding"></span>
						</div>
					</div>
					<div class="row mypageRow">
						<div class="col-xs-12">
							<label>생년월일</label>
							<input type="text" value="${ memberInform.birth }" name="birth" id="birth" readonly="readonly" class="readOnlyForm inputText" />
							<input type="button" value="변경" name="chgBirthBtn" class="btn btn-info chgBtn" id="chgBirthBtn" />
							<span id="birthMsg" class="msgPadding"></span>
						</div>
					</div>
					<div class="row mypageRow">
						<div class="col-xs-12">
							<label>연락처</label>
							<input type="text" value="${ memberInform.phone }" name="phone" id="phone" readonly="readonly" class="readOnlyForm inputText" />
							<input type="button" value="변경" name="chgPhoneBtn" class="btn btn-info chgBtn" id="chgPhoneBtn" />
							<span id="phoneMsg" class="msgPadding"></span>
						</div>
					</div>
					<div class="row mypageRow">
						<div class="col-xs-12">
							<label>가입일</label>
							<input type="text" value="${ memberInform.inputdate }" readonly="readonly" class="readOnlyForm inputText" />
							<br class="visible-xs" />
							<span class="visible-xs col-xs-1"></span>
							<span style="color:#f39c12;">가입일로 부터 <c:out value="${ dDay }" />일 지났습니다.</span>
						</div>
					</div>
				</form>
				<div class="col-xs-12" style="text-align:center; padding-top:20px;">
					<input type="button" class="btn btn-lg btn-default" value="마이 페이지로 이동" style="background:#000; color:#fff;" onclick="location.href='/proportfolio/mypage.do'" />
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<script type="text/javascript">
				location.href="index.do";
			</script>
		</c:otherwise>	
	</c:choose>
</body>
</html>