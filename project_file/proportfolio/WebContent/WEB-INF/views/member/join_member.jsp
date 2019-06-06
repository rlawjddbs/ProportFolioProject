<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>회원가입</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="/proportfolio/common/css/main_css190520.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#user_id").focus();
		
		$('#user_id').blur(function(){
			var idVal = $("#user_id").val();
			
			if(idVal.trim() == ""){
				negativeMsg($("#idMsg"), "아이디를 입력해 주세요.");
				$("#user_id").val("");
				$("#password").val("");
				$("#user_id").focus();
				return;
			} // end if
			
			if( /[ㄱ-힣]/g.test(idVal) ){
				negativeMsg($("#idMsg"), "한글 아이디는 사용할 수 없습니다.");
				$("#user_id").val("");
				return;
			} // end if
			
			$.ajax({
				url:"id_dup_check.do",
				type:"post",
				data:"user_id="+$("#user_id").val(),
				dataType:"json",
				success:function( json ){
					if( json.idDupResult ){
						$("#idMsg").removeClass("negativeResult");
						$("#idMsg").addClass("positiveResult");
						$("#idMsg").html("[<strong> "+idVal+" </strong>]" + "은 사용할 수 있는 아이디 입니다.");
					} else {
						negativeMsg($("#idMsg"),"[<strong> "+idVal+" </strong>]" + "은 이미 사용중인 아이디 입니다.");
						$("#user_id").val("");
					} // end else
				}, // success
				error:function(xhr){
					
				} // error
			}); // ajax
		}); // blur
		
		$("#password").blur(function(){
			var passVal = $(this).val();
			if( passVal.trim() == "" ){
				negativeMsg($("#passMsg"), "비밀번호를 입력해 주세요.");
				$("#password").val("");
			} else {
				negativeMsg($("#passMsg"), "");
			}
		});
		
		$("#rePassword").blur(function(){
			var passVal = $("#password").val();
			var rePassVal = $(this).val();
			if( passVal.trim() == "" ){
				negativeMsg($("#chkPassMsg"), "비밀번호를 다시 입력해 주세요.");
				$("#rePassword").val("");
				return;
			} else {
				negativeMsg($("#passMsg"), "");
				negativeMsg($("#chkPassMsg"), "");
			}

			if( passVal != rePassVal ){
				negativeMsg($("#chkPassMsg"), "비밀번호가 일치하지 않습니다.");
				$("#password").val("");
				$("#rePassword").val("");
				$("#password").focus();
				return;
			} // end if
			
		}); // blur
		
		$("#email").blur(function(){
			var emailVal = $("#email").val();
			if( emailVal.trim() == "" ){
				negativeMsg($("#emailMsg"), "이메일은 필수 입력사항입니다.");
				$("#email").val("");
				$("#email").focus();
				return;
			} else {
				negativeMsg($("#nameMsg"), "");
			} // end else
				
			/* if( /[0-9]/g.test($("#name").val()) ){
				negativeMsg($("#nameMsg"), "이름에는 숫자가 들어갈 수 없습니다.");
				$("#name").val("");
				return;
			} // end if */
			
			$.ajax({
				url:"email_dup_check.do",
				type:"post",
				data:"email="+$("#email").val(),
				dataType:"json",
				success:function( json ){
					if( json.emailDupResult ){
						$("#emailMsg").removeClass("negativeResult");
						$("#emailMsg").addClass("positiveResult");
						$("#emailMsg").html("[<strong> "+emailVal+" </strong>]" + "은 사용할 수 있는 이메일 입니다.");
					} else {
						negativeMsg($("#emailMsg"),"[<strong> "+emailVal+" </strong>]" + "은 이미 사용중인 이메일 입니다.");
						$("#email").val("");
						$("#email").focus();
					} // end else
				}, // success
				error:function(xhr){
					
				} // error
			}); // ajax
		}); // blur
		
		$("#name").blur(function(){
			var nameVal = $("#name").val();
			if( nameVal.trim() == "" ){
				negativeMsg($("#nameMsg"), "이름을 입력해 주세요.");
				$("#name").val("");
				return;
			} else {
				negativeMsg($("#nameMsg"), "");
			} // end else
				
			if( /[0-9]/g.test($("#name").val()) ){
				negativeMsg($("#nameMsg"), "이름에는 숫자가 들어갈 수 없습니다.");
				$("#name").val("");
				return;
			} // end if
		}); // blur
		
		$("#birthMonth").blur(function(){
			var month = $("#birthMonth").val();
			if( /[0-9]/g.test(month) ){
				negativeMsg($("#birthMsg"), "");
			} else {
				negativeMsg($("#birthMsg"), "생년월일에는 숫자 이외의 값이 들어갈 수 없습니다.");
				$("#birthMonth").val("");
				return;
			} // end else
				
			if( month.trim() == "" ){
				negativeMsg($("#birthMsg"), "생년월일에는 숫자 이외의 값이 들어갈 수 없습니다.");
				$("#birthMonth").val("");
				return;
			} // end if
		}); // blur
		
		$("#birthDate").blur(function(){
			var date = $("#birthDate").val();
			if( /[0-9]/g.test(date) ){
				negativeMsg($("#birthMsg"), "");
			} else {
				negativeMsg($("#birthMsg"), "생년월일에는 숫자 이외의 값이 들어갈 수 없습니다.");
				$("#birthDate").val("");
				return;
			} // end else
				
			if( date.trim() == "" ){
				negativeMsg($("#birthMsg"), "생년월일에는 숫자 이외의 값이 들어갈 수 없습니다.");
				$("#birthDate").val("");
				return;
			} // end if
		}); // blur
		
		$("#phone2").blur(function(){
			var phone2Num = $("#phone2").val();
			if( phone2Num.length < 3 ){
				negativeMsg($("#phoneMsg"), "휴대폰 번호를 정확히 입력해 주세요.");
				$("#phone2").focus();		
				return;
			} // end if
		});
		
		$("#phone3").blur(function(){
			var phone3Num = $("#phone3").val();
			if( phone3Num.length < 4 ){
				negativeMsg($("#phoneMsg"), "휴대폰 번호를 정확히 입력해 주세요.");
				$("#phone3").focus();		
				return;
			} // end if
		});
		
		
		$("#submitBtn").click(function(){
			if($("#user_id").val().trim() == ""){
				negativeMsg($("#idMsg"), "아이디를 입력해 주세요.");
				$("#user_id").val("");
				$("#user_id").focus();
				return;
			} // end if
			
			if( /[ㄱ-힣]/g.test($("user_id").val()) ){
				negativeMsg($("#idMsg"), "한글 아이디는 사용할 수 없습니다.");
				$("#user_id").val("");
				$("#user_id").focus();
				return;
			} // end if
			
			var birthY = $("#birthYear").val();
			var birthM = $("#birthMonth").val();
			var birthD = $("#birthDate").val();
			
			var birthDay = birthY+"-"+birthM+"-"+birthD;
			
			var phone1 = $("#phone1").val();
			var phone2 = $("#phone2").val();
			var phone3= $("#phone3").val();
			var phoneNum = phone1+"-"+phone2+"-"+phone3;
			
			$("#birth").val(birthDay);
			$("#phone").val(phoneNum);
			
			var frm = document.frm;
			frm.action = "join_success.do";
			frm.submit();
		}); // click

		function negativeMsg(element, msg){
			$(element).removeClass("positiveResult");
			$(element).addClass("negativeResult");
			$(element).html(msg);
		} // negativeMsg function
		
	}); // ready
</script>
</head>
<body style="background-color:#f1f2f6;">
		<header id="header" style="position:fixed; top:0; left:0; width:100%;">
			<c:import url="/common/jsp/navbar.jsp"/>
		</header>
		<div class="container" id="myInfoContainer" style="max-width:740px; border-radius:5px; margin-top:100px; padding-top:0;">
			<form method="post" id="frm" name="frm">
				<div class="row">
					<h3 class="col-xs-12">회원가입</h3>
					<p class="col-xs-12">로그인 정보 및 가입 정보를 입력하세요.</p>
				</div>
				<div class="row mypageRow">
					<div class="form-group" style="overflow:hidden;">
						<label class="col-sm-2 col-form-label" for="user_id">아이디</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="user_id" id="user_id" placeholder="아이디" />
						</div>
						<span class="col-sm-offset-2 col-sm-10 msgSpanNode" id="idMsg"></span>
					</div>
					<div class="form-group" style="overflow:hidden;">
					<label class="col-sm-2 col-form-label">비밀번호</label>
						<div class="col-sm-10">
							<input type="password" class="form-control" placeholder="비밀번호" name="password" id="password"/>
						</div>
						<span class="col-xs-offset-2 col-xs-10 msgSpanNode" id="passMsg"></span>
					</div>
					<div class="form-group" style="overflow:hidden;">
						<label class="col-sm-2 col-form-label">비밀번호 확인</label>
						<div class="col-sm-10">
							<input type="password" class="form-control" placeholder="비밀번호 재확인" id="rePassword" />
						</div>
						<span class="col-xs-offset-2 col-xs-10 msgSpanNode" id="chkPassMsg"></span>
					</div>
				</div>
				<div class="row mypageRow">
					<div class="form-group" style="overflow:hidden;">
						<label class="col-sm-2 col-form-label">이름</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="name" name="name" />
						</div>
						<span class="col-xs-offset-2 col-xs-10 msgSpanNode" id="nameMsg"></span>
					</div>
					<div class="form-group" style="overflow:hidden;">
						<label class="col-sm-2 col-form-label">이메일</label>
						<div class="col-sm-10">
							<input type="email" class="form-control" id="email" name="email" />
						</div>
						<span class="col-sm-offset-2 col-sm-10 msgSpanNode" id="emailMsg"></span>
					</div>
					<div class="form-group" style="overflow:hidden;">
						<label class="col-sm-2 col-form-label">생년월일</label>
						<!-- <div class="col-sm-10">
							<input type="text" class="form-control" name="birth" />
						</div> -->
						<div class="col-sm-10">
							<div class="col-xs-3" style="padding:0;">
								<c:set var="now" value="<%=new java.util.Date()%>" />
								<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set> 
								<select id="birthYear" class="form-control" style="text-align-last:center;">
									<c:forEach var="birthYear" begin="${ sysYear - 100 }" end="${ sysYear }">
										<option value="${ birthYear }" ${ sysYear eq birthYear ? 'selected="selected"':'' }><c:out value="${ birthYear }" />년</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-xs-1" style="padding:0; text-align:center; line-height:34px;">년</div>
							<div class="col-xs-3" style="padding:0;">
								<input type="text" class="form-control" id="birthMonth" maxlength="2" style="text-align:center;"/>
							</div>
							<div class="col-xs-1" style="padding:0; text-align:center; line-height:34px;">월</div>
							<div class="col-xs-3" style="padding:0;">
								<input type="text" class="form-control" id="birthDate" maxlength="2" style="text-align:center;"/>
							</div>
							<div class="col-xs-1" style="padding:0; text-align:center; line-height:34px;">일</div>
						</div>
						<input type="hidden" name="birth" id="birth" />
						<span class="col-xs-offset-2 col-xs-10 msgSpanNode" id="birthMsg"></span>
					</div>
					<div class="form-group" style="overflow:hidden;">
						<label class="col-sm-2 col-form-label">연락처</label>
						<div class="col-sm-10">
							<div class="col-xs-4" style="padding:0; padding-right:15px;">
								<select id="phone1" class="form-control">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="019">019</option>
								</select>
							</div>
							<div class="col-xs-4" style="padding:0; ">
								<input type="text" class="form-control" id="phone2" maxlength="4" style="text-align:center;"/>
							</div>
							<div class="col-xs-4" style="padding:0; padding-left:15px;">
								<input type="text" class="form-control" id="phone3" maxlength="4" style="text-align:center;"/>
							</div>
							<input type="hidden" name="phone" id="phone" />
					</div>
					<span class="col-xs-offset-2 col-xs-10 msgSpanNode" id="phoneMsg"></span>
					<div style="text-align:center; padding-top:20px;" class="col-xs-12">
						<input type="button" value="회원가입" style="background:#000; color:#fff;" class="btn btn-default form-control" id="submitBtn" /> 
					</div>
					
				</div>
			</form>
		<ul style="margin-top:10px;">
			<li>작성된 정보는 아이디 찾기, 비밀번호 찾기에 사용 됩니다. <a href="javascript:history.back()">이전 화면</a></li>
		</ul>
		</div>
</body>
</html>