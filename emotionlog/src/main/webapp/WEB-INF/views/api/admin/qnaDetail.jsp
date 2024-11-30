<!-- 작성자 : 심세연 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css"
	integrity="sha512-5Hs3dF2AEPkpNAR7UiOHba+lRSJNeM2ECkwxUIxC1Q/FLycGTbNapWXB4tP889k5T5Ju8fs4b1P5z/iB4nMfSQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />

<!-- <style type="text/css">
@font-face {
	font-family: 'Pretendard-Regular';
	src:
		url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff')
		format('woff');
	font-weight: 400;
	font-style: normal;
}

body {
	font-family: 'Pretendard-Regular';
}
</style> -->

</head>
<body>
	<%@include file="../includes/navbar.jsp"%>
	<main style="margin: 5vh 10vw">
		<section class="card" style="margin-bottom: 3vh">
			<div class="card-body" style="padding: 3vw">
				<div style="display: flex; justify-content: space-between;">
					<h2 class="card-title" style="margin-bottom: 2vh">${qDetail.qtitle}</h2>
					<a href="/api/admin/qna" style="text-decoration: none; color: inherit;">
						<i class="fa-solid fa-list-ul"></i>
					</a>
				</div>
				<p class="card-subtitle">${qDetail.username}</p>
				
				<p>
					<i class="fa-regular fa-calendar"></i>
					<fmt:formatDate value="${qDetail.qdate}" pattern="yyyy-MM-dd" />
				</p>
				<hr>
				<p class="card-text" style="margin: 1vh 0">${qDetail.qcontent }</p>
				
			</div>
		</section>

		<section class="card">
			<div class="card-body" style="padding: 3vw">
				<form id="answerForm">
					<input id="answerTitle" class="form-control"
						value="RE: <c:out value="${qDetail.qtitle }"/>"
						readonly="readonly" disabled type="hidden"
						style="margin-bottom: 1vh">
					<textarea id="answerContent" rows="" cols="" class="form-control"
						placeholder="답변을 작성해주세요."></textarea>
					<button type="submit" class="btn btn-light">등록</button>
				</form>
				<hr style="margin-bottom: 5vh">

				<article id="answersContainer">
					<!-- 댓글 불러오기 -->
				</article>
			</div>
		</section>
	</main>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script type="text/javascript">
    $(document).ready(function () {
    	const qno = ${qDetail.qno}; 

        function loadAnswers() {
            $.ajax({
                type: "GET",
                dataType: "json",
                url: "/api/admin/qna/answer/" + qno,  // 해당 질문 번호로 GET 요청을 보냅니다.
                success: function (response) {
                	
                	/* console.log("?",response); */
                	
                    if (response.length > 0) {
                        // 응답이 있으면 댓글을 화면에 렌더링
                        let answersHtml = '';
                        response.forEach(function (answer) {
                        	let formattedDate = new Date(answer.adate).toLocaleDateString('en-CA', {
								year : '2-digit',
								month : '2-digit',
								day : '2-digit'
							});
                        	/* console.log(formattedDate); */
                            answersHtml += `
                            	<div class="card" style="background-color: whitesmoke; padding: 3vw; border: 0">
                            	<div style="display: flex; justify-content: space-between; margin-bottom: 2vh">
                            		<h3 class="card-title" style="margin: 0" >\${answer.atitle}</h3>
	                             	<button id="deleteAnswer" data-ano="\${answer.ano}" style="border: 0; background-color: transparent; padding: 0;">
	                             		<i class="fa-solid fa-trash-can" style="color: grey"></i>
	                             	</button>
                            
                            	</div>
	                                    <p class="card-subtitle">\${answer.username}</p>
	                                    <p>
	                                    	<i class="fa-regular fa-calendar"></i>
	                                    \${formattedDate}
	                                    </p>
	                                    <p class="card-text" >\${answer.acontent}</p>
	                             </div>
                            `;
                        });
                        
                        
                        $('#answersContainer').append(answersHtml);  // 댓글을 삽입할 영역에 추가
                    } else {
                    	let noAnswer = '';
                    	noAnswer += `
                    		
                            <p style="text-align: center;">아직 작성된 답변이 없습니다.</p>
                        
                    	`;
                        $('#answersContainer').append(noAnswer);  // 댓글이 없을 경우
                    }
                },
                error: function (xhr, status, error) {
                    console.error("댓글을 불러오는 데 실패했습니다:", error);
                    alert("댓글을 불러오는 데 실패했습니다. 다시 시도해주세요.");
                }
            });
        }

        // 페이지 로드 시 댓글을 불러오기
        loadAnswers();
    	
    	
    	
        $("#answerForm").on("submit", function (e) {
            event.preventDefault(); // 기본 form 제출 방지
            
            const responseData = {
            		atitle: $("#answerTitle").val(),
            		acontent: $("#answerContent").val(),
            		username: "${username}",
            		qno: ${qDetail.qno}
            };
			
            $.ajax({
                type: "POST",
                url: "/api/admin/qna/answer", 
                data: JSON.stringify(responseData),
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    /* alert("답변이 성공적으로 등록되었습니다!"); */
                    location.reload(); // 페이지를 새로고침하여 업데이트된 댓글 반영
                },
                error: function (xhr, status, error) {
                    console.error("응답 실패:", error);
                    alert("답변 등록에 실패했습니다. 다시 시도해주세요.");
                }
            });
           
        });
        
        // 동적으로 생성된 요소에 이벤트 부여
        $(document).on("click", "#deleteAnswer", function (e) {
        	e.preventDefault();
        	const ano = $(this).data("ano");
        	console.log(ano);
        	
        	$.ajax({
                type: "DELETE",
                url: "/api/admin/qna/answer/" + ano,
                dataType: "text", // 서버에서 plain text("success")를 반환하므로
                success: function (response) {
                    if (response === "success") {
                        alert("답변이 삭제되었습니다.");
                        location.reload(); // 삭제 후 새로고침
                    } else {
                        alert("삭제에 실패했습니다.");
                    }
                },
                error: function (xhr, status, error) {
                    console.error("삭제 오류:", error);
                    alert("삭제 중 오류가 발생했습니다. 다시 시도해주세요.");
                }
            });
        	
        	
        })
        
    });
</script>
</body>
</html>