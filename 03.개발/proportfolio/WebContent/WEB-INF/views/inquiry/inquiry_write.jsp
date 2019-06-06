<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>문의하기</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="/proportfolio/common/css/main_css190520.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style type="text/css">
	body{ margin:0; }
	#wrap{ overflow:hidden; margin:0 auto; padding-top:70px;}
	/* 
	header{ height:80px; overflow:hidden; border-bottom:2px solid #ccc; }
	header > #logo{ padding-left:20px; padding-right:20px; height:80px; line-height:80px; text-align:center; font-size:40px; font-weight:bold; float:left;}
	header > nav { float:left;}
	header > nav > ul { overflow:hidden; margin:0; }
	header > nav > ul > li { float:left; list-style:none; padding-left:20px; padding-right:20px; font-size:22px; line-height:80px; font-weight:bold; }
	 */
	article{ width:1200px; margin:0 auto; overflow:hidden; min-height:700px; padding:20px 0;}
	article > #board_title{ font-size:30px; margin:0;}
	article > #seeMyWriting{ float:right; margin-top:50px; margin-bottom:0;}
	
	
	
	#contentWrap{ margin:20px auto; margin-bottom:30px; }
	#inquiryBoard th{ background-color:#eaeaea; padding-top:15px; padding-bottom:15px; font-size:16px; font-weight:bold; }
	#inquiryBoard td{ border-bottom:1px solid #ccc; padding-top:15px; padding-bottom:15px; font-size:16px; text-align:center; }
	
	#titleRow > th:nth-child(1){ width:80px; }
	#titleRow > th:nth-child(2){ width:480px; }
	#titleRow > th:nth-child(3){ width:80px; }
	#titleRow > th:nth-child(4){ width:80px; }
	#titleRow > th:nth-child(5){ width:80px; }
	
	#searchOption, #searchContent, #searchBtn{ text-align:center; display: table-cell; vertical-align: middle; height:40px; font-size:16px; }
	#searchOption{ width: 120px; }
	#searchContent{ height:34px; }
	#searchBtn{ padding-left:20px; padding-right:20px; }
	
	#writeInquiry{ padding-left:20px; padding-right:20px; height:40px; float:right; background-color:#5e5e5e; color:white; font-weight:bold; border:0; border-radius:5px; font-size:17px; }
	
	#subTitle{ display:block; width:100%; height:40px; padding:0 10px; box-sizing:border-box; border:1px solid #ccc; border-radius:5px; outline:none; font-size:16px; margin-bottom:15px; }
	#content{ display:block; width:100%; height:400px; padding:10px; box-sizing:border-box; border:1px solid #ccc; border-radius:5px; font-size:16px; resize:none; outline:none;}
	
	
	#frm > #fileGroup { margin-top:20px; font-size:0; }
	#frm > #fileGroup * { height:40px; }
	#frm > #fileGroup > label { display:inline-block; width:120px; padding:0 15px; line-height:40px; font-size:16px; font-weight:bold; a}
	#frm > #fileGroup > span{ display:inline-block; width:1000px; float:right; text-align:right; overflow:hidden;}
	#frm > #fileGroup > span > input[type=text]{ width:900px; box-sizing:border-box; display:block; float:left; border-radius:5px;}
	#frm #inputFile{ width:100px; font-size:16px; font-weight:bold; padding:0; float:left; border-radius:5px;background-color:#3498db; color:white; border:none;}	
	
	#frm #btnGroup{ text-align:center; margin-top:20px; }
	#frm #btnGroup .btn{ display:inline-block; width:120px; height:40px; background-color:#343a40; color:white; font-size:16px; font-weight:bold; }
	#frm #btnGroup .btn:first-child{ margin-right:15px; }
	
	
	
	/* footer{ font-size:40px; text-align:center; line-height:80px; font-weight:bold; height:80px; border-top:2px solid #ccc } */
	
	
	
</style>
<script type="text/javascript">
	window.onload = function(){
		var insertBtn = document.getElementById("inquiryInsertBtn"); 
		
		insertBtn.addEventListener("click", inquiryWriteProcess)
	
		function inquiryWriteProcess(){
			var confirmMsg = confirm("문의사항을 작성 완료 하시겠습니까?");
			if(confirmMsg){
				var frm = document.frm;
				frm.action = "insert_inquiry.do";
				frm.submit();
			} // end if
		} // inquiryWriteProcess
	} // onload function
	
	
</script>
</head>
<body>
	<header id="header">
		<c:import url="/common/jsp/navbar.jsp"/>
	</header>
	<div id="wrap" class="container">
		<section class="row">
			<article class="col-xs-12">
				<h1 id="board_title">문의 작성</h1>
				<div id="contentWrap">
					<form name="frm" id="frm">
						<input type="hidden" name="user_id" value="${ memberInform.user_id }" />
						<input type="text" placeholder="제목" id="subTitle" name="subject" />
						<textarea id="content" placeholder="내용을 입력해주세요." name="user_contents"></textarea>
						<div id="btnGroup">
							<input class="btn" type="button" value="문의 남기기" id="inquiryInsertBtn"/>
							<input class="btn" type="button" value="뒤로가기" onclick="history.back()" />
						</div>
					</form>
				</div>
			</article>
		</section>

	</div>
</body>
</html>