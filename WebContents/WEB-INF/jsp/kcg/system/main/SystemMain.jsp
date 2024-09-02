<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="common.utils.common.CmmnMap"%>
<%@ page import="common.utils.json.JsonUtil"%>

<!DOCTYPE html>
<html>
<head>
<!-- 헤더META-->
<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp"
	flush="false" />

<script src="/static_resources/lib/Chart.js/2.9.4/Chart.min.js"></script>
<script src="/static_resources/system/js/bootstrap-datepicker.js"></script>
<script src="/static_resources/system/js/bootstrap-datepicker.ko.js"></script>

<!-- 스타일 시트 -->
<link rel="stylesheet" href="/static_resources/system/css/systemMain.css" />

<title>관리자시스템 | Dashboard</title>
</head>
<body class="page-body" data-url="http://neon.dev">

	<div class="page-container" class="main-content">
		<!-- add class "sidebar-collapsed" to close sidebar by default, "chat-visible" to make chat appear always -->

		<!-- 사이드바 -->
		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp"
			flush="false" />

		<!-- 헤더 -->
		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp"
			flush="false" />
			
		<!-- 메인 -->
		<main>
			<!-- 좌측 -->
			<div class="personal-side">
				<div class="my-customers small">
					<h1 class="title">담당 고객 추이</h1>
					<div class="cus-age">
						<h2 class="subtitle">연령 추이</h2>
						<div class="graph"></div>
					</div>
					<div class="cus-gender">
						<h2 class="subtitle">성별 추이</h2>
						<div class="graph"></div>
					</div>
				</div>
				<div class="to-do-list small">
					<h1 class="title">오늘 할 일</h1>
					<p class="completed">✔ 1/7 Completed</p>
					<ul id="toDoList">
						<li><input type="checkbox"
							onchange="handleTaskCompletion(this)" /> 무슨 무슨 할 일</li>
						<li><input type="checkbox"
							onchange="handleTaskCompletion(this)" /> 무슨 무슨 할 일</li>
						<li><input type="checkbox"
							onchange="handleTaskCompletion(this)" /> 무슨 무슨 할 일</li>
						<li><input type="checkbox"
							onchange="handleTaskCompletion(this)" /> 무슨 무슨 할 일</li>
						<li><input type="checkbox"
							onchange="handleTaskCompletion(this)" /> 무슨 무슨 할 일</li>
						<li><input type="checkbox"
							onchange="handleTaskCompletion(this)" /> 무슨 무슨 할 일</li>
						<li><input type="checkbox"
							onchange="handleTaskCompletion(this)" /> 무슨 무슨 할 일</li>
					</ul>
				</div>
			</div>
			<!-- 메인 -->
			<div class="main-side">
				<div class="my-sales">
					<h1 class="title">나의 판매 현황</h1>
					<div class="chart">
						<img
							src="https://www.cmn.co.kr/webupload/ckeditor/images/20221029_142541_0483013.png"
							alt="나의 판매 현황 그래프" />
					</div>
				</div>
				<div class="sales-monitor">
					<!-- 탭 영역 -->
					<div class="tabs">
						<button class="tab-button active" onclick="showTabContent('age')">
							연령대별</button>
						<button class="tab-button" onclick="showTabContent('gender')">
							성별별</button>
						<button class="tab-button" onclick="showTabContent('product')">
							상품 종류별</button>
					</div>
					<!-- 날짜(월) 필터 -->
					<div class="date-filter">
						<select id="month">
							<option value="2024-01">2024년 1월</option>
							<option value="2024-02">2024년 2월</option>
							<!-- 추가 옵션들 -->
						</select>
					</div>
					<!-- 콘텐츠 영역 -->
					<div class="tab-content" id="age">
						<h1 class="title">연령대별 인기 상품</h1>
						<div class="chart age"></div>
					</div>
					<div class="tab-content" id="gender" style="display: none">
						<h1 class="title">성별별 인기 상품</h1>
						<div class="chart gender"></div>
					</div>
					<div class="tab-content" id="product" style="display: none">
						<h1 class="title">상품 종류별 인기 상품</h1>
						<div class="chart product"></div>
					</div>
				</div>
			</div>
			<!-- 우측 -->
			<div class="companion-side">
				<div class="best-marketer small">
					<h1 class="title">이달의 마케터</h1>
					<div class="person">
						<p class="rank">1위</p>
						<img
							src="https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
							alt="프로필 사진" />
						<div class="person-info">
							<p class="name">홍길동</p>
							<p class="sales">전월 총 판매량: 1,753 건</p>
						</div>
					</div>
					<div class="person">
						<p class="rank">2위</p>
						<img
							src="https://images.pexels.com/photos/2748239/pexels-photo-2748239.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
							alt="프로필 사진" />
						<div class="person-info">
							<p class="name">홍길동</p>
							<p class="sales">전월 총 판매량: 1,753 건</p>
						</div>
					</div>
					<div class="person">
						<p class="rank">3위</p>
						<img
							src="https://images.pexels.com/photos/1520760/pexels-photo-1520760.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
							alt="프로필 사진" />
						<div class="person-info">
							<p class="name">홍길동</p>
							<p class="sales">전월 총 판매량: 1,753 건</p>
						</div>
					</div>
				</div>
				<div class="chatting-room small">
					<h1 class="title">실시간 채팅</h1>
					<div class="chat">
						<img
							src="https://images.pexels.com/photos/1520760/pexels-photo-1520760.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
							alt="글쓴이 프로필 사진" />
						<div class="chat-info">
							<span class="name">홍길동</span> <span class="chattedAt">1분 전</span>
							<p class="message">Lorem ipsum dolor sit amet consectetur
								adipisicing elit. Nihil, similique?</p>
						</div>
					</div>
					<div class="chat">
						<img
							src="https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
							alt="글쓴이 프로필 사진" />
						<div class="chat-info">
							<span class="name">홍길동</span> <span class="chattedAt">1분 전</span>
							<p class="message">Lorem ipsum dolor sit amet consectetur
								adipisicing elit. Nihil, similique?</p>
						</div>
					</div>
					<div class="chat">
						<img
							src="https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
							alt="글쓴이 프로필 사진" />
						<div class="chat-info">
							<span class="name">홍길동</span> <span class="chattedAt">1분 전</span>
							<p class="message">Lorem ipsum dolor sit amet consectetur
								adipisicing elit. Nihil, similique?</p>
						</div>
					</div>

					<!-- 메시지 입력 창 및 전송 버튼 -->
					<div class="chat-input">
						<input type="text" id="messageInput" placeholder="메시지를 입력하세요..." />
						<button onclick="sendMessage()">전송</button>
					</div>
				</div>
			</div>
		</main>

		<script>
		// 탭 콘텐츠 표시 함수
		function showTabContent(tabName) {
		    var contents = document.getElementsByClassName("tab-content");
		    for (var i = 0; i < contents.length; i++) {
		        contents[i].style.display = "none";
		    }

		    var tabs = document.getElementsByClassName("tab-button");
		    for (var i = 0; i < tabs.length; i++) {
		        tabs[i].classList.remove("active");
		    }

		    document.getElementById(tabName).style.display = "block";
		    event.currentTarget.classList.add("active");
		}

		// 메시지 전송 함수
		function sendMessage() {
		    var input = document.getElementById("messageInput");
		    var messageText = input.value.trim();

		    if (messageText !== "") {
		        var chatRoom = document.querySelector(".chatting-room");
		        var newChat = document.createElement("div");
		        newChat.className = "chat";
		        newChat.innerHTML = '<img src="https://via.placeholder.com/50" alt="프로필 사진" />'
		                + '<div class="chat-info">'
		                + '<span class="name">사용자</span>'
		                + '<span class="chattedAt">방금</span>'
		                + '<p class="message">'
		                + messageText
		                + "</p>"
		                + "</div>";
		        chatRoom.insertBefore(newChat, chatRoom.lastElementChild);
		        scrollToBottom();  // 메시지 전송 후 스크롤을 맨 아래로 이동
		    }
		}

		// 채팅창 스크롤을 맨 아래로 이동시키는 함수
		function scrollToBottom() {
		    var chatRoom = document.querySelector(".chatting-room");
		    chatRoom.scrollTop = chatRoom.scrollHeight;
		}

		// 할 일 완료 처리 함수
		function handleTaskCompletion(checkbox) {
		    var listItem = checkbox.parentElement;
		    var toDoList = document.getElementById("toDoList");

		    if (checkbox.checked) {
		        listItem.style.textDecoration = "line-through"; // 완료된 항목에 취소선 추가
		        toDoList.appendChild(listItem); // 완료된 항목을 리스트의 맨 뒤로 이동
		    } else {
		        listItem.style.textDecoration = "none"; // 취소선 제거
		        toDoList.insertBefore(listItem, toDoList.firstChild); // 완료되지 않은 항목을 리스트의 맨 앞으로 이동
		    }

		    updateCompletionStatus();
		}

		// 완료 상태 업데이트 함수
		function updateCompletionStatus() {
		    var checkboxes = document.querySelectorAll("#toDoList input[type='checkbox']");
		    var completedCount = 0;
		    checkboxes.forEach(function(checkbox) {
		        if (checkbox.checked) {
		            completedCount++;
		        }
		    });
		    var statusText = "✔ " + completedCount + "/" + checkboxes.length + " Completed";
		    document.querySelector(".to-do-list .completed").textContent = statusText;
		}

		// 페이지 로드 시 실행되는 코드
		window.onload = function() {
		    scrollToBottom();
		}
		</script>

	</div>
</body>


</html>