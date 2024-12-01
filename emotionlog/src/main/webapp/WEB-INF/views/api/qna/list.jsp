<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.emotionlog.domain.QboardVO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/navbar.jsp" %>

<body>
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <h1>QnA 목록</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        QnA 리스트
                        <!-- 수정된 버튼: <a> 태그 사용 및 Bootstrap 클래스 개선 -->
                        <a href="/api/qna/create" class="btn btn-primary btn-sm pull-right">
                            <i class="fa fa-plus"></i> 새 QnA 등록
                        </a>
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <table width="100%" class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>번호</th>
                                    <th>제목</th>
                                    <th>작성자</th>
                                    <th>작성일</th>
                                    <th>수정일</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${qnaList}" var="qna">
                                    <tr>
                                        <td><c:out value="${qna.qno}" /></td>
                                        <td>
                                            <a href="/api/qna/detail?qno=${qna.qno}" style="text-decoration: none;">
                                                <c:out value="${qna.qtitle}" />
                                            </a>
                                        </td>
                                        <td><c:out value="${qna.username}" /></td>
                                        <td>
                                            <fmt:formatDate pattern="yyyy-MM-dd" value="${qna.qdate}" />
                                        </td>
                                        <td>
                                            <fmt:formatDate pattern="yyyy-MM-dd" value="${qna.qupdate_date}" />
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
    </div>
    <!-- /.container -->

    <!-- Font Awesome 추가 (아이콘 사용을 위해) -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
</body>
</html>
