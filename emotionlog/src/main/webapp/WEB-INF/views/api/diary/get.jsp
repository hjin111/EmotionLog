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
    
    .chat li {
        border-bottom: 2px dotted grey; /* 빨간 줄 추가 */
        padding-bottom: 10px; /* 줄과 텍스트 간격 추가 */
        margin-bottom: 10px; /* 줄 아래 간격 추가 */
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
				<div class="card">
				    <div class="card-header">
				        <i class="fa fa-comments fa-fw"></i> Reply
  						<button id="addReplyBtn" class="btn btn-primary btn-sm float-end">New Reply</button>
				    </div>
				
				    <div class="card-body">
				        <ul class="chat list-unstyled">
				            <!-- 댓글이 여기에 동적으로 추가됩니다 -->
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

<!-- 모달 시작 -->
<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="myModalLabel">REPLY MODAL</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body">
        <div class="form-group mb-3">
          <label for="reply">Reply</label>
          <input class="form-control" id="reply" name="reply" value="NEW REPLY!!!!">
        </div>

        <div class="form-group mb-3">
          <label for="replyer">Replyer</label>
          <input class="form-control" id="replyer" name="replyer" value="replyer">
        </div>

        <div class="form-group mb-3">
          <label for="replyDate">Reply Date</label>
          <input class="form-control" id="replyDate" name="reply_date" value="reply_date">
        </div>
      </div>

      <div class="modal-footer">
        <button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
        <button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
        <button id="modalRegisterBtn" type="button" class="btn btn-info">Register</button>
        <button id="modalCloseBtn" type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<!-- 모달 끝 -->
<script type ="text/javascript" src="/resources/js/reply.js"></script>
<script>
$(document).ready(function(){//dom 구조가 만들어져 준비되어진 상태 -> ready -> call back function


	 let dnoValue = '<c:out value ="${diary.dno}"/>';
	 let replyUL = $(".chat");

	 // 댓글 리스트 보여주기
	 showList(1);
	 function showList(page) {
	        replyService.getList({ dno: dnoValue, page: page || 1 }, function(list) {

	            let str = "";
	            if (list == null || list.length == 0) {
	                replyUL.html(""); // 댓글이 없는 경우 비움
	                return;
	            }

	            for (let i = 0, len = list.length; i < len; i++) {
	                console.log(i)
	                
	                // replyDate 값을 사람이 읽을 수 있는 형식으로 변환
	                let replyDate = list[i].reply_date ? new Date(list[i].reply_date).toLocaleString() : "N/A";
	
	                console.log("날짜: ", replyDate); // 각 댓글 데이터 확인
	             	// 문자열 연결 연산자 사용
	                str += '<li class="clearfix mb-2" data-rno="' + list[i].rno + '">' +
			                    '<div>' +
			                        '<div class="d-flex justify-content-between align-items-center">' +
			                            '<strong class="fw-bold">' + list[i].replyer + '</strong>' +
			                            '<small class="text-muted">' + replyDate + '</small>' +
			                        '</div>' +
			                        '<p>' + list[i].reply + '</p>' +
			                    '</div>' +
	              		  '</li>';
	            }
	            replyUL.html(str); // 댓글을 <ul>에 추가
	        });
	 } // end showList
	 
	 // 모달 : 새로운 댓글의 추가버튼 이벤트 처리
	 let modal = $(".modal");
	 let modalInputReply = modal.find("input[name='reply']");
	 let modalInputReplyer = modal.find("input[name='replyer']");
	 let modalInputReplyDate = modal.find("input[name='reply_date']");
	 
	 let modalModBtn = $("#modalModBtn");
	 let modalRemoveBtn = $("#modalRemoveBtn");
	 let modalRegisterBtn = $("#modalRegisterBtn");
	 
	 // 사용자가 'New Reply' 버튼을 클릭하면 입력에 필요없는 항목들은 안보이게 처리하고, 모달창을 보이게 합니다.
	 $("#addReplyBtn").on("click",function(e){
		 modal.find("input").val("");
		 modalInputReplyDate.closest("div").hide();
		 modal.find("button[id!='modalCloseBtn']").hide();
		 
		 modalRegisterBtn.show();
		 
		 $(".modal").modal("show");
	 });
	 
	 // 댓글 등록 및 목록 갱신
	 modalRegisterBtn.on("click",function(e){
		let reply = {
				reply   : modalInputReply.val(),
				replyer : modalInputReplyer.val(),
				dno     : dnoValue
		};
		replyService.add(reply, function(result){
			alert(result);
			modal.find("input").val("");
			modal.modal("hide");
			
			showList(1);
		});
	 });
	 // 특정 댓글의 클릭 이벤트 처리, 댓글 조회 클릭 이벤트 처리
	 $(".chat").on("click","li",function(e){
		 let rno = $(this).data("rno");
		 replyService.get(rno,function(reply){
			 modalInputReply.val(reply.reply);
			 modalInputReplyer.val(reply.replyer);
			 modalInputReplyDate.val(new Date(reply.reply_date).toLocaleString()).attr("readonly","readonly");
			 modal.data("rno",reply.rno);
			 
			 modal.find("button[id!='modalCloseBtn']").hide();
			 modalModBtn.show();
			 modalRemoveBtn.show();
			 
			 $(".modal").modal("show");
		 })
	 });
	 
	 // 댓글의 수정 이벤트 처리
	 modalModBtn.on("click",function(e){
		 let reply ={rno:modal.data("rno"), reply: modalInputReply.val()};
		 replyService.update(reply,function(result){
			 alert(result);
			 modal.modal("hide");
			 showList(1);
		 });
	 });
	 
	 // 댓글의 삭제 이벤트 처리
	 modalRemoveBtn.on("click",function(e){
		 let rno = modal.data("rno");
	 	 replyService.remove(rno,function(result){
	 		 alert(result);
	 		 modal.modal("hide");
	 		 showList(1);
	 	 });
	 });
	
	 
	  // 폼태그 처리	 
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
