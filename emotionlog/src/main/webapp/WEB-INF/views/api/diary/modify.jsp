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
				<form id='operForm' action="/api/diary/modify" method="post">
					<input type='hidden' id='dno' name='dno'
						value='<c:out value="${board.dno}"/>'>

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
							<%-- 		<div class="form-group">
								<label>Writer</label> <input class="form-control" name='writer'
									value='<c:out value="${board.writer}"/>' readonly="readonly">
							</div> --%>


							<div class="form-group">
								<label>RegDate</label> <input class="form-control"
									name='regDate'
									value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}"/>'
									readonly="readonly">
							</div>

							<div class="form-group">
								<label>Update Date</label> <input class="form-control"
									name='updateDate'
									value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate}"/>'
									readonly="readonly">
							</div>

							<button type='submit' data-oper='modify' class="btn btn-default">Modify</button>
							<button type='submit' data-oper='remove' class="btn btn-danger">Remove</button>
							<button type='submit' data-oper='list' class="btn btn-info">List</button>

						</div>
						<!-- end panel-body -->

					</div>
					<!-- end panel-body -->
				</form>


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
	 let formObj = $("form");  // jQuery 선택자를 사용하여 HTML 페이지에서 <form> 요소를 선택하고, 이를 변수에 할당
	 	
	$('button').on("click",function(e){
		e.preventDefault(); // 기본 동작을 막기(폼제출방지,페이지이동방지,기타기본동작방지)
		let operation = $(this).data("oper"); // javascript 에서는 <button>태그의 'data-oper' 속성을 이용해서 원하는 기능을 동작하도록 처리
		console.log(operation);
		
		if(operation === 'remove'){
			formObj.attr("action","/api/diary/remove")
		}else if(operation === 'list'){
			// move to list
			formObj.attr("action","/api/diary/list").attr("method","get");
/* 			// 수정/삭제 페이지에서 목록 페이지로 이동
			// form 태그에서 필요한 부분만 잠시 복사(clone)해서 보관
			let pageNumTag = $("input[name='pageNum']").clone();
			let amountTag = $("input[name='amount']").clone();
			let typeTag = $("input[name='type']").clone();
			let keywordTag = $("input[name='keyword']").clone();
			// form 태그내의 모든 내용은 지워버리고			
			formObj.empty();
			// 다시 필요한 태그만 추가해서 /board/list를 호출하는 형태
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(typeTag);
			formObj.append(keywordTag);
 */		    } else if (operation === 'modify') {
			     formObj.attr("action", "/api/diary/modify").attr("method", "post");
			 }

		formObj.submit(); // 마지막에 직접 submit() 수행
	});
 });

</script>
</body>
</html>
