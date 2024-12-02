<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<nav class="navbar navbar-expand-lg header-fern-green custom-navbar" style="font-size: 20px; color: white;">
    <div class="container-fluid">
        <a class="navbar-brand" href="#" style="font-size: 35px; color: #fff;">EmotionLog🌱</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                 <li class="nav-item"><a class="nav-link" href="/api/users/mypage" style="font-size: 22px; color: #fff;">Mypage</a></li>
					<li class="nav-item">
						<!-- 관리자 권한일때 관리자 qna로 이동,  사용자 권한일때는 사용자 qna 게시판으로 이동 [ 작성자:이혜진 ]  -->
					    <sec:authorize access="hasRole('ROLE_ADMIN')">
					        <a class="nav-link" href="/api/admin/qna" style="font-size: 22px; color: #fff;">QnA</a>
					    </sec:authorize>
					    <sec:authorize access="hasRole('ROLE_USER')">
					        <a class="nav-link" href="/api/qna/list" style="font-size: 22px; color: #fff;">QnA</a>
					    </sec:authorize>
					</li>
				<!-- 수정된 로그아웃 부분: form으로 변경 [작성자:이혜진] -->
				<li class="nav-item">
					<form action="/api/users/logout" method="post"
						style="display: inline;">
						<button type="submit" class="nav-link"
							style="font-size: 22px; color: #fff; background: none; border: none; cursor: pointer;">
							Logout</button>
					</form>
				</li>
			</ul>
        </div>
    </div>
</nav>
