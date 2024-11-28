<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Page</title>
    <style>
        /* 기존 스타일 그대로 유지 */
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #99ddc8, #95bf74);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            color: #fff;
        }

        .container {
            text-align: center;
            background: rgba(40, 63, 59, 0.9); 
            padding: 60px 60px;
            border-radius: 20px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
            width: 80%;
            max-width: 600px;
        }

        h2 {
            font-size: 32px;
            margin-bottom: 15px;
            font-weight: bold;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }

        .welcome-message {
            font-size: 20px;
            color: #e0e0e0;
            margin-bottom: 30px;
            font-weight: bold;
            letter-spacing: 1px;
        }

        .user-info {
            background: rgba(255, 255, 255, 0.1); 
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
            font-size: 18px; 
            color: #2c2c2c; 
            background: rgba(255, 255, 255, 0.95); 
            border: none;
            border-radius: 8px;
            margin-top: 5px;
            text-align: center; 
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            font-family: 'Arial', sans-serif;
        }

        .user-info input[readonly] {
            background: rgba(240, 240, 240, 0.9); 
            color: #2a2a2a;
            cursor: not-allowed;
        }

        .button-container {
            margin-top: 25px;
        }

        .button-container a {
            display: inline-block;
            background: #659b5e;
            color: white;
            padding: 12px 25px;
            text-decoration: none;
            font-size: 18px;
            border-radius: 8px;
            margin: 10px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .button-container a:hover {
            background: #556f44;
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
        }

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
                font-size: 16px;
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
                color: #99ddc8;
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
            <p>This is ${pageContext.request.userPrincipal.name} Information.</p>
        </div>   

        <form action="/api/users/mypageModify" method="post">
            <div class="user-info">
                <label for="username"><strong>Your ID</strong></label>
                <input type="text" id="username" name="username" value='<c:out value="${users.username }"/>' readonly>

                <label for="name"><strong>Your Name</strong></label>
                <input type="text" id="name" name="name" value='<c:out value="${users.name }"/>'>

                <label for="birthday"><strong>Your Birthday</strong></label>
	            <!-- String을 Date로 변환 후 포맷팅 -->
	            <fmt:parseDate value="${users.birthday}" pattern="yyyy-MM-dd" var="birthdayDate"/>
	            <input type="text" id="birthday" name="birthday" value='<fmt:formatDate value="${birthdayDate}" pattern="yyyy-MM-dd"/>'> 
            
                <label for="phoneNumber"><strong>Your PhoneNumber</strong></label>
                <input type="text" id="phone_number" name="phone_number" value='<c:out value="${users.phone_number }"/>'>

                <label for="gender"><strong>Your Gender</strong></label>
				<select id="gender" name="gender" style="width: 100%; padding-top: 10px; padding-bottom: 10px; font-size: 18px; color: #2c2c2c; background: rgba(255, 255, 255, 0.95); border: none; border-radius: 8px; margin-top: 5px; text-align: center; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); font-family: 'Arial', sans-serif;">
				    <option value="M">MAN</option>
				    <option value="F">WOMAN</option>
				</select>
            </div>

            <div class="button-container">
                <button type="submit" style="background: #4CAF50; padding: 12px 25px; font-size: 18px; color: white; border: none; border-radius: 8px; margin: 10px; cursor: pointer;">
                    Save Changes
                </button>
            </div>
        </form>
    </div>
</body>
</html>