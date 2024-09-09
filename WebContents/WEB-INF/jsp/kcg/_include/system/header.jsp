<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link rel="stylesheet" href="/static_resources/system/css/header.css" />
<header>
	<p class="greeting">
		반갑습니다, <b>${userName}</b>님! 고객에게 맞는 상품을 추천할 준비가 되셨나요?
	</p>
	<ul class="user_logInOut">
		<li class="image-box" onclick="toggleDropdown()">
			<img src="${profileImage}" alt="프로필사진" />
		</li>
		<li class="dropdown">
			<a href="#gm" onclick="cf_logout()">로그아웃</a>
		</li>
	</ul>
</header>

<script>
	function toggleDropdown() {
		const dropdownMenu = document.querySelector('.dropdown');
		dropdownMenu.classList.toggle('show');
	}
</script>