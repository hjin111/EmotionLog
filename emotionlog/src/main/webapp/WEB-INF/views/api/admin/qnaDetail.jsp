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
				<!-- <h2 class="card-header">QnA 게시판	</h2> -->
				<h2 class="card-title" style="margin-bottom: 2vh">${qDetail.qtitle}</h2>
				<p class="card-subtitle">${qDetail.username}</p>
				<!-- <i class="fa-regular fa-calendar"></i> -->
				<p>
					<i class="fa-regular fa-calendar"></i>
					<fmt:formatDate value="${qDetail.qdate}" pattern="yyyy-MM-dd" />
				</p>
				<hr>
				<p class="card-text" style="margin: 1vh 0">${qDetail.qcontent }</p>
			</div>
		</section>

		<section>
			<form id="answerForm">
				<input id="answerTitle" class="form-control"
					value="RE: <c:out value="${qDetail.qtitle }"/>" readonly="readonly"
					disabled style="margin-bottom: 1vh">
				<textarea id="answerContent" rows="" cols="" class="form-control"></textarea>
				<button type="submit" class="btn btn-light">등록</button>
			</form>
		</section>

		<section>
		<!-- 댓글 불러오기 -->
		</section>
	</main>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script type="text/javascript">
    $(document).ready(function () {
        $("#answerForm").on("submit", function (event) {
            event.preventDefault(); // 기본 form 제출 방지
            
            const responseData = {
            		atitle: $("#answerTitle").val(),
            		acontent: $("#answerContent").val(),
            		username: "2",
            		qno: ${qDetail.qno}
            };

            $.ajax({
                type: "POST",
                url: "/api/admin/qna/answer", 
                data: JSON.stringify(responseData),
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    alert("답변이 성공적으로 등록되었습니다!");
                    location.reload(); // 페이지를 새로고침하여 업데이트된 댓글 반영
                },
                error: function (xhr, status, error) {
                    console.error("응답 실패:", error);
                    alert("답변 등록에 실패했습니다. 다시 시도해주세요.");
                }
            });
        });
    });
</script>
</body>
</html>