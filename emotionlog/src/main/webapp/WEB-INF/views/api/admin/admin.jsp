<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<meta charset="UTF-8">
<title>Admin main</title>
</head>
<body>
<h1>Admin main</h1>

<main>
	
	<section width= "400">
		<h2>지난 7일간 일기 통계</h2>
		<hr>
	    <canvas id="diaryChart"></canvas>
	</section>
	
	<section>
		<h2>회원 목록</h2>
		<div>+</div>
		<hr>
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
			
		
			</tbody>
		
		</table>	
	</section>
	
	

</main>


<script>
$(document).ready(function() {
    // Ajax 요청으로 지난 7일간 일기 데이터를 가져오기
    $.ajax({
        url: '/api/admin/diary-counts',  
        method: 'GET',
        dataType: 'json',
        success: function(response) {
            console.log(response); // 데이터 확인

            // 날짜와 일기 개수를 분리
            let labels = response.map(function(item) {
                return item.regdateStr; // 날짜
            });

            let data = response.map(function(item) {
                return item.dailyCount; // 일기 개수
            });

            // 차트 렌더링
            let ctx = document.getElementById('diaryChart').getContext('2d');
            let diaryChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: '일기 개수',
                        data: data,
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        },
        error: function(xhr, status, error) {
            console.error('Ajax 요청 실패:', error);
        }
    });
    
    $.ajax({
    	url: '/api/admin/users',  
        method: 'GET',
        data: {limit: 5},
        dataType: 'json',
        success: function(response) {
        	console.log(response);
        	
        	 // 테이블에 데이터를 추가
            let tableBody = $('.userList tbody');
            tableBody.empty();  // 기존 테이블 내용 비우기 (초기화)
            
         // 응답받은 데이터로 테이블 채우기
            response.forEach(function(user) {
                let row = '<tr>' +
                    '<td>' + user.username + '</td>' +
                    '<td>' + user.name + '</td>' +
                    '<td>' + user.birthday + '</td>' +
                    '<td>' + user.phone_number + '</td>' +
                    '<td>' + user.gender + '</td>' +
                '</tr>';
                tableBody.append(row);
            });
            
            
        },
        error: function(xhr, status, error) {
            console.error('Error:', xhr.responseText); 
        }
    })
    
    
});
</script>
    
</script>


</body>
</html>