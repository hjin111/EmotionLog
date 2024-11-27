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
	

</main>


<script>
        $(document).ready(function() {
            // Ajax 요청으로 지난 7일간 일기 데이터를 가져오기
            $.ajax({
                url: '/api/admin/diary-counts',  // REST API 엔드포인트
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
        });
    </script>
</body>
</html>