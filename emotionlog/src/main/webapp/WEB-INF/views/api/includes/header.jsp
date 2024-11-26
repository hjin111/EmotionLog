<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>EmotionLog</title>
    <!-- 부트스트랩 CSS 추가 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" integrity="sha512-mSYUmp1HYZDFaVKK//63EcZq4iFWFjxSL+Z3T/aCt4IO9Cejm03q3NKKYN6pFQzY0SBOr8h+eCIAZHPXcpZaNw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<style>
    /* 전체 달력 중앙 정렬 */
    .calendar-wrapper {
        display: flex;
        justify-content: center; /* 가로 중앙 정렬 */
        align-items: center;
        margin: 0 auto;
        padding: 20px;
    }

    /* 테이블 스타일 */
    .calendar-table {
        table-layout: fixed;
        width: auto;
        margin: 0 auto; /* 테이블 자체 중앙 정렬 */
    }

    .calendar-table th,
    .calendar-table td {
        text-align: center; /* 날짜 번호 중앙 정렬 */
        vertical-align: top; /* 내용 위쪽 정렬 */
        height: 150px; /* 셀 높이 고정 */
        width: 150px; /* 셀 너비 고정 */
    }

    .calendar-card {
        display: flex;
        flex-direction: column;
        justify-content: flex-start; /* 카드 내부 내용 위쪽 정렬 */
        align-items: flex-start; /* 텍스트 왼쪽 정렬 */
        height: 100%;
        width: 100%;
        border: 1px solid #ddd;
        border-radius: 8px;
        background-color: #f8f9fa;
        padding: 10px;
        overflow: hidden;
    }
    
    
    .calendar-card .date {
        font-size: 18px;
        font-weight: bold;
        text-align: center; /* 날짜 번호는 중앙 정렬 */
        width: 100%;
        margin-bottom: 8px;
    }

    .calendar-card .card-text {
        font-size: 14px;
        line-height: 1.5;
        text-align: left; /* 텍스트 왼쪽 정렬 */
        overflow-wrap: break-word;
        word-break: break-word;
        overflow-y: auto; /* 내용이 넘치면 스크롤 */
        max-height: calc(100% - 30px); /* 날짜 번호를 제외한 높이 제한 */
    }
    
    .chat li {
        border-bottom: 2px dotted grey; /* 빨간 줄 추가 */
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
</style>

</head>
<body>
<!-- Tiffany Blue Header -->
    <nav class="navbar navbar-expand-lg header-fern-green custom-navbar">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">MySite</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="#">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Services</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Contact</a></li>
                </ul>
            </div>
        </div>
    </nav>