<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>Pro를 지향하는 Propofol</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="common/css/main_css190520.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
	window.onload = function(){
		if( document.getElementById("headCopyImpact") ){
			var headCopyImpact = document.getElementById("headCopyImpact");
			var colorArray = "";
			setInterval(function(){
				colorArray = "#";
				for(var i=0; i < 6; i++){
					colorArray += Math.floor(Math.random() * 16).toString(16);
				} // end for
				headCopyImpact.style.color = colorArray;
			}, 3000);
		}
	} // onload function
</script>
</head>
<body>
	
	<header id="header">
		<c:import url="/common/jsp/navbar.jsp"/>
	</header>
	<section>
		<c:choose>
			<c:when test="${ memberInform ne null }">
				<div class="container-fluid">
					<div class="row" id="firstRow">
						<h1 id="headCopy">
							<span style="color:#ffeaa7; transition:color 0.3s;" id="headCopyImpact"><c:out value="${ memberInform.name }" /></span>님을 위한 creative zone<br />
							Propofol
						</h1>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="container-fluid">
					<div class="row" id="firstRow">
						<h1 id="headCopy">
							당신을 위한 creative zone<br />
							Propofol
						</h1>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
		<div class="container" id="searchConditions">
			<div class="row">
				<div class="col-xs-12" style="text-align:center;">
					<a href="#">최고의 Portfolio</a> | <a href="#">조회수 순</a> | <a href="#">댓글 순</a>
				</div>
			</div>
		</div>
		<div class="container-fluid" id="portfolioList">
			<div class="row">
				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3" style="padding:10px; height:300px;">
					<div style="width:100%; height:100%; position:relative;">
						<a href="#"><img src="/proportfolio/common/imgs/img1.gif" style="display:block; min-width:100%; min-height:100%; position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); " /></a>
					</div>
				</div>
				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3" style="padding:10px; height:300px;">
					<div style="width:100%; height:100%; position:relative;">
						<a href="#"><img src="/proportfolio/common/imgs/img2.gif" style="display:block; min-width:100%; min-height:100%; position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); " /></a>
					</div>
				</div>
				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3" style="padding:10px; height:300px;">
					<div style="width:100%; height:100%; position:relative;">
						<a href="#"><img src="/proportfolio/common/imgs/img3.gif" style="display:block; min-width:100%; min-height:100%; position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); " /></a>
					</div>
				</div>
				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3" style="padding:10px; height:300px;">
					<div style="width:100%; height:100%; position:relative;">
						<a href="#"><img src="/proportfolio/common/imgs/img4.gif" style="display:block; min-width:100%; min-height:100%; position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); " /></a>
					</div>
				</div>
				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3" style="padding:10px; height:300px;">
					<div style="width:100%; height:100%; position:relative;">
						<a href="#"><img src="/proportfolio/common/imgs/img5.gif" style="display:block; min-width:100%; min-height:100%; position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); " /></a>
					</div>
				</div>
				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3" style="padding:10px; height:300px;">
					<div style="width:100%; height:100%; position:relative;">
						<a href="#"><img src="/proportfolio/common/imgs/img6.gif" style="display:block; min-width:100%; min-height:100%; position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); " /></a>
					</div>
				</div>
				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3" style="padding:10px; height:300px;">
					<div style="width:100%; height:100%; position:relative;">
						<a href="#"><img src="/proportfolio/common/imgs/img7.gif" style="display:block; min-width:100%; min-height:100%; position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); " /></a>
					</div>
				</div>
				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3" style="padding:10px; height:300px;">
					<div style="width:100%; height:100%; position:relative;">
						<a href="#"><img src="/proportfolio/common/imgs/img8.gif" style="display:block; min-width:100%; min-height:100%; position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); " /></a>
					</div>
				</div>
				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3" style="padding:10px; height:300px;">
					<div style="width:100%; height:100%; position:relative;">
						<a href="#"><img src="/proportfolio/common/imgs/img4.gif" style="display:block; min-width:100%; min-height:100%; position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); " /></a>
					</div>
				</div>
				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3" style="padding:10px; height:300px;">
					<div style="width:100%; height:100%; position:relative;">
						<a href="#"><img src="/proportfolio/common/imgs/img6.gif" style="display:block; min-width:100%; min-height:100%; position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); " /></a>
					</div>
				</div>
				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3" style="padding:10px; height:300px;">
					<div style="width:100%; height:100%; position:relative;">
						<a href="#"><img src="/proportfolio/common/imgs/img8.gif" style="display:block; min-width:100%; min-height:100%; position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); " /></a>
					</div>
				</div>
				<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3" style="padding:10px; height:300px;">
					<div style="width:100%; height:100%; position:relative;">
						<a href="#"><img src="/proportfolio/common/imgs/img7.gif" style="display:block; min-width:100%; min-height:100%; position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); " /></a>
					</div>
				</div>
			</div>
			<div class="row" id="whiteSpace" style="height:100px;">
		</div>
		</div>
		
	</section>
	<footer>
	
	</footer>
	<c:if test="${ joinSuccess eq true }">
		<script type="text/javascript">
			window.onload = function(){
				alert("${ name } 님의 회원가입을 환영합니다! 로그인 후 서비스를 이용하실 수 있습니다.");
			} // onload function
		</script>
	</c:if>
</body>
</html>