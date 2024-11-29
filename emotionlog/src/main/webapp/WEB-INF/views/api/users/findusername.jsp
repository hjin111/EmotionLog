<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Emotion Log🌱</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #99ddc8, #95bf74); /* Tiffany Blue to Pistachio */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            color: #fff;
        }
        
        .login-container {
            background-color: rgba(40, 63, 59, 0.8); /* Dark Slate Gray */
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 350px;
            text-align: center;
        }

        .login-container h1 {
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

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
        }

        .form-group input:focus {
            border-color: #95bf74; /* Pistachio */
            outline: none;
            box-shadow: 0 0 5px rgba(149, 191, 116, 0.5); /* Pistachio glow */
        }

        button {
            width: 100%;
            background-color: #659b5e; /* Asparagus */
            color: #fff;
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

        .footer a {
            color: #99ddc8; /* Tiffany Blue */
            text-decoration: underline;
        }

        /* Error Modal */
        #errorModal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: rgba(0, 0, 0, 0.8);
            padding: 20px;
            border-radius: 10px;
            color: #fff;
            text-align: center;
            z-index: 1000;
        }

        #errorModal button {
            margin-top: 10px;
            background-color: #95bf74;
            border: none;
            padding: 10px 20px;
            color: #fff;
            cursor: pointer;
            border-radius: 5px;
        }

        #errorModal button:hover {
            background-color: #659b5e;
        }

        /* Overlay effect */
        #overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7); /* Dark background */
            z-index: 999;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>아이디 찾기</h1>
        <form action="/api/users/findusername" method="POST">
            <div class="form-group">
                <label for="username">Name</label>
                <input type="text" id="name" name="name" placeholder="Enter your name" required/>
            </div>
            <div class="form-group">
                <label for="phone_number">Phone Number</label>
                <input type="text" id="phone_number" name="phone_number" placeholder="ex) 010-1234-5678" required/>
            </div>
            <button type="submit">아이디 찾기</button>
        </form>
    </div>

    <!-- Error Modal -->
    <div id="errorModal">
        <p>${error}</p>
        <button id="closeModal">Close</button>
    </div>

    <!-- Overlay -->
    <div id="overlay"></div>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            var errorMessage = "<c:out value='${error}'/>"; // JSTL 안전 출력

            if (errorMessage.trim().length > 0) { // 오류 메시지가 비어있지 않으면
                $("#overlay").fadeIn();
                $("#errorModal").fadeIn();
            }

            $("#closeModal").click(function() {
                $("#overlay").fadeOut();
                $("#errorModal").fadeOut();
            });
        });
    </script>
</body>
</html>
