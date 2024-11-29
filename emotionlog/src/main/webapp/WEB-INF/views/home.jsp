<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Emotion Log🌱</title>
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
            text-align: center;
        }

        /* Emotion Log 제목 스타일 */
        h1 {
            font-size: 96px; /* 텍스트 크기 키움 */
            font-weight: bold;
            color: #fff;
            text-shadow: 4px 4px 8px rgba(0, 0, 0, 0.5);
            margin-bottom: 40px;
        }

        /* 링크 스타일 */
        ul {
            list-style-type: none;
            padding: 0;
            margin-top: 20px;
        }

        li {
            display: inline-block;
            margin: 10px;
        }

        a {
            text-decoration: none;
            background: rgba(40, 63, 59, 0.8); /* Asparagus */
            color: white;
            padding: 12px 25px;
            font-size: 18px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
        }

        /* 버튼 호버 효과 */
        a:hover {
            background: #556f44; /* Fern Green */
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
        }

        /* 작은 화면에서 더 나은 반응형 디자인 */
        @media (max-width: 600px) {
            h1 {
                font-size: 60px; /* 모바일에서 폰트 크기 조정 */
            }
            
            a {
                font-size: 16px;
                padding: 10px 20px;
            }
        }
    </style>
</head>
<body>
    <div>
        <h1>Emotion Log🌱</h1>
        <ul>
            <li><a href="/api/users/join">회원가입</a></li>
            <li><a href="/api/users/login">로그인</a></li>
        </ul>
    </div>
</body>
</html>
