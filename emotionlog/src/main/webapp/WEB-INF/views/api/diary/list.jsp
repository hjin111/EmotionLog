<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.emotionlog.domain.DiaryVO"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.TimeZone"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp" %>

<body>
	
<div id="calendar-container">
	<%@include file="../includes/navbar.jsp" %>
	

    <div class="centered justify-content-center">
        <div class="col-md-8" >
			
			<!-- form -->
			<form id="actionForm" action="/api/diary/list" method="get">
 			</form>

		<%-- 				   <input type="text" id="date-picker" class="form-control" value="${pick_date}" />
--%>	
			<div class="datepicker-container">
	            <div class="datepicker-header">Select Date</div>
	            <input type="text" id="date-picker" class="datepicker-input" value="${pick_date}">
	        </div>
			   <%-- <h1 class="text-left">Emotion_log : ${year}-${month}</h1> --%>
		    <!-- 헤더 영역 -->
		    <div class="header-container" boder = none>
		        <h1 class="header-title">Emotional Diary Tracking</h1>
		        <div class="divider"></div>
		        <p class="header-subtitle">Your personal emotion tracker - Month: ${year}-${month}</p>
		    </div>   
			    
			    
			<!-- table -->
            <table class="table table-bordered calendar-table">
                <thead>
                    <tr>
                        <th>일</th>
                        <th>월</th>
                        <th>화</th>
                        <th>수</th>
                        <th>목</th>
                        <th>금</th>
                        <th>토</th>
                    </tr>
                </thead>
                <tbody>
                   <c:set var="date" value="1" />
                   <c:forEach var="row" begin="0" end="5">
					    <%-- 날짜가 마지막을 초과했는지 확인 --%>
					    <c:if test="${date > endDay}">
					        <c:set var="finished" value="true" />
					    </c:if>
					
					    <%--날짜가 남아있지 않으면 반복문 종료 --%>
					    <c:if test="${finished != true}">
					        <tr>
					            <c:forEach var="col" begin="1" end="7">
					                <c:choose>
					                    <%--첫 주의 공백 출력 --%>
					                    <c:when test="${row == 0 && col < dayOfWeek}">
					                        <td></td>
					                    </c:when>
					
					                    <%--마지막 날짜 이후 공백 --%>
					                    <c:when test="${date > endDay}">
					                        <td></td>
					                    </c:when>
					
					                    <%--날짜 출력 --%>
					                    <c:otherwise>
					                        <td>
							                    <c:set var="hasEntry" value="false" />
                        						<c:set var="currentRegdate" value="${year}-${month}-${date}" />
						                        <c:set var="currentDno" value="" />
						                        <c:set var="currentUsername" value="${username}" />
						                       
						                        <c:forEach var="entry" items="${diary}">
						                            <fmt:formatDate value="${entry.regdate}" pattern="dd" var="formattedDate"/>
						                            <c:if test="${formattedDate == date}">
						                                <c:set var="hasEntry" value="true" />
						                                <c:set var="currentRegdate" value="${entry.regdate}"/>
						                                <c:set var="currentDno" value="${entry.dno}" />
						                            </c:if>
						                        </c:forEach>
																                        
					                        	<%--조회 페이지 이동 --%>
												<div class="calendar-card move" 
												     data-dno="${currentDno}" 
												     data-has-entry="${hasEntry}"
												     data-regdate="${currentRegdate}"
												     data-username ="${currentUsername}">
										            
										            <div class ="cart-header">
										               ${date} <!-- 날짜 출력 -->										            
										            </div>
										            
										            <div class="card-text">
										                <ul>
														    <!-- diaryList에서 현재 날짜와 같은 제목 출력 -->
														    <c:forEach var="diary" items="${diary}">
														        <!-- diary.regdate를 yyyy-MM-dd 형식으로 변환 -->
														        <fmt:formatDate value="${diary.regdate}" pattern="dd" var="formattedDate" />														        
																<c:if test="${formattedDate + 0 == date + 0}">
														            <li>${diary.title}</li>
														            <li>${diary.emotion_status}</li>
														        </c:if> 
														    </c:forEach>
										                </ul>
										            </div>
										        
										        </div>
							        			<c:set var="date" value="${date + 1}" />
					                        </td>
					                    </c:otherwise>
					                </c:choose>
					            </c:forEach>
					        </tr>
					    </c:if>
					</c:forEach>
                </tbody>
            </table>

			<!-- Modal 추가 -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						
						<div class="modal-header">
			                <!-- 닫기 버튼 수정 -->
			                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
			                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<!-- /.modal-header -->
						<div class="modal-body">처리가 완료되었습니다.</div>
						<!-- /.modal-body -->
						<div class="modal-footer">
			                <!-- 버튼 속성 수정 -->
			                <button type="button" class="btn btn-default" data-bs-dismiss="modal">Close</button>
<!-- 			                <button type="button" class="btn btn-primary">Save changes</button>-->						
						</div>
						<!-- /.modal-footer -->
					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal-dialog -->
			</div>
			<!-- /.modal -->

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
$(document).ready(function(){ //dom 구조가 만들어져 준비되어진 상태 -> ready -> call back function
	 

	
	// 모달을 위한 result 값
	 let result = '<c:out value="${result}"/>';
	 console.info("리저트 결과값!!!!!: "+result);
	
	// 모달
	 checkModal(result);
	 
	 history.replaceState({},null,null);
	 
	 // 모달
	 function checkModal(result){
		 if(result == '' || history.state){
			 return;
		 }
		 if(parseInt(result)>0){
			 $(".modal-body").html("게시글 "+parseInt(result)+" 번이 등록되었습니다.");
		 }// remove 일경우 성공시 "success"가 반환된다!
		 $("#myModal").modal("show"); // aria-hidden = false 
	 }
	 
	 
    // 버튼 클릭 이벤트 처리    
    $(document).on("click", ".move", function (e) {
        e.preventDefault(); // 기본 동작(페이지 이동) 막기

        let hasEntry = $(this).data("has-entry");
        let regdate = $(this).data("regdate"); // 해당 카드의 diary.regdate 정보 가져오기
        let dno = $(this).data("dno"); // 클릭된 요소의 data-dno 값 가져오기
        let username = $(this).data("username"); // 클릭된 요소의 data-dno 값 가져오기
        let actionForm = $("#actionForm"); // 미리 정의된 form 태그
        alert("Has Entry: " + hasEntry);
        alert("Register date: " + regdate);
        alert("dno: " + dno);
        alert("username: " + username);

        console.log("Form action: ", actionForm.attr("action"));
        console.log("Form method: ", actionForm.attr("method"));

        if(hasEntry){
            // 일기가 있는 경우
            // 기존에 존재하는 input[name='dno'] 제거 (중복 방지)
            actionForm.find("input[name='dno']").remove();

            // 새로운 input 태그 생성 및 추가
            actionForm.append("<input type='hidden' name='dno' value='" + dno + "'>");

            // form의 action 설정
            actionForm.attr("action", "/api/diary/get"); // 서버의 디테일 페이지로 변경

            // form 제출
            actionForm.submit();
        }
        else{
        	// 일기가 없는 경우, 등록 페이지 이동 (POST 요청)
            actionForm.find("input[name='regdate']").remove(); // 중복 방지를 위해 기존 regdate 제거
            actionForm.find("input[name='username']").remove(); // 중복 방지를 위해 기존 username 제거

            // 새로운 input 태그 생성 및 추가
            actionForm.append("<input type='hidden' name='regdate' value='" + regdate + "'>");
            actionForm.append("<input type='hidden' name='username' value='" + username + "'>");

            // form의 action 설정
            actionForm.attr("action", "/api/diary/register");

            // form 제출
            actionForm.submit();
        }

    });

    // DatePicker 재초기화
	function reinitializeDatePicker() {
	    $('.datepicker').datepicker('destroy');
	    $('.datepicker').datepicker({
	        format: "yyyy/mm",
	        minViewMode: 1,
	        language: "ko",
	        autoclose: true
	    });
	}
	
    $(document).ready(function () {
        $('#date-picker').datepicker({
            format: "yyyy/mm",
            minViewMode: 1,
            language: "ko",
            autoclose: true
        }).on('changeDate', function () {
            const selectedDate = $('#date-picker').val(); // 선택된 날짜 (예: 2024-11)
            let username = $(this).data("username"); // 클릭된 요소의 data-dno 값 가져오기

            // AJAX 요청 보내기
            $.ajax({
                url: '/api/diary/list', // 서버에서 데이터를 가져올 URL
                type: 'GET',
                data: { selectedDate: selectedDate,username: username },
                success: function (response) {
                	$('#calendar-container').empty(); // 기존 내용을 제거
                	// 서버에서 받은 데이터로 달력 업데이트
                    $('#calendar-container').html(response);
                	
                    // DatePicker 재초기화 추가
                    reinitializeDatePicker();

                    console.log($('#calendar-container').html());
                },
                error: function (error) {
                    console.error('데이터를 가져오는 중 오류 발생:', error);
                }
            });
        });
    });
});

</script>
</body>
</html>
