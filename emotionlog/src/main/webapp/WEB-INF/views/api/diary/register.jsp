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
				<div class="panel panel-default">
					<div class="panel-heading">diary Read Page</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
    					<form id="registerForm" action="/api/diary/register" method="post">
    						<input type='hidden' id='username' name='username' value="<c:out value="${username}" />">
    				
	
							<div class="form-group">
					            <label>date</label>
					            <input type="text" id='regdate' name="regdate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${regdate}"/>'  readonly="readonly" class="form-control" required>
					        </div>
					        
					        <div class="form-group">
					            <label>Title:</label>
					            <input type="text" name="title" class="form-control" required>
					        </div>
	
							<div class="form-group">
								<label>Text area</label>
								<textarea class="form-control" rows="3" name='content'/></textarea>
							</div>
							<div class="form-group">
								<label>emotion_status</label>
								<textarea class="form-control" rows="1" name='emotion_status' /></textarea>
							</div>
	
		                 	<button type="submit" class="btn btn-default">Submit Button</button>
                			<button type="reset" class="btn btn-default">Reset Button</button>
                			<button type='submit' data-oper='list' class="btn btn-info">List</button>
                			
					    </form>
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
let formObj = $("#registerForm");  // 올바른 선택자: id 기반 선택 (등록폼의 아이디를 #registerForm으로 선택)

$('button').on("click",function(e){
	e.preventDefault(); // 기본 동작을 막기(폼제출방지,페이지이동방지,기타기본동작방지)
	let operation = $(this).data("oper"); // javascript 에서는 <button>태그의 'data-oper' 속성을 이용해서 원하는 기능을 동작하도록 처리
	console.log(operation);
	

	if (operation === 'list') {
		// move to list
		formObj.attr("action", "/api/diary/list").attr("method", "get");
	}
	formObj.submit(); // 마지막에 직접 submit() 수행
	});
</script>
</body>
</html>
