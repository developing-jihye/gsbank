<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link rel="stylesheet" href="/static_resources/system/css/header.css" />
<header>
	<div class="local-date-time">여기 뭐 넣을까요</div>
	<ul class="personal-information">
		<li class="image-box">
			<img
				src="https://newsimg-hams.hankookilbo.com/2022/03/03/4a69a88d-35f7-4473-9f7b-662e34f179c3.jpg"
				alt="프로필사진" />
		</li>
		<li class="user-id" onclick="toggleDropdown()">${userInfoVO.userId}</li>
		<li class="dropdown-menu">
			<a href="#gm" onclick="cf_logout()"> 로그아웃</a>
		</li>
	</ul>
</header>

<script>
	function toggleDropdown() {
		const dropdownMenu = document.querySelector('.dropdown-menu');
		dropdownMenu.classList.toggle('show');
	}
</script>