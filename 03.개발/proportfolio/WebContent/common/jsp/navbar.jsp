<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav class="navbar navbar-default" role="navigation" id="navbarParent">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand mainMenu" href="/proportfolio/index.do">Propofol</a>
			<!--navbar-toggle은 모바일 해상도 (min-width: 768px)를 벗어나면 display:none이 되어 보이지 않는다. -->
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#navbar-collapse-by-kjy">
				<span class="sr-only">토글 네비게이션</span> <span class="icon-bar"></span>
				<span class="icon-bar"></span> <span class="icon-bar"></span>
			</button>
		</div>
		<div class="collapse navbar-collapse" id="navbar-collapse-by-kjy">

			<div id="centerDiv">
				<ul class="nav navbar-nav">
					<li class="mainMenu"><a href="#">포트폴리오</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" id="serviceCenter" role="button" aria-expanded="false" style="border-radius:3px;">고객 센터
							<span class="caret"></span>
					</a>
						<ul class="dropdown-menu" role="menu" id="dropdown-menu">
							<li><a href="#">공지사항</a></li>
							<li class="divider"></li>
							<li><a href="#">FAQ</a></li>
							<li><a href="/proportfolio/inquiry_board.do">문의 게시판</a></li>
							<li class="divider"></li>
							<li><a href="#">이용후기</a></li>
						</ul></li>
				</ul>
				<!-- <form class="navbar-form navbar-left" role="search">
        <div class="form-group">
          <input type="text" class="form-control" placeholder="Search">
        </div>
        <button type="submit" class="btn btn-default">Submit</button>
      </form> -->
			</div>

			<ul class="nav navbar-nav navbar-right">
				<!-- 돋보기 아이콘 span태그 클래스에 glyphicon glyphicon-search -->
				<li><a href="#"><span class="glyphicon glyphicon-search" title="포트폴리오 검색"></span></a></li>
				<c:choose>
					<c:when test="${ memberInform ne null }">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle"	data-toggle="dropdown" role="button" aria-expanded="false" id="profileImgWrapperA" title="${ memberInform.name }님"  style="border-radius:3px;"><span id="profileImg" ><img src="/proportfolio/common/profile_img/${ memberInform.profile_pic }" style="width:100%; display:block;" /></span><span class="visible-xs" style="display:inline-block !important;">&nbsp;<c:out value="${ memberInform.name }" />님 </span><span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="/proportfolio/mypage.do" >마이페이지</a></li>
							<li class="divider"></li>
							<li><a href="/proportfolio/logout.do">로그아웃</a></li>
						</ul>
						</li>
					</c:when>
					<c:otherwise>
						<li class="mainMenu"><a href="/proportfolio/login.do">로그인</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid -->
</nav>
