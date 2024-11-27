<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>전체 회원 목록</h1>
	<main>
		<section>
			<table class="userList">
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
							<td>${user.phone_number}</td>
							<td>${user.gender}</td>
						</tr>
					</c:forEach>
				</tbody>


			</table>
		</section>
	</main>
</body>
</html>