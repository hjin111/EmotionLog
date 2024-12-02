<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Emotion Log🌱</title>
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

        .container {
            text-align: center;
            background: rgba(40, 63, 59, 0.8); /* Dark Slate Gray */
            padding: 30px 50px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }

        h2 {
            font-size: 28px;
            margin-bottom: 20px;
        }

        h3 {
            font-size: 20px;
            margin-bottom: 15px;
        }

        .button-container {
            margin-top: 20px;
        }

        .button-container a {
            display: inline-block;
            background: #659b5e; /* Asparagus */
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            font-size: 16px;
            border-radius: 5px;
            transition: background 0.3s;
        }

        .button-container a:hover {
            background: #556f44; /* Fern Green */
        }
    </style>

</head>
<body>
    <div class="container">
        <h2>비밀번호 변경을 성공했습니다!</h2>
        
         <div class="button-container">
            <a href="/">Home</a>

            <a href="/api/users/login">Login</a>
        </div>
    </div>
</body>
</html>
