<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.emotionlog.domain.QboardVO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/navbar.jsp" %>

<body>
    <div class="container mt-4">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="mb-4">QnA 상세보기</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h2 class="card-title mb-0"><c:out value="${qBoard.qtitle}" /></h2>
                    </div>
                    <div class="card-body">
                        <p class="card-text"><c:out value="${qBoard.qcontent}" /></p>
                        <hr>
                        <div class="row">
                            <div class="col-md-6">
                                <p><strong>작성자:</strong> <c:out value="${qBoard.username}" /></p>
                            </div>
                            <div class="col-md-6 text-md-right">
                                <p><strong>작성일:</strong> <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${qBoard.qdate}" /></p>
                                <p><strong>수정일:</strong> <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${qBoard.qupdate_date}" /></p>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer text-right">
                        <a href="/api/qna/update?qno=<c:out value='${qBoard.qno}' />" class="btn btn-primary mr-2">
                            <i class="fas fa-edit"></i> 수정
                        </a>
                        <a href="/api/qna/list" class="btn btn-secondary">
                            <i class="fas fa-list"></i> 목록으로 돌아가기
                        </a>
                    </div>
                </div>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
    </div>
    <!-- /.container -->

    <!-- Font Awesome 추가 (아이콘 사용을 위해) -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <!-- Optional JavaScript -->
    <!-- Bootstrap JS, Popper.js, and jQuery (필요 시 포함) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5/1hb9T5ngv8K1NVZqdPSdQ6xB/hqgRr3dHhZg1l" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2LcW0fsvLjU9sGtrF0Uk49v0PqLHlXja2qeIrSct5i" crossorigin="anonymous"></script>
</body>
</html>
