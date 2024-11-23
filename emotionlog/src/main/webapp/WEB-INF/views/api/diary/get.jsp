<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.emotionlog.domain.DiaryVO"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.TimeZone"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
					<input type='hidden' id='dno' name='dno'
						value='<c:out value="${board.dno}"/>'>
				</form>

				<div class="panel panel-default">

					<div class="panel-heading">Board Read Page</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<!-- register.jsp 에 있던 <form>태그는 조회페이지에서는 그다지 필요하지 않으므로 제거~! -->
						<div class="form-group">
							<label>dno</label> <input class="form-control" name='dno'
								value='<c:out value="${board.dno}"/>' readonly="readonly">
						</div>

						<div class="form-group">
							<label>Title</label> <input class="form-control" name='title'
								value='<c:out value="${board.title}"/>' readonly="readonly">
						</div>

						<div class="form-group">
							<label>Text area</label>
							<textarea class="form-control" rows="3" name='content'
								readonly="readonly"><c:out value="${board.content}" /></textarea>
						</div>
						<div class="form-group">
							<label>emotion_status</label>
							<textarea class="form-control" rows="1" name='emotion_status'
								readonly="readonly"><c:out value="${board.emotion_status}" /></textarea>
						</div>
						<%-- 		<div class="form-group">
								<label>Writer</label> <input class="form-control" name='writer'
									value='<c:out value="${board.writer}"/>' readonly="readonly">
							</div> --%>

					<button data-oper='modify' class="btn btn-default">Modify</button>
					<button data-oper='list' class="btn btn-info">List</button> 

					</div>
					<!-- end panel-body -->

				</div>

				<!-- end panel-body -->


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

<script>
$(document).ready(function(){//dom 구조가 만들어져 준비되어진 상태 -> ready -> call back function

	  var operForm = $("#operForm");

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
