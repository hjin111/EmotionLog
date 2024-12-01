<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes/header.jsp" %>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">QnA Detail</h1>
	</div>
	<!--  /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">QnA Detail Page</div>
			<!--  /.panel-heading -->
			<div class="panel-body">
			
				<div class="form-group">
					<label>Qno</label> 
					<input class="form-control" name="qno" value="<c:out value='${qBoard.qno}' />" readonly="readonly">
				</div>
				
				<div class="form-group">
					<label>Title</label> 
					<input class="form-control" name="title" value="<c:out value='${qBoard.qtitle}' />" readonly="readonly">
				</div>
				
				<div class="form-group">
					<label>Content</label> 
					<textarea class="form-control" rows="3" name="content" readonly="readonly">
						<c:out value="${qBoard.qcontent}" />
					</textarea> 
				</div>
				
				<div class="form-group">
					<label>작성자</label> 
					<input class="form-control" name="writer" value="<c:out value='${qBoard.username}' />" readonly="readonly">
				</div>
				
				<button class="btn btn-default" 
				        onclick="location.href='/qna/update?qno=<c:out value="${qBoard.qno}" />'">
					Update
				</button>
				<button class="btn btn-info" onclick="location.href='/qna/list'">List</button>

			</div>
			<!--  end panel-body -->
		</div>
		<!--  end panel-body -->
	</div>
	<!--  end panel -->
</div>
<!--  /.row -->
