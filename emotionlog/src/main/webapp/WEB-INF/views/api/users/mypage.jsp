<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Emotion Log🌱</title>
    <style>
/* 기본적인 body 스타일 */
body {
	font-family: 'Arial', sans-serif;
	background: linear-gradient(to right, #99ddc8, #95bf74);
	/* Tiffany Blue to Pistachio */
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
	color: #fff;
}

/* 메인 컨테이너 스타일 */
.container {
	text-align: center;
	background: rgba(40, 63, 59, 0.9); /* Dark Slate Gray */
	padding: 60px 60px;
	border-radius: 20px;
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	width: 80%;
	max-width: 600px;
}

/* 제목 스타일 */
h2 {
	font-size: 32px;
	margin-bottom: 15px;
	font-weight: bold;
	text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
}

/* 환영 문구 스타일 */
.welcome-message {
	font-size: 20px;
	color: #e0e0e0;
	margin-bottom: 30px;
	font-weight: bold;
	letter-spacing: 1px;
}


/* 사용자 정보 박스 스타일 */
.user-info {
	background: rgba(255, 255, 255, 0.1); /* Slightly transparent white */
	color: #f9f9f9;
	padding: 25px;
	border-radius: 15px;
	margin-bottom: 25px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}

.user-info label {
	display: block;
	margin-top: 15px;
	font-size: 18px;
	color: #f9f9f9;
}

.user-info input {
	width: 100%;
	padding-top: 10px;
	padding-bottom: 10px;
	font-size: 18px; /* 글자 크기 증가 */
	color: #2c2c2c; /* 텍스트 색상 */
	background: rgba(255, 255, 255, 0.95); /* 밝은 배경색 */
	border: none;
	border-radius: 8px;
	margin-top: 5px;
	text-align: center; /* 중앙 정렬 */
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	font-family: 'Arial', sans-serif;
}

.user-info input[readonly] {
	background: rgba(240, 240, 240, 0.9); /* 읽기 전용일 때 밝은 배경 */
	color: #2a2a2a;
	cursor: not-allowed;
}

/* 버튼 컨테이너 스타일 */
.button-container {
	margin-top: 25px;
}

.button-container a {
	display: inline-block;
	background: #659b5e; /* Asparagus */
	color: white;
	padding: 12px 25px;
	text-decoration: none;
	font-size: 18px;
	border-radius: 8px;
	margin: 10px;
	transition: all 0.3s ease;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

/* 버튼 호버 효과 */
.button-container a:hover {
	background: #556f44; /* Fern Green */
	transform: translateY(-3px); /* 살짝 위로 올라가는 효과 */
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
}

/* 작은 화면에서 더 나은 반응형 디자인 */
@media ( max-width : 600px) {
	.container {
		padding: 30px 20px;
	}
	h2 {
		font-size: 28px;
	}
	.welcome-message {
		font-size: 18px;
	}
	.user-info input {
		font-size: 16px; /* 작은 화면에서도 크기를 적절히 유지 */
		padding: 8px;
	}
	.button-container a {
		font-size: 16px;
		padding: 10px 20px;
	}
	.footer {
		margin-top: 20px;
		font-size: 14px;
		color: rgba(255, 255, 255, 0.7);
	}
	.footer a {
		color: #99ddc8; /* Tiffany Blue */
		text-decoration: underline;
	}
	
	.footer a:hover {
		font-style: red;
	}
}
</style>
</head>
<body>
    <div class="container">
        <h2>MY PAGE</h2>

        <!-- 환영 문구 수정 -->
        <div class="welcome-message">
            <p>This is ${pageContext.request.userPrincipal.name} Information🌱</p>
        </div>   

        <div class="user-info">
            <label for="username"><strong>Your ID</strong></label>
            <input type="text" id="username" name='name' value='<c:out value="${users.username }"/>' readonly>

            <label for="name"><strong>Your Name</strong></label>
            <input type="text" id="name" name='name' value='<c:out value="${users.name }"/>' readonly>

            <label for="birthday"><strong>Your Birthday</strong></label>
            <!-- String을 Date로 변환 후 포맷팅 -->
            <fmt:parseDate value="${users.birthday}" pattern="yyyy-MM-dd" var="birthdayDate"/>
            <input type="text" id="birthday" value='<fmt:formatDate value="${birthdayDate}" pattern="yyyy-MM-dd"/>' readonly> 

            <label for="phoneNumber"><strong>Your PhoneNumber</strong></label>
            <input type="text" id="phoneNumber" value='<c:out value="${users.phone_number }"/>' readonly> 

            <label for="gender"><strong>Your Gender</strong></label>
			<input type="text" style="text-align: center; padding-left:50px; width:496px;" id="gender" value='<c:choose>
        	<c:when test="${fn:trim(String.valueOf(users.gender)) eq 'M'}">MAN</c:when>
        	<c:when test="${fn:trim(String.valueOf(users.gender)) eq 'F'}">WOMAN</c:when>
    		</c:choose>' readonly>

        </div>

        <div class="button-container">
            <a href="/api/users/mypageModify">Modify</a>
            <a href="/api/diary/list">My Diary</a>
        </div>

		<div class="footer">
			사용중인 계정을 삭제하시겠습니까?
			<form action="/api/users/delete" method="post">
				<input type="hidden" name="username" value="${users.username}" />
				<button type="submit"
					style="color: #fff; text-decoration: underline; background: none; border: none; cursor: pointer;"
					onmouseover="this.style.color='red'"
					onmouseout="this.style.color='#fff'">계정 삭제</button>
			</form>
		</div>


	</div>
</body>
</html>