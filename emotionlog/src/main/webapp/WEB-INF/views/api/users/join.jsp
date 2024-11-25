<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<form action="/api/users/join" method="post">
	<div>
        <label for="username">아이디:</label>
        <input type="number" id="username" name="username" required>
    </div>
    <div>
        <label for="name">이름:</label>
        <input type="text" id="name" name="name" required>
    </div>
    <div>
        <label for="birthday">생일:</label>
        <input type="text" id="birthday" name="birthday" required>
    </div>
    <div>
        <label for="phone_number">전화번호:</label>
        <input type="text" id="phone_number" name="phone_number" required>
    </div>
    <div>
        <label for="password">비밀번호:</label>
        <input type="password" id="password" name="password" required>
    </div>
    <div>
        <label for="gender">성별:</label>
        <select id="gender" name="gender">
            <option value="M">남성</option>
            <option value="F">여성</option>
        </select>
    </div>
    <!-- 권한 설정 -->
    <div>
    	<label for="authority">Role</label>
    	<select id="authority" name="authority">
    		<option value="ROLE_USER">일반회원</option>
    		<option value="ROLE_ADMIN">관리자</option>
    	</select>
    </div>
    <div>
        <button type="submit">회원가입</button>
    </div>
</form>
</body>
</html>