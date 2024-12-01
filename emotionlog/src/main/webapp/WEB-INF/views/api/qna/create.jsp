<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="com.emotionlog.domain.QboardVO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ include file="../includes/header.jsp" %>
    <%@ include file="../includes/navbar.jsp" %>

<body>
    
    <div class="container">
        <h1>QnA 등록</h1>
        <form id="qnaForm" action="/qna/create" method="post">
            <div class="form-group">
                <label for="qtitle">제목:</label>
                <input type="text" id="qtitle" name="qtitle" class="form-control" placeholder="제목을 입력하세요" required>
            </div>
            <div class="form-group">
                <label for="qcontent">내용:</label>
                <textarea id="qcontent" name="qcontent" class="form-control" rows="5" placeholder="내용을 입력하세요" required></textarea>
            </div>
            <div class="form-group">
                <button type="button" id="submitBtn" class="btn btn-primary">등록</button>
                <a href="/qna/list" class="btn btn-secondary">목록으로 돌아가기</a>
            </div>
        </form>
    </div>

    <script>
        document.getElementById("submitBtn").addEventListener("click", function() {
            const form = document.getElementById("qnaForm");
            
            // 폼 데이터 제출
            form.submit();
            
            // 폼 제출 후 /qna/list로 리다이렉트
            form.addEventListener("submit", function(event) {
                setTimeout(function() {
                    window.location.href = "/qna/list";
                }, 500); // 폼 데이터가 서버로 전송되는 시간을 고려한 약간의 딜레이
            });
        });
    </script>
</body>
</html>
