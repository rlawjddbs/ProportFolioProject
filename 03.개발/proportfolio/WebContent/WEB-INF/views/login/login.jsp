<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>Propofol 로그인</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="common/css/login_css190521.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
	window.onload = function(){
		var frm = document.frm;
		var submitBtn = frm.btn;
		var userId = frm.user_id;
		var password = frm.password;
		
		userId.focus();
		
		userId.addEventListener("keydown", checkKeycode);
		password.addEventListener("keydown", checkKeycode);
		submitBtn.addEventListener("click", loginProcess);
		
		function loginProcess(){
			var id = frm.user_id;
			var pass = frm.password;
			
			if( id.value.trim() == "" ){
				alert("아이디를 입력해 주세요.");
				id.value = "";
				id.focus();
				return;
			} // end if
			if( pass.value.trim() == "" ){
				alert("비밀번호를 입력해 주세요.");
				pass.value = "";
				pass.focus();
				return;
			} // end if
			
			frm.action = "login_success.do";
			frm.submit();
			
		} // loginProcess
		
		function checkKeycode(evt){
			if( evt.which == 13 ){
				loginProcess();
			} // end if
		} // checkKeycode
		
		<%-- <%
			String result = (String)request.getAttribute("loginResult");
			System.out.println(result);
			if( result != null && !"".equals(result)){
		%>
				alert( "<%= result %>" );
		<%				
			} // end if
		%> --%>
	} // function
</script>
</head>
<body style="background-color:#f1f2f6;">
	<div class="container" style="padding-top:70px;">
	<div class="col-xs-12">
	<div id="loginContainer" class="container">
		<h3 id="loginTitle">Propofol Login</h3>
		<c:if test="${ loginResult ne null }">
			<h5 style="color:#ff0000"><c:out value="${ loginResult }" /></h5>
		</c:if>
		<form name="frm" id="frm" method="post">
			<div id="id">
				<input type="text" name="user_id" class="form-control" placeholder="아이디를 입력해 주세요." />
			</div>
			<div id="pass">
				<input type="password" name="password" class="form-control" placeholder="비밀번호 입력해 주세요." />
			</div>
			<input type="button" name="btn" class="btn btn-default form-control" value="로그인" style="background:#000; color:#fff; margin-bottom:20px;"  />
			<div class="lineCont">
				<input type="radio" name="auto_login" value="y" /> 자동 로그인
			</div>
			<div class="lineCont" style="text-align:center;">
				<a href="join_member.do">회원가입</a> |
				<a href="/proportfolio/find_member_id.do">아이디 찾기</a> |
				<a href="/proportfolio/find_member_passwd.do">비밀번호 찾기</a> | 
				<a href="/proportfolio/index.do">메인 화면</a>
			</div>
		</form>
	</div>
	</div>
	</div>
</body>
</html>