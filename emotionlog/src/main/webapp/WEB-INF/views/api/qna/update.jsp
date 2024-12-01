<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                <h1 class="mb-4">QnA 수정</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header bg-secondary text-white">
                        <h2 class="card-title mb-0">QnA 수정 폼</h2>
                    </div>
                    <div class="card-body">
                        <form id="updateForm" action="/api/qna/update" method="post">
                            <input type="hidden" name="qno" value="${qBoard.qno}">

                            <div class="form-group">
                                <label for="qtitle">제목</label>
                                <input type="text" id="qtitle" name="qtitle" class="form-control" value="<c:out value='${qBoard.qtitle}' />" placeholder="제목을 입력하세요" required>
                            </div>

                            <div class="form-group">
                                <label for="qcontent">내용</label>
                                <textarea id="qcontent" name="qcontent" class="form-control" rows="5" placeholder="내용을 입력하세요" required><c:out value="${qBoard.qcontent}" /></textarea>
                            </div>

                            <div class="form-group">
                                <button type="submit" class="btn btn-primary mr-2">
                                    <i class="fas fa-save"></i> 수정
                                </button>
                                <a href="/api/qna/list" class="btn btn-secondary">
                                    <i class="fas fa-list"></i> 목록으로 돌아가기
                                </a>
                            </div>
                        </form>
                    </div>
                    <!-- /.card-body -->

                    <!-- Delete 기능 추가 -->
                    <div class="card-footer bg-light">
                        <form id="deleteForm" action="/api/qna/delete" method="post" onsubmit="return confirm('QnA 등록글을 삭제하시겠습니까?');">
                            <input type="hidden" name="qno" value="${qBoard.qno}">
                            <button type="submit" class="btn btn-danger">
                                <i class="fas fa-trash-alt"></i> 삭제
                            </button>
                        </form>
                    </div>
                    <!-- /.card-footer -->
                </div>
                <!-- /.card -->
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" 
            integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5/1hb9T5ngv8K1NVZqdPSdQ6xB/hqgRr3dHhZg1l" 
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" 
            integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2LcW0fsvLjU9sGtrF0Uk49v0PqLHlXja2qeIrSct5i" 
            crossorigin="anonymous"></script>
</body>
</html>
