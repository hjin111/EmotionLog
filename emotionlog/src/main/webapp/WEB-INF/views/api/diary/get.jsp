<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.emotionlog.domain.DiaryVO"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.TimeZone"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@include file="../includes/header.jsp" %>

<body>
	<%@include file="../includes/navbar.jsp" %>
	
	<div class="container my-4">
		<div class="row justify-content-center">
			<div class="gmr-container">

				<!-- 다양한 상황을 처리하기 위해서 form 태그 이용~~ -->
				<form id='operForm' action="/api/diary/modify" method="get">
					<input type='hidden' id='dno' name='dno' value='<c:out value="${diary.dno}"/>'>
					<input type='hidden' id='regdate' name='regdate' value='<fmt:formatDate value="${diary.regdate}" pattern="yyyy/MM/dd" />'>
				</form>

				<div class="panel panel-default">
					<div class="panel-heading">Diary Read Page</div>
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
						<div class ="form-group dropdown">
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
						<div class ="form-group">
							<button data-oper='modify' class="btn btn-warning">Modify</button>
							<button data-oper='list' class="btn btn-secondary">List</button> 
						</div>

					</div>
					<!-- end panel-body -->
				</div>
				<!-- end panel-body -->

				<br/>
				<!-- 댓글 -->
				<div class="card">
				    <div class="card-header">
						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-chat-dots-fill" viewBox="0 0 16 16">
						  <path d="M16 8c0 3.866-3.582 7-8 7a9 9 0 0 1-2.347-.306c-.584.296-1.925.864-4.181 1.234-.2.032-.352-.176-.273-.362.354-.836.674-1.95.77-2.966C.744 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7M5 8a1 1 0 1 0-2 0 1 1 0 0 0 2 0m4 0a1 1 0 1 0-2 0 1 1 0 0 0 2 0m3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2"/>
						</svg>  						
						<button id="addReplyBtn" class="btn btn-success btn-sm float-end">New Reply</button>
				    </div>
				
				    <div class="card-body">
				        <ul class="chat list-unstyled">
				            <!-- 댓글이 여기에 동적으로 추가됩니다 -->
				        </ul>
				    </div>
				    
				    <div class ="card-footer">
				    	<!-- 댓글 페이지 번호 출력 -->
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
        <h5 class="modal-title" id="myModalLabel">REPLY</h5>
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

<!-- Modal 추가 -->
<div class="modal fade" id="processModal" tabindex="-1" role="dialog" aria-labelledby="processModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			
			<div class="modal-header">
                <!-- 닫기 버튼 수정 -->
                <h4 class="modal-title" id="processModalLabel">알림</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<!-- /.modal-header -->
			<div class="modal-body">처리가 완료되었습니다.</div>
			<!-- /.modal-body -->
			<div class="modal-footer">
                <!-- 버튼 속성 수정 -->
                <button type="button" class="btn btn-default" data-bs-dismiss="modal">Close</button>
			</div>
			<!-- /.modal-footer -->
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<script type ="text/javascript" src="/resources/js/reply.js"></script>
<script>
$(document).ready(function(){//dom 구조가 만들어져 준비되어진 상태 -> ready -> call back function


	 let dnoValue = '<c:out value ="${diary.dno}"/>';
	 let replyUL = $(".chat");

	 // 댓글 리스트 보여주기
	 showList(1);
	 // >>> showList 함수 시작 >>>
	 function showList(page) {

	 	// >>> replyService.getList 시작 >>>
	 	replyService.getList(
	 		{ dno: dnoValue, page: page || 1 },
	 		function(replyCnt,list) {
	 			console.log(replyCnt);
	 			console.log(list);

				if(page == -1){
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
			
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
	               str += `<li class="clearfix mb-2" data-rno="\${list[i].rno}">
		                    <div>
		                        <div class="d-flex justify-content-between align-items-center">
		                            <strong class="fw-bold">\${list[i].replyer}</strong>
		                            <small class="text-muted">\${replyDate}</small>
		                        </div>
		                        <p>\${list[i].reply}</p>
		                    </div>
	             		  </li>`;
	            }
	            replyUL.html(str); // 댓글을 <ul>에 추가
	            showReplyPage(replyCnt); // 페이지 번호 출력
       		}
	 	);
       	// <<< replyService.getList 끝 <<<
       	
	 } 
	 // <<< showList 함수 끝 <<<
	 
	 // 댓글 페이지 번호 출력
	 let pageNum = 1;
	 let replyPageFooter = $(".card-footer");
	 // >>> showReplyPage 함수 시작 >>>
	 function showReplyPage(replyCnt){
		let endNum = Math.ceil(pageNum/10.0) * 10;
		let startNum = endNum - 9;
		
		let prev = startNum != 1;
		let next = false;
		
		console.log(endNum);
		console.log(startNum);
		console.log(prev);
		console.log(next);

		
		if(endNum * 10 >= replyCnt){
			endNum = Math.ceil(replyCnt/10.0);
		}
		if(endNum * 10 < replyCnt){
			next =true;
		}
		
		let str = "<ul class='pagination pull-right'>";
		
		if(prev){
	        str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
	      }
	      
	      for(var i = startNum ; i <= endNum; i++){
	        
	        var active = pageNum == i? "active":"";
	        
	        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
	      }
	      
	      if(next){
	        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
	      }
	      
	    
		str += "</ul></div>";
		

		console.log(str);
		replyPageFooter.html(str);
	 }
	 
	 // <<< showReplyPage 함수 끝 <<<
	 replyPageFooter.on("click","li a", function(e){
       e.preventDefault();
       console.log("page click");
       
       var targetPageNum = $(this).attr("href");
       
       console.log("targetPageNum: " + targetPageNum);
       
       pageNum = targetPageNum;
       
       showList(pageNum);
     });     
	 
	 
	 // 모달 : 새로운 댓글의 추가버튼 이벤트 처리
//	 let modal = $(".modal");
	 let modal = $("#myModal");  // 특정 모달 선택

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
		 
		 $("#myModal").modal("show");
	 });
	 
	
	 
	 // 댓글 등록 및 목록 갱신
	 modalRegisterBtn.on("click",function(e){
		let reply = {
				reply   : modalInputReply.val(),
				replyer : modalInputReplyer.val(),
				dno     : dnoValue
		};
		replyService.add(reply, function(result){
		    showProcessModal(); // 버튼 클릭 시 processModal 띄우기
			modal.find("input").val("");
			modal.modal("hide");
			
			showList(-1);
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
			 
			 $("#myModal").modal("show");
		 })
	 });
	 
	 // 댓글의 수정 이벤트 처리
	 modalModBtn.on("click",function(e){
		 let reply ={rno:modal.data("rno"), reply: modalInputReply.val(), replyer : modalInputReplyer.val()};
		 replyService.update(reply,function(result){
			 showProcessModal(); // 버튼 클릭 시 processModal 띄우기
			 modal.modal("hide");
			 showList(pageNum);
		 });
	 });
	 
	 // 댓글의 삭제 이벤트 처리
	 modalRemoveBtn.on("click",function(e){
		 let rno = modal.data("rno");
	 	 replyService.remove(rno,function(result){
			 showProcessModal(); // 버튼 클릭 시 processModal 띄우기
	 		 modal.modal("hide");
	 		 showList(pageNum);
	 	 });
	 });
	
	// 원하는 조건을 관리하는 변수
	 let shouldShowProcessModal = false;

	 // 첫 번째 모달(myModal)이 닫힐 때 이벤트 설정
	 $('#myModal').on('hidden.bs.modal', function () {
	     if (shouldShowProcessModal) { // 조건이 참일 때만 실행
	         $('#processModal').modal('show');
	         shouldShowProcessModal = false; // 다시 false로 초기화
	     }
	 });

	 // 조건을 만족시켜 모달을 띄우는 함수
	 function showProcessModal() {
	     shouldShowProcessModal = true; // 조건을 true로 설정
	     $('#myModal').modal('hide');   // myModal 닫기 -> 닫힘 이벤트 발생
	 }

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
