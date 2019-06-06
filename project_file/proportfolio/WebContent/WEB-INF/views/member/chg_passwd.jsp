<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재 확인</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="common/css/main_css190520.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function(){
		var frm = document.frm;
		
		
		$("#submitBtn").click(function(){
			var passwd = frm.password;
			var chgpasswd = frm.chgpasswd;
			if(passwd.value.trim() == ""){
				alert("비밀번호를 입력해 주세요.");
				passwd.value = "";
				passwd.focus();
				return;
			} // end if
			
			if($("#chgpasswd").val().trim() != $("#confirmChgPasswd").val().trim()){
				alert("변경할 비밀번호가 일치하지 않습니다.");
				$("#chgpasswd").val("");
				$("#confirmChgPasswd").val("");
				$("#chgpasswd").focus();
				return;
			} // end if
			
			$.ajax({
				url : "chg_passwd_process.do",
				type : "post",
				data : $("#frm").serialize(),
				dataType : "json",
				success : function(jsonObj) {
					if (jsonObj.updateResult) {
						alert("비밀번호 변경에 성공하였습니다.");
						location.href= "/proportfolio/mypage.do";
					} else {
						var txtNode = "비밀번호가 변경되지 않았습니다.";
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
		<c:import url="/common/jsp/navbar.jsp"/>
	</header>
	<div class="container" id="mypageWrap" style="padding-top:70px;">
		
		<c:choose>
			<c:when test="${ memberInform ne null }">
				<form name="frm" id="frm" method="post">
					<div class="row">
						<div class="col-xs-12">
							<label>Propofol 아이디</label>
							<input type="hidden" name="user_id" value="${ memberInform.user_id }" />
							<h3 id="markupId" style="margin:0;"><c:out value="${ memberInform.user_id }" /></h3>
							<br />
							<label for="password">현재 비밀번호</label><br />
							<input type="password" placeholder="비밀번호 입력" class="form-control" name="currentPasswd" id="password"/>
							<br />
							<label for="chgpasswd">변경할 비밀번호</label><br />
							<input type="password" placeholder="비밀번호 입력" class="form-control" name="chgPasswd" id="chgpasswd"/>
							<br />
							<label for="confirmChgPasswd">비밀번호 확인</label><br />
							<span  id="errMsg2" style="color:#ff0000;"></span>
							<input type="password" placeholder="비밀번호 입력" class="form-control" name="confirmChgPasswd" id="confirmChgPasswd"/>
							<span  id="errMsg1" style="color:#ff0000;"></span>
							<input type="button" id="submitBtn" class="btn btn-default form-control" value="확인" style="background:#000; color:#fff; margin-top:20px;" />
							
							<ul style="margin-top:10px;">
								<li>본인 확인을 위해 한번 더 비밀번호를 입력해주세요. <a href="#">비밀번호 찾기</a></li>
							</ul>
						</div>
					</div>
				</form>
				
			</c:when>
			<c:otherwise>
				<script type="text/javascript">
					location.href = "index.do";
				</script>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>