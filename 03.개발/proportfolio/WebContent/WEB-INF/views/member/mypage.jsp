<%@page import="java.net.URLDecoder"%>
<%@page import="kr.co.dbslab.user.member.domain.Member"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>마이 페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="common/css/main_css190520.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="common/js/jquery.form.min.js"></script>
<script type="text/javascript">
	$(function(){
		var imgWrap = document.getElementById("mypageProfilePic");
		imgWrap.style.height = imgWrap.clientWidth+"px";
		
		$(window).resize(function(){
			imgWrap.style.height = imgWrap.clientWidth+"px";
		});
		
		$("#changeProfilePicBtn").click(function(){
			$("#upfile").click();
		}); // click
		
		$("#upfile").change(fileDetectProc);
		
		function fileDetectProc(){
				var upfile = document.getElementById("upfile");
				var fReader = new FileReader();
				fReader.readAsDataURL(upfile.files[0]);
				fReader.onloadend = function(event){
					var ext = ["jpg","gif","png"];
					var fileName = $("#upfile").val().split(".");
					var inputExt = fileName[fileName.length - 1].toLowerCase();
					
					var flag = false;
					for(var i = 0; i < ext.length; i++){
						if(ext[i] == inputExt){
							flag = true;
						} // end if
					} // end for

					var img = document.getElementById("profileBigImg");
					
					if( flag == false ){
						alert("업로드 가능한 이미지 형식은 jpg, gif, png 입니다.");
						img.src = "/proportfolio/common/profile_img/default_img.png";
						return;
					} // end if
					
			        $("#uploadFrm").ajaxForm({
			            url : "/proportfolio/mr_upload_process.do",
			            enctype : "multipart/form-data",
			            dataType : "json",
			            error : function( xhr ){
			            		alert(xhr.status + "///" + xhr.statusText);
							alert("에러발생. 기술 지원에 문의하세요.");
			            },
			            success : function( jsonObj ){
			                if( jsonObj.updateResult ){
			                		alert("이미지 업로드에 성공하였습니다.");
			                		$("#profileBigImg").attr("src", event.target.result);
			                		$("#profileImg > img").attr("src", event.target.result);
			                } // en
			            }
			        }); // ajaxForm
			        $("#uploadFrm").submit() ;
				    
				} // onloadend
		} // fileDetectProce
		
	}); // ready 
</script>
</head>
<body>
	<header id="header">
		<c:import url="/common/jsp/navbar.jsp"/>
	</header>
	<div class="container">
		<div class="row">
			<div style="text-align:center;">
				<div id="mypageProfilePic" >
					<img src="/proportfolio/common/profile_img/${ memberInform.profile_pic }" id="profileBigImg" style="width:100%;" />
					<%-- <img src="/proportfolio/common/profile_img/${ memberInform.profile_pic }" id="profileBigImg" style="width:100%;" /> --%>
				</div>
				<br />
				<button id="changeProfilePicBtn" title="프로필 사진 바꾸기" style="background-color:#fff;">
					<span class="glyphicon glyphicon-camera"></span>
				</button>
				<form name="uploadFrm" id="uploadFrm" enctype="multipart/form-data" method="post">
					<input id="upfile" type="file" name="upfile" id="upfile" class="inputBox" style="display:none;" />
				</form>
			</div>
		</div>
	</div>
	<div class="container" id="mypageWrap">
		<div class="row mypageRow">
			<a href="chk_passwd_page.do">
			<div class="col-xs-3  glyphiconZone">
				<span class="glyphicon glyphicon-user"></span>
			</div>
			<div class="col-xs-9">
					<h4>내 정보 관리</h4>
					<p>이름, 연락처 변경을 할 수 있어요.</p>
			</div>
			</a>
		</div>
		<div class="row mypageRow">
			<a href="change_password.do">
			<div class="col-xs-3  glyphiconZone">
				<span class="glyphicon glyphicon-lock"></span>
			</div>
			<div class="col-xs-9">
					<h4>비밀번호 변경</h4>
					<p>주기적으로 비밀번호 변경하여 내 정보 보호하기.</p>
			</div>
			</a>
		</div>
		<div class="row mypageRow">
			<a href="/proportfolio/leave_member.do">
			<div class="col-xs-3  glyphiconZone">
				<span class="glyphicon glyphicon-remove-sign"></span>
			</div>
			<div class="col-xs-9">
					<h4>회원 탈퇴</h4>
					<p>Propofol을 더 이상 이용하지 않는다면?</p>
			</div>
			</a>
		</div>
	</div>
	<footer>
		
	</footer>
</body>
</html>