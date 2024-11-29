<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<nav class="navbar navbar-expand-lg header-fern-green custom-navbar" style="font-size: 20px; color: white;">
    <div class="container-fluid">
        <a class="navbar-brand" href="#" style="font-size: 35px; color: #fff;">EmotionLog🌱</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                 <li class="nav-item"><a class="nav-link" href="/api/users/mypage" style="font-size: 22px; color: #fff;">Mypage</a></li>
				<!-- 수정된 로그아웃 부분: form으로 변경 -->
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
