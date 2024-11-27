<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Page</title>
    <style>
        /* 기본적인 body 스타일 */
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

        /* 메인 컨테이너 스타일 */
        .container {
            text-align: center;
            background: rgba(40, 63, 59, 0.9); /* Dark Slate Gray */
            padding: 40px 60px;
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

        .welcome-message p {
            font-size: 22px;
            color: #fff;
            font-weight: normal;
            margin-top: 10px;
            font-style: italic;
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

        .user-info p {
            font-size: 18px;
            margin: 15px 0;
            line-height: 1.6;
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
        @media (max-width: 600px) {
            .container {
                padding: 30px 20px;
            }

            h2 {
                font-size: 28px;
            }

            .welcome-message {
                font-size: 18px;
            }

            .user-info {
                padding: 15px;
            }

            .button-container a {
                font-size: 16px;
                padding: 10px 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>MY PAGE</h2>

        <!-- 환영 문구 수정 -->
        <div class="welcome-message">
            <p>환영합니다, ${pageContext.request.userPrincipal.name}님!</p>
        </div>   

        <div class="user-info">
            <p><strong>User Name:</strong> ${pageContext.request.userPrincipal.name}</p>
            <p><strong>Email:</strong> user@example.com</p> <!-- 실제 이메일로 변경 -->
            <p><strong>Account Created:</strong> 2024-01-01</p> <!-- 실제 가입일로 변경 -->
        </div>

        <div class="button-container">
            <a href="/api/users/mypage">Modify</a>
            <a href="/api/diary/list">My Diary</a>
        </div>
    </div>
</body>
</html>