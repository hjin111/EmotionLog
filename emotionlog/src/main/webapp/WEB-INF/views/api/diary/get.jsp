<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.emotionlog.domain.DiaryVO"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.TimeZone"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>EmotionLog_list</title>
    <!-- 부트스트랩 CSS 추가 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" integrity="sha512-mSYUmp1HYZDFaVKK//63EcZq4iFWFjxSL+Z3T/aCt4IO9Cejm03q3NKKYN6pFQzY0SBOr8h+eCIAZHPXcpZaNw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<style>
    /* 전체 달력 중앙 정렬 */
    .calendar-wrapper {
        display: flex;
        justify-content: center; /* 가로 중앙 정렬 */
        align-items: center;
        margin: 0 auto;
        padding: 20px;
    }

    /* 테이블 스타일 */
    .calendar-table {
        table-layout: fixed;
        width: auto;
        margin: 0 auto; /* 테이블 자체 중앙 정렬 */
    }

    .calendar-table th,
    .calendar-table td {
        text-align: center; /* 날짜 번호 중앙 정렬 */
        vertical-align: top; /* 내용 위쪽 정렬 */
        height: 150px; /* 셀 높이 고정 */
        width: 150px; /* 셀 너비 고정 */
    }

    .calendar-card {
        display: flex;
        flex-direction: column;
        justify-content: flex-start; /* 카드 내부 내용 위쪽 정렬 */
        align-items: flex-start; /* 텍스트 왼쪽 정렬 */
        height: 100%;
        width: 100%;
        border: 1px solid #ddd;
        border-radius: 8px;
        background-color: #f8f9fa;
        padding: 10px;
        overflow: hidden;
    }
    
    
    .calendar-card .date {
        font-size: 18px;
        font-weight: bold;
        text-align: center; /* 날짜 번호는 중앙 정렬 */
        width: 100%;
        margin-bottom: 8px;
    }

    .calendar-card .card-text {
        font-size: 14px;
        line-height: 1.5;
        text-align: left; /* 텍스트 왼쪽 정렬 */
        overflow-wrap: break-word;
        word-break: break-word;
        overflow-y: auto; /* 내용이 넘치면 스크롤 */
        max-height: calc(100% - 30px); /* 날짜 번호를 제외한 높이 제한 */
    }
</style>
</head>
<body>
	<div class="container my-4">
		<div class="row justify-content-center">
			<div class="col-md-8">

				<!-- 다양한 상황을 처리하기 위해서 form 태그 이용~~ -->
				<form id='operForm' action="/api/diary/modify" method="get">
					<input type='hidden' id='dno' name='dno' value='<c:out value="${diary.dno}"/>'>
					<input type='hidden' id='regdate' name='regdate' value='<fmt:formatDate value="${diary.regdate}" pattern="yyyy/MM/dd" />'>
				</form>

				<div class="panel panel-default">
					<div class="panel-heading">diary Read Page</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
	
						<br/>
						<!-- 일자 -->							
						<div class="form-group">
				            <label>일자</label>
				            <input type="text" id='regdate' name="regdate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${diary.regdate}"/>'  readonly="readonly" class="form-control" required>
				        </div>

						<!-- 제목 -->
						<div class="form-group">
							<label>제목</label> <input class="form-control" name='title'
								value='<c:out value="${diary.title}"/>' readonly="readonly">
						</div>

						<!-- 내용 -->
						<div class="form-group">
							<label>내용</label>
							<textarea class="form-control" rows="3" name='content'
								readonly="readonly"><c:out value="${diary.content}" /></textarea>
						</div>
						
						<!-- 감정 -->
						<div class ="dropdown">
							<label>감정</label><br/>				
							<select name = 'emotion_status' disabled>
								<option value="" <c:out value="${diary.emotion_status == null?'selected':'' }"/>>--</option>
               					<option value="joy" <c:out value="${diary.emotion_status eq 'joy'?'selected':'' }"/>>기쁨</option>
               					<option value="anger" <c:out value="${diary.emotion_status eq 'anger'?'selected':'' }"/>>분노</option>
               					<option value="sad" <c:out value="${diary.emotion_status eq 'sad'?'selected':'' }"/>>슬픔</option>
               					<option value="fun" <c:out value="${diary.emotion_status eq 'fun'?'selected':'' }"/>>즐거움</option>
               					<option value="love" <c:out value="${diary.emotion_status eq 'love'?'selected':'' }"/>>사랑</option>
               					<option value="hate" <c:out value="${diary.emotion_status eq 'hate'?'selected':'' }"/>>증오</option>
							</select>
						</div>

						
						<br/>
						<button data-oper='modify' class="btn btn-default">Modify</button>
						<button data-oper='list' class="btn btn-info">List</button> 

					</div>
					<!-- end panel-body -->
				</div>
				<!-- end panel-body -->

				<br/>
				<!-- 댓글 -->
				<div class ="panel panel-default">
					<div class = "panel-heading">
						<i class="fa fa-comments fa-fw"></i> Reply
					</div>
					
					<div class ="panel-body">
						<ul class ="chat">
							<li class= "left clearfix" data-rno ='12'>
								<div>
									<div class ="header">
										<strong class ="primary-font">user00</strong>
										<small class ="pull-right text-muted">2018/01/01 13:13</small>
									</div>
									<p>Good job!</p>
								</div>
							</li>	
						</ul>
					</div>
				</div>
				<!-- 댓글 끝 -->
			</div>
			

		</div>
	</div>

<!-- 부트스트랩 JS & JavaScript -->
<!-- jQuery를 가장 먼저 로드 -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- Bootstrap JS 및 Datepicker JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js"></script>

<script type ="text/javascript" src="/resources/js/reply.js"></script>
<script>
$(document).ready(function(){//dom 구조가 만들어져 준비되어진 상태 -> ready -> call back function

	 console.log("===================");
	 console.log("JS TEST");
	 let dnoValue = '<c:out value ="${diary.dno}"/>';
	 
	 // for replyService add test
	/*  replyService.add(
		{reply:"JS TEST", replyer: "tester", dno:dnoValue}
		,
		function(result){
			alert("RESULT:"+result);
		}
	 ); */

	 // for replyService list test
/* 	 replyService.getList({dno:dnoValue,page:1},function(list){
		 for(let i = 0 , len = list.length||0; i <len; i++){
			 console.log(list[i]);
		 }
	 }); */
	 
	 // for replyService delete test
/* 	 replyService.remove(3,
		function(count){
			 console.log(count);
			 if(count === "success"){
				 alert("REMOVED");
			 }
	 	},
		function(err){
	 		alert('ERROR');
	 	}
	 ); */
	 
	 // for replyService modify test
/* 	 replyService.update(
		 {
			 rno   : 22,
			 dno   : dnoValue,
			 reply : "Modified Reply..." 
		 },
		 function(result){
			alert("수정 완료...");	 
		 }
	 ); */
	 
	 // for replyService get test
/* 	 replyService.get(10,function(data){
		 console.log(data);
	 }) */
	 
	  let operForm = $("#operForm");

	  // 사용자가 수정 버튼을 누르는 경우에는 bno 값을 같이 전달하고 <form> 태그를 submit 시켜서 처리
	  $("button[data-oper='modify']").on("click",function(e){
		  operForm.attr("action","/api/diary/modify").submit();
	  });
	  
	  // 아무런 데이터가 필요하지 않으므로 , <form> 태그 내에 bno 태그를 지우고 submit을 통해서 리스트 페이지로 이동
	  $("button[data-oper='list']").on("click",function(e){
		  operForm.find("#dno").remove();
		  operForm.attr("action","/api/diary/list")
		  operForm.submit();
	  });
});

</script>
</body>
</html>
