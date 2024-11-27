<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>EmotionLog</title>
<!-- 부트스트랩 CSS 추가 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css"
	integrity="sha512-mSYUmp1HYZDFaVKK//63EcZq4iFWFjxSL+Z3T/aCt4IO9Cejm03q3NKKYN6pFQzY0SBOr8h+eCIAZHPXcpZaNw=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />

<style>
body {
	font-family: 'Arial', sans-serif;
	background: linear-gradient(to right, #99ddc8, #95bf74);
	/* Tiffany Blue to Pistachio */
	margin: 0;
	color: #000; /* 기본 텍스트 색상 */
}

.col-md-8 {
	width: 100%;
}

.gmr-container {
	background-color: rgba(40, 63, 59, 0.8); /* Dark Slate Gray */
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	width: 70%;
	text-align: center;
}

/* 전체 달력 중앙 정렬 */
.calendar-wrapper {
	display: flex;
	justify-content: center; /* 가로 중앙 정렬 */
	align-items: center;
	margin: 0 auto;
	padding: 20px;
}

/* 달력 테이블 설정 */
.calendar-table {
	border-collapse: collapse; /* 셀 간의 간격 제거 */
	border-spacing: 0; /* 테이블 간의 여백 제거 */
	width: 100%; /* 테이블 너비를 부모 요소에 맞춤 */
	max-width: 1600px; /* 최대 너비 제한 */
	table-layout: fixed; /* 셀 크기를 고정 */
	height: 100%;
	margin: 0 auto; /* 중앙 정렬 */
	border: transparent;
}

/* 달력 셀 설정 */
.calendar-table th, .calendar-table td {
	text-align: center;
	vertical-align: top; /* 내용이 위쪽에 정렬되도록 설정 */
	font-weight: bold;
	color: #283F3B;
	background-color: #f8f9fa; /* 기본 배경색 */
}

.calendar-table th {
	background-color: #95bf74; /* Pistachio */
	color: #fff;
	font-size: 10px;
	text-transform: uppercase;
	border: transparent;
	padding: 10px 0; /* 적당한 여백 */
	border-top-left-radius: 20px;
	border-top-right-radius: 20px;
}
/* 첫 번째 셀과 마지막 셀에 추가적인 둥근 효과 */
.calendar-table th:first-child {
	border-top-left-radius: 20px;
}

.calendar-table th:last-child {
	border-top-right-radius: 20px;
}

.calendar-table td {
	text-align: center;
	vertical-align: middle;
	height: 20px;
	width: 20px;
	border: 1px solid #ddd;
	font-weight: bold;
	color: #283F3B;
	background-color: #f8f9fa; /* 셀 배경색 */
}

.calendar-table td:hover {
	background-color: #99ddc8; /* Hover color */
	transform: scale(1.1); /* Hover animation */
	cursor: pointer;
}

.calendar-table td .content {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

.calendar-card {
	display: flex;
	flex-direction: column;
	justify-content: flex-start; /* 카드 내부 내용 위쪽 정렬 */
	align-items: flex-start; /* 텍스트 왼쪽 정렬 */
	height: 100%;
	width: 100%;
	border-radius: 8px;
	background-color: #f8f9fa;
	padding: 10px;
	overflow: hidden;
}

.calendar-card .date {
	font-size: 10px;
	font-weight: bold;
	text-align: center; /* 날짜 번호는 중앙 정렬 */
	width: 100%;
	margin-bottom: 8px;
}

.calendar-card .cart-header {
	font-size: 1.5rem;
	font-weight: bold;
	margin-bottom: 10px;
}

.calendar-card .card-text {
	font-size: 0.9rem;
	line-height: 1.5;
	text-align: left; /* 텍스트 왼쪽 정렬 */
	overflow-wrap: break-word;
	word-break: break-word;
	overflow-y: auto; /* 내용이 넘치면 스크롤 */
	max-height: calc(100% - 30px); /* 날짜 번호를 제외한 높이 제한 */
}

.chat li {
	border-bottom: 2px dotted grey;
	padding-bottom: 10px; /* 줄과 텍스트 간격 추가 */
	margin-bottom: 10px; /* 줄 아래 간격 추가 */
}

/* Tiffany Blue */
.header-tiffany-blue {
	background-color: #99DDC8;
	color: #000; /* 어두운 텍스트 */
}

/* Pistachio */
.header-pistachio {
	background-color: #95BF74;
	color: #fff; /* 밝은 텍스트 */
}

/* Asparagus */
.header-asparagus {
	background-color: #659B5E;
	color: #fff;
}

/* Fern Green */
.header-fern-green {
	background-color: #556F44;
	color: #fff;
}

/* Dark Slate Gray */
.header-dark-slate-gray {
	background-color: #283F3B;
	color: #fff;
}

/* 공통 스타일 */
.custom-navbar {
	padding: 1rem;
}

.navbar-brand {
	font-weight: bold;
}

.nav-link {
	margin-left: 15px;
}

.nav-link:hover {
	text-decoration: underline;
}

.datepicker-container {
	width: 100%; /* 동일한 너비를 유지 */
	max-width: 1600px;
	margin: 0 auto 20px auto; /* 중앙 정렬 및 아래쪽 간격 */
	text-align: left;
}

.datepicker-input {
	width: 100%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
	font-size: 16px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	background-color: #fff;
}

.calendar-container {
	background-color: #95bf74; /* 헤더와 같은 색상으로 설정 */
	border-top-left-radius: 20px; /* 테두리 둥글게 */
	border-top-right-radius: 20px; /* 테두리 둥글게 */
	padding: 10;
	margin: 10; /* 컨테이너의 외부 여백 제거 */
	max-width: 1600px;
}

.header-container {
	width: 100%; /* 동일한 너비를 유지 */
	max-width: 1600px;
	margin: 20px auto;
	text-align: left;
}

.header-title {
	font-size: 2.5rem;
	font-weight: bold;
	color: #283F3B; /* Dark Slate Gray */
	margin-bottom: 0;
	text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2); /* 부드러운 그림자 효과 */
}

.header-subtitle {
	font-size: 1.2rem;
	font-weight: 300;
	color: #556F44; /* Fern Green */
	margin: 5px 0 20px 0;
}

.divider {
	width: 80px;
	height: 5px;
	background-color: #95BF74; /* Pistachio */
	margin: 10px 0;
	border-radius: 5px;
}

.centered {
	display: flex; /* 플렉스 박스를 사용하여 정렬 */
	flex-direction: column; /* 세로로 정렬 */
	align-items: flex-start; /* 왼쪽 정렬 */
	margin: 20px;
}
/* Panel 스타일 */
.panel {
	border: 1px solid #dee2e6;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	background-color: #ffffff;
	padding: 20px;
}

/* Panel 헤더 스타일 */
.panel-heading {
	font-size: 1.5rem;
	font-weight: bold;
	color: #343a40;
	border-bottom: 2px solid #dee2e6;
	margin-bottom: 20px;
	text-align: center;
	padding: 10px 0;
	background-color: #f8f9fa;
	border-radius: 10px 10px 0 0;
}

/* 입력 필드 스타일 */
input[type="text"], textarea, select {
	width: 100%;
	padding: 10px;
	border: 1px solid #dee2e6;
	border-radius: 5px;
	background-color: #f8f9fa;
	margin-bottom: 15px;
	box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.05);
	font-size: 1rem;
}

/* 버튼 스타일 */
button {
	padding: 10px 15px;
	font-size: 1rem;
	border-radius: 5px;
	border: none;
	transition: background-color 0.3s ease, transform 0.2s ease;
}

button:hover {
	background-color: #007bff;
	color: #ffffff;
	transform: scale(1.05);
}

button.modify {
	background-color: #28a745;
	color: #ffffff;
}

button.list {
	background-color: #6c757d;
	color: #ffffff;
}

/* 감정 선택 스타일 */
select {
	font-size: 1rem;
	height: auto;
	cursor: pointer;
}

.form-group {
	margin-bottom: 15px;
	text-align: left;
	font-weight: bold;
}
/* 댓글 카드 스타일 */
.card {
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	margin-top: 20px;
}

/* 댓글 헤더 스타일 */
.card-header {
	background-color: #f8f9fa;
	border-bottom: 1px solid #dee2e6;
	font-weight: bold;
	font-size: 1rem;
	color: #343a40;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

/* 버튼 스타일 */
#addReplyBtn {
	font-size: 0.875rem;
	padding: 0.4rem 0.8rem;
	border-radius: 5px;
	transition: background-color 0.3s ease, transform 0.2s ease;
}

#addReplyBtn:hover {
	background-color: #28a745;
	color: #fff;
	transform: scale(1.05);
}

/* 댓글 리스트 스타일 */
.chat.list-unstyled {
	padding: 0;
	margin: 10px 0;
}

.chat.list-unstyled li {
	list-style: none;
	padding: 10px 15px;
	margin-bottom: 5px;
	border-radius: 5px;
	background-color: #f8f9fa;
	border: 1px solid #dee2e6;
	transition: background-color 0.3s ease;
	text-align: left; /* 왼쪽 정렬 */
}

.chat.list-unstyled li:hover {
	background-color: #e9ecef;
}

/* 댓글 푸터 스타일 */
.card-footer {
	background-color: #f8f9fa;
	border-top: 1px solid #dee2e6;
	padding: 10px;
	text-align: center;
	font-size: 0.875rem;
	color: #6c757d;
}

.card-footer small {
	font-style: italic;
}
</style>

</head>