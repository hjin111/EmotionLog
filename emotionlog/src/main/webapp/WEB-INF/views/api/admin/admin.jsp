<!-- 작성자 : 심세연 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<meta charset="UTF-8">
<!-- <title>Admin main</title> -->
<!-- <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous"> -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css"
	integrity="sha512-5Hs3dF2AEPkpNAR7UiOHba+lRSJNeM2ECkwxUIxC1Q/FLycGTbNapWXB4tP889k5T5Ju8fs4b1P5z/iB4nMfSQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
	<%@include file="../includes/navbar.jsp"%>
	<!-- <h1>Admin main</h1> -->
	<!-- <script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script> -->
	<main style="margin: 5vh 10vw">

		<section
			style="display: flex; justify-content: center; flex-wrap: wrap; gap: 10px;">

			<article class="card"
				style="flex: 1 1 calc(50% - 10px); background-color: white;">

				<h2 class="card-header">지난 7일간 사용자 일기 통계</h2>

				<canvas id="diaryChart" class="card-body"></canvas>
			</article>

			<article class="card"
				style="flex: 1 1 calc(50% - 10px); background-color: white;">
				<h2 class="card-header">관리자 프로필</h2>
				<div class="card-body" style="width: 100%; display: flex; justify-content: center; align-items: center;">				
				<div style="text-align: center;">
					<span class="material-symbols-outlined" style="display: block; font-size: 96px; font-weight: 200">badge</span>
					<div>					
						<p id="name" style="margin: 0">관리자 이름</p>
						<p id="username" style="margin: 0">관리자 아이디</p>
						<p id="phone_number" style="margin: 0">관리자 전화번호</p>
					</div>
				</div>
					
				</div>
			</article>
		</section>

		<section
			style="display: flex; justify-content: center; flex-wrap: wrap; gap: 10px;">

			<article class="card"
				style="flex: 1 1 calc(50% - 10px); background-color: white;">
				<div class="card-header">
					회원 목록 <a href="/api/admin/users"
						style="text-decoration: none; color: inherit;">
						<i class="fa-solid fa-plus"></i>
					</a>
				</div>
				<!-- <div> -->

				<!-- </div> -->

				<div class="card-body">
					<div class="table-responsive">

						<table id="userList" class="table" style="width: 100%">
							<thead>
								<tr>
									<th scope="col">아이디</th>
									<th scope="col">이름</th>
									<th scope="col">생일</th>
									<th scope="col">전화번호</th>
									<th scope="col">성별</th>
								</tr>
							</thead>
							<tbody>


							</tbody>

						</table>
					</div>
				</div>
			</article>


			<article class="card"
				style="flex: 1 1 calc(50% - 10px); background-color: white;">
				<div class="card-header">
					답변 대기 중 문의 <a href="/api/admin/qna"
						style="text-decoration: none; color: inherit;">
						<i class="fa-solid fa-plus"></i>
					</a>

				</div>



				<div class="card-body">
					<div class="table-responsive">
						<table id="qList" class="table">
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">제목</th>
									<!-- <th>내용</th> -->
									<th scope="col">작성자</th>
									<th scope="col">작성일</th>
								</tr>
							</thead>
							<tbody>


							</tbody>

						</table>
					</div>
				</div>
			</article>

		</section>


	</main>


	<script>
		$(document).ready(function() {
			
			/* 일기 개수 데이터 불러오기 */
			$.ajax({
				url : '/api/admin/diary-counts',
				method : 'GET',
				dataType : 'json',
				success : function(response) {
						console.log(response); // 데이터 확인
						// 날짜와 일기 개수를 분리
						let labels = response.map(function(
								item) {
							return item.regdateStr; // 날짜
						});
	
						let data = response.map(function(item) {
								return item.dailyCount; // 일기 개수
							});
	
							// 차트 렌더링
							let ctx = document.getElementById(
									'diaryChart').getContext(
									'2d');
							let diaryChart = new Chart(ctx,{
									type : 'bar',
									data : {
										labels : labels,
										datasets : [ {
											label : '일기 개수',
											data : data,
											backgroundColor : 'rgba(75, 192, 192, 0.2)',
											borderColor : 'rgba(75, 192, 192, 1)',
											borderWidth : 1
										} ]
										},
										options : {
	
										/* maintainAspectRatio: false, */
											scales : {
												y : {
													beginAtZero : true,
													max: 10,
													ticks: {
														stepSize : 2
													} 
	
												}
											}
									
										}
									});
						},
						error : function(xhr, status, error) {
							console.error('Ajax 요청 실패:', error);
						}
					});

			/* 관리자 프로필 불러오기 */
			$.ajax({
				url : '/api/admin/profile',
				method : 'GET',
				dataType : 'json',
				success : function(response) {
					console.log(response);
					$('#name').text(response.name);
					$('#username').text(response.username);
					$('#phone_number').text(response.phone_number);
				},
				error : function(xhr, status, error) {
					console.error('Error:', xhr.responseText);
				}
			});
			
			
			
			/* 회원 목록(일부) 불러오기 */
			$.ajax({
				url : '/api/admin/userpart',
				method : 'GET',
				data : {
					limit : 5
				},
				dataType : 'json',
				success : function(response) {
					/* console.log(response); */
					
					if(response.length > 0 ) {
						

					// 테이블에 데이터를 추가
					let tableBody = $('#userList tbody');
					tableBody.empty(); // 기존 테이블 내용 비우기 (초기화)

					// 응답받은 데이터로 테이블 채우기
					response.forEach(function(user) {
		                
						let row = '<tr>' + '<td>'
								+ user.username + '</td>'
								+ '<td>' + user.name + '</td>'
								+ '<td>' + user.birthday
								+ '</td>' + '<td>'
								+ user.phone_number + '</td>'
								+ '<td>' + user.gender
								+ '</td>' + '</tr>';
						tableBody.append(row);
					});
					} else {
						let noQuestion = '';
                    	tableBody.append(noQuestion);
					}

				},
				error : function(xhr, status, error) {
					console.error('Error:', xhr.responseText);
				}
			});
			
		

			$.ajax({
				url : '/api/admin/qnapart',
				method : 'GET',
				data : {
					limit : 5
				},
				dataType : 'json',
				success : function(response) {
					console.log(response);

					// 테이블에 데이터를 추가
					let tableBody = $('#qList tbody');
					tableBody.empty(); // 기존 테이블 내용 비우기 (초기화)

					// 응답받은 데이터로 테이블 채우기
					response.forEach(function(q) {
						let formattedDate = new Date(q.qdate)
								.toLocaleDateString('en-CA', {
									year : '2-digit',
									month : '2-digit',
									day : '2-digit'
								});

						let row = `
						    <tr>
						        <td>\${q.qno}</td>
						        <td><a href="/api/admin/qna/\${q.qno}" class="move" style="text-decoration: none; color: inherit;">\${q.qtitle}</a></td>
						        <td>\${q.username}</td>
						        <td>\${formattedDate}</td>
						    </tr>
						`
						tableBody.append(row);
					});

				},
				error : function(xhr, status, error) {
					console.error('Error:', xhr.responseText);
				}
			});

		});
	</script>

	</script>


</body>
</html>