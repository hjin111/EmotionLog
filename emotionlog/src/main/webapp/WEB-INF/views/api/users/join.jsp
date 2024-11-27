<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #99ddc8, #95bf74); /* Tiffany Blue to Pistachio */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            color: #fff;
        }

        .signup-container {
            background-color: rgba(40, 63, 59, 0.8); /* Dark Slate Gray */
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 350px;
            text-align: center;
        }

        .signup-container h1 {
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
        }

        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: #2575fc;
            outline: none;
            box-shadow: 0 0 5px rgba(37, 117, 252, 0.5);
        }

        button {
            width: 100%;
            background-color: #659b5e; /* Asparagus */
            color: white;
            border: none;
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #556f44; /* Fern Green */
        }

        .footer {
            margin-top: 20px;
            font-size: 14px;
            color: rgba(255, 255, 255, 0.7);
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <h1>회원가입</h1>
        <form action="/api/users/join" method="post">
            <div class="form-group">
                <label for="username">아이디</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="birthday">생일</label>
                <input type="text" id="birthday" name="birthday"  placeholder="ex) 2024-01-01 " required>
            </div>
            <div class="form-group">
                <label for="phone_number">전화번호</label>
                <input type="text" id="phone_number" name="phone_number"  placeholder="ex) 010-1234-5678" required>
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="gender">성별</label>
                <select id="gender" name="gender">
                    <option value="M">남성</option>
                    <option value="F">여성</option>
                </select>
            </div>
            <!-- 권한 설정 -->
            <div class="form-group">
                <label for="authority">Role</label>
                <select id="authority" name="authority">
                    <option value="ROLE_USER">일반회원</option>
                    <option value="ROLE_ADMIN">관리자</option>
                </select>
            </div>
            <div>
                <button type="submit">계정 생성</button>
            </div>
        </form>
        <div class="footer">
            이미 계정이 있으신가요? <a href="/api/users/login" style="color: #fff; text-decoration: underline;">로그인</a>
        </div>
    </div>
</body>
</html>
