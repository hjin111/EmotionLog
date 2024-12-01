<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.emotionlog.domain.QboardVO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes/header.jsp" %>

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">QnA List</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                QnA List Page
                <button id="regBtn" type="button" class="btn btn-xs pull-right">Register New QnA</button>
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
                <table width="100%" class="table table-striped table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>#번호</th>
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
                                    <a href="/qna/detail/?qno=${qna.qno}">
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

<script>
    $(document).ready(function () {
        $("#regBtn").on("click", function () {
            location.href = "/qna/create";
        });
    });
</script>
