<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <title>Insert title here</title> -->
<!-- <style type="text/css">
	@font-face {
	    font-family: 'Pretendard-Regular';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
	    font-weight: 400;
	    font-style: normal;
	}
	body {
		font-family: 'Pretendard-Regular';
	} -->
</style>
</head>
<body>
<%@include file="../includes/navbar.jsp" %>
	<main style="border: 5px solid pink; margin: 5vh 10vw">
		<section class="card" style="background-color: white;">
		<h2 class="card-header">전체 회원 목록</h2>
		<div class="card-body">
			<table id="userList" class="table" >
				<thead>
					<tr>
						<th>이름</th>
						<th>아이디</th>
						<th>생일</th>
						<th>전화번호</th>
						<th>성별</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="user" items="${users}">
						<tr>
							<td><c:out value="${user.name}" /></td>
							<td>${user.username}</td>
							<td>${user.birthday}</td>
							<%-- <td><fmt:formatDate pattern="yy-MM-dd"
							value="${user.birthday}" /></td> --%>
							<!-- 현재 uservo의 birthday가 string이라서 에러 남-->
							<td>${user.phone_number}</td>
							<td>${user.gender}</td>
						</tr>
					</c:forEach>
				</tbody>


			</table>
		</div>
		</section>
	</main>
</body>
</html>