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
 			
 			<!-- datepicker 영역 -->
			<div class="datepicker-container">
				<br/>
	            <input type="text" id="date-picker" class="datepicker-input" value="${pick_date}">
	        </div>
			   <%-- <h1 class="text-left">Emotion_log : ${year}-${month}</h1> --%>
		    <!-- 헤더 영역 -->
		    <div class="header-container" boder = none>
		        <h1 class="header-title">Emotion_log</h1>
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
														            ${diary.title}
														            <br/>
																	  <c:choose>
																	    <c:when test="${diary.emotion_status == 'joy'}">
																			<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-emoji-smile" viewBox="0 0 16 16">
																			  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
																			  <path d="M4.285 9.567a.5.5 0 0 1 .683.183A3.5 3.5 0 0 0 8 11.5a3.5 3.5 0 0 0 3.032-1.75.5.5 0 1 1 .866.5A4.5 4.5 0 0 1 8 12.5a4.5 4.5 0 0 1-3.898-2.25.5.5 0 0 1 .183-.683M7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5m4 0c0 .828-.448 1.5-1 1.5s-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5"/>
																			</svg>
																	      기쁨
																	    </c:when>
																	    <c:when test="${diary.emotion_status == 'anger'}">
																			<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-emoji-angry" viewBox="0 0 16 16">
																			  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
																			  <path d="M4.285 12.433a.5.5 0 0 0 .683-.183A3.5 3.5 0 0 1 8 10.5c1.295 0 2.426.703 3.032 1.75a.5.5 0 0 0 .866-.5A4.5 4.5 0 0 0 8 9.5a4.5 4.5 0 0 0-3.898 2.25.5.5 0 0 0 .183.683m6.991-8.38a.5.5 0 1 1 .448.894l-1.009.504c.176.27.285.64.285 1.049 0 .828-.448 1.5-1 1.5s-1-.672-1-1.5c0-.247.04-.48.11-.686a.502.502 0 0 1 .166-.761zm-6.552 0a.5.5 0 0 0-.448.894l1.009.504A1.94 1.94 0 0 0 5 6.5C5 7.328 5.448 8 6 8s1-.672 1-1.5c0-.247-.04-.48-.11-.686a.502.502 0 0 0-.166-.761z"/>
																			</svg>
																	      분노
																	    </c:when>
																	    <c:when test="${diary.emotion_status == 'sad'}">
																			<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-emoji-tear" viewBox="0 0 16 16">
																			  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
																			  <path d="M6.831 11.43A3.1 3.1 0 0 1 8 11.196c.916 0 1.607.408 2.25.826.212.138.424-.069.282-.277-.564-.83-1.558-2.049-2.532-2.049-.53 0-1.066.361-1.536.824q.126.27.232.535.069.174.135.373ZM6 11.333C6 12.253 5.328 13 4.5 13S3 12.254 3 11.333c0-.706.882-2.29 1.294-2.99a.238.238 0 0 1 .412 0c.412.7 1.294 2.284 1.294 2.99M7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5m4 0c0 .828-.448 1.5-1 1.5s-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5m-1.5-3A.5.5 0 0 1 10 3c1.162 0 2.35.584 2.947 1.776a.5.5 0 1 1-.894.448C11.649 4.416 10.838 4 10 4a.5.5 0 0 1-.5-.5M7 3.5a.5.5 0 0 0-.5-.5c-1.162 0-2.35.584-2.947 1.776a.5.5 0 1 0 .894.448C4.851 4.416 5.662 4 6.5 4a.5.5 0 0 0 .5-.5"/>
																			</svg>
																	      슬픔
																	    </c:when>
																	    <c:when test="${diary.emotion_status == 'fun'}">
																			<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-emoji-laughing" viewBox="0 0 16 16">
																			  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
																			  <path d="M12.331 9.5a1 1 0 0 1 0 1A5 5 0 0 1 8 13a5 5 0 0 1-4.33-2.5A1 1 0 0 1 4.535 9h6.93a1 1 0 0 1 .866.5M7 6.5c0 .828-.448 0-1 0s-1 .828-1 0S5.448 5 6 5s1 .672 1 1.5m4 0c0 .828-.448 0-1 0s-1 .828-1 0S9.448 5 10 5s1 .672 1 1.5"/>
																			</svg>
																	      즐거움
																	    </c:when>
																	    <c:when test="${diary.emotion_status == 'love'}">
																			<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-emoji-kiss" viewBox="0 0 16 16">
																			  <path fill-rule="evenodd" d="M12.493 13.368a7 7 0 1 1 2.489-4.858c.344.033.68.147.975.328a8 8 0 1 0-2.654 5.152 9 9 0 0 1-.81-.622m-3.731-3.22a13 13 0 0 0-1.107.318.5.5 0 1 1-.31-.95c.38-.125.802-.254 1.192-.343.37-.086.78-.153 1.103-.108.16.022.394.085.561.286.188.226.187.497.131.705a1.9 1.9 0 0 1-.31.593q-.115.16-.275.343.16.186.276.347c.142.197.256.397.31.595.055.208.056.479-.132.706-.168.2-.404.262-.563.284-.323.043-.733-.027-1.102-.113a15 15 0 0 1-1.191-.345.5.5 0 1 1 .31-.95c.371.12.761.24 1.109.321q.264.062.446.084a6 6 0 0 0-.502-.584.5.5 0 0 1 .002-.695 5.5 5.5 0 0 0 .5-.577 5 5 0 0 0-.448.082Zm.766-.087-.003-.001-.003-.001zm.002 1.867-.006.001zM6 8c.552 0 1-.672 1-1.5S6.552 5 6 5s-1 .672-1 1.5S5.448 8 6 8m2.757-.563a.5.5 0 0 0 .68-.194.93.93 0 0 1 .813-.493c.339 0 .645.19.813.493a.5.5 0 0 0 .874-.486A1.93 1.93 0 0 0 10.25 5.75c-.73 0-1.356.412-1.687 1.007a.5.5 0 0 0 .194.68M14 9.828c1.11-1.14 3.884.856 0 3.422-3.884-2.566-1.11-4.562 0-3.421Z"/>
																			</svg>
																	      사랑
																	    </c:when>
																	    <c:when test="${diary.emotion_status == 'hate'}">
																			<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-emoji-grimace" viewBox="0 0 16 16">
																			  <path d="M7 6.25c0 .69-.448 1.25-1 1.25s-1-.56-1-1.25S5.448 5 6 5s1 .56 1 1.25m3 1.25c.552 0 1-.56 1-1.25S10.552 5 10 5s-1 .56-1 1.25.448 1.25 1 1.25m2.98 3.25A1.5 1.5 0 0 1 11.5 12h-7a1.5 1.5 0 0 1-1.48-1.747v-.003A1.5 1.5 0 0 1 4.5 9h7a1.5 1.5 0 0 1 1.48 1.747zm-8.48.75h.25v-.75H3.531a1 1 0 0 0 .969.75m7 0a1 1 0 0 0 .969-.75H11.25v.75zm.969-1.25a1 1 0 0 0-.969-.75h-.25v.75zM4.5 9.5a1 1 0 0 0-.969.75H4.75V9.5zm1.75 2v-.75h-1v.75zm.5 0h1v-.75h-1zm1.5 0h1v-.75h-1zm1.5 0h1v-.75h-1zm1-2h-1v.75h1zm-1.5 0h-1v.75h1zm-1.5 0h-1v.75h1zm-1.5 0h-1v.75h1z"/>
																			  <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16m0-1A7 7 0 1 1 8 1a7 7 0 0 1 0 14"/>
																			</svg>
																	      증오
																	    </c:when>
																	    <c:otherwise>
																	      <span>감정 상태 없음</span>
																	    </c:otherwise>
																	  </c:choose>
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
			                <h4 class="modal-title" id="myModalLabel">알림</h4>
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
			 $(".modal-body").html("일기("+parseInt(result)+")이 등록되었습니다.");
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
