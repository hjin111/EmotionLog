<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 변경</title>
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
    </style>

</head>
<body>
    <div class="login-container">
        <h1>비밀번호 변경</h1>
        <form action="/api/users/passwordupdate" method="POST">
        	<div class="form-group">
                <label for="username">ID</label>
                <input type="text" id="username" name="username" placeholder="Enter your id" required/>
            </div>
            <div class="form-group">
                <label for="phone_number">Phone Number</label>
    			<input type="text" id="phone_number" name="phone_number" placeholder="ex) 010-1234-5678" required>
            </div>
            <div class="form-group">
                <label for="newPassword">새 비밀번호:</label>
    			<input type="text" name="newPassword" required>  
            </div>
            <div class="form-group">
                <label for="confirmPassword">새 비밀번호 확인:</label>
    			<input type="text" name="confirmPassword" required>
    		 </div>
            <button type="submit">비밀번호 변경</button>
        </form>
    </div>
    
</body>
</html>
