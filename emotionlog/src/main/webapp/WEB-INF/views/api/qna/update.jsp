<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.emotionlog.domain.QboardVO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">QnA 수정</h1>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
		<form action="/qna/update" method="post" class="form-horizontal">
		    <input type="hidden" name="qno" value="${qBoard.qno}">
		    <div class="form-group">
		        <label for="qtitle" class="col-sm-2 control-label">Title</label>
		        <div class="col-sm-10">
		            <input type="text" id="qtitle" name="qtitle" class="form-control" value="${qBoard.qtitle}" required>
		        </div>
		    </div>
		    <div class="form-group">
		        <label for="qcontent" class="col-sm-2 control-label">Content</label>
		        <div class="col-sm-10">
		            <textarea id="qcontent" name="qcontent" rows="5" class="form-control" required>${qBoard.qcontent}</textarea>
		        </div>
		    </div>
		    <div class="form-group">
		        <div class="col-sm-offset-2 col-sm-10">
		            <button type="submit" class="btn btn-primary">Update</button>
		            <a href="/qna/list" class="btn btn-default">Go To List</a>
		        </div>
		    </div>
		</form>


        <!-- Delete 기능 추가 -->
        <form action="/qna/delete" method="post" style="margin-top: 20px;">
            <input type="hidden" name="qno" value="${qBoard.qno}">
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-danger" onclick="return confirm('QnA 등록글을 삭제하시겠습니까?');">Delete</button>
                </div>
            </div>
        </form>
    </div>
</div>
