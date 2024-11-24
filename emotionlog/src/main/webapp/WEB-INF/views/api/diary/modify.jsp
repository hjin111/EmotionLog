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
				<form id='modifyForm' action="/api/diary/modify" method="post">
					<input type='hidden' id='dno' name='dno' value='<c:out value="${diary.dno}"/>'>

					<div class="panel panel-default">

						<div class="panel-heading">diary Modify Page</div>
						<!-- /.panel-heading -->
						<div class="panel-body">

							<br/>
							<!-- 일자 -->				
							<div class="form-group">
								<label>일자</label> 
								<input class="form-control" id = 'regdate' name='regdate'
									value='<fmt:formatDate pattern="yyyy/MM/dd" value="${diary.regdate}"/>'
									readonly="readonly">
							</div>
							
							<!-- 제목 -->
							<div class="form-group">
								<label>제목</label> <input class="form-control" name='title' value='<c:out value="${diary.title}"/>' ">
							</div>

							<!-- 내용 -->
							<div class="form-group">
								<label>내용</label>
								<textarea class="form-control" rows="3" name='content'><c:out value="${diary.content}" /></textarea>
							</div>
							
							<!-- 감정 -->
							<div class ="dropdown">
								<label>감정</label><br/>				
								<select name = 'emotion_status'>
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
	

							<!-- 수정일 -->
							<c:if test="${not empty diary.update_date}">
								<div class="form-group">
									<label>수정일</label> <input class="form-control"
										name='update_date'
										value='<fmt:formatDate pattern="yyyy/MM/dd" value="${diary.update_date}"/>'
										readonly="readonly">
								</div>
							</c:if>
							
							<br/>
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
	 let formObj = $("#modifyForm");  // jQuery 선택자를 사용하여 HTML 페이지에서 <form> 요소를 선택하고, 이를 변수에 할당

	$('button').on("click",function(e){
		e.preventDefault(); // 기본 동작을 막기(폼제출방지,페이지이동방지,기타기본동작방지)
		let operation = $(this).data("oper"); // javascript 에서는 <button>태그의 'data-oper' 속성을 이용해서 원하는 기능을 동작하도록 처리
		console.log(operation);
		
		
		if(operation === 'list'){
            // 리스트 페이지 이동
            formObj.attr("action", "/api/diary/list").attr("method", "get");
		}else{
			//제목 값 안넣었을때
			if(!formObj.find("input[name='title']").val()){
				alert("제목 값을 입력해주세요.");
				return false;
			}
			//내용 값 안넣었을때
			if(!formObj.find("textarea[name='content']").val()){
				alert("내용 값을 입력해주세요.");
				return false;
			}
			//감정 값 안넣었을때
			if(!formObj.find("option:selected").val()){
				alert("감정 상태를 선택하세요.");
				return false;
			}			
			
            if (operation === 'remove') {
                formObj.attr("action", "/api/diary/remove");
            } else if (operation === 'modify') {
                formObj.attr("action", "/api/diary/modify");
            }
		}

 		formObj.submit(); // 마지막에 직접 submit() 수행
	});
 });

</script>
</body>
</html>
