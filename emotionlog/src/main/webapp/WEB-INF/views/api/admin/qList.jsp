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
</head>
<body>
	<%@include file="../includes/navbar.jsp"%>

	<main style="margin: 5vh 10vw">
		<section class="card" style="background-color: white;">
			<div class="card-header" >
				문의사항
				<a href="/api/admin" style="text-decoration: none; color: inherit;">
					<i class="fa-solid fa-house-user"></i>
				</a> 
			</div>
			<div class="card-body">
				<table class="table">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<!-- <th>수정일</th> -->
						</tr>
					</thead>
					<c:forEach items="${question}" var="qList">
						<tr>
							<td><c:out value="${qList.qno}" /></td>
							<td><a style="text-decoration: none; color: inherit;" class='move' 
								href='<c:out value="qna/${qList.qno }"/>'> <c:out
										value="${qList.qtitle}"  />
							</a></td>
							<%-- <td><c:out value="${qList.qcontent}" /></td> --%>
							<td><c:out value="${qList.username}" /></td>
							<td><fmt:formatDate pattern="yy-MM-dd"
									value="${qList.qdate}" /></td>
							<%-- <td><fmt:formatDate pattern="yy-MM-dd"
							value="${qList.qupdate_date}" /></td> --%>
						</tr>
					</c:forEach>

				</table>
			</div>
		</section>

	</main>
</body>
</html>