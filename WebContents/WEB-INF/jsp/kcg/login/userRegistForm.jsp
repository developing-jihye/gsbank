<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>사용자정보등록</title>

<!-- import 된 제이쿼리 사용 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- import 된 폰트어썸 4.0 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">

<!-- import 된 JS경로 -->
<script src="/static_resources/login/userRegistForm.js"></script>



</head>

<body>
	<main class="form-signin">
		<form action="<c:url value='/login/userRegistProc'/>" method="post"
			id="userForm" onsubmit="return validateForm()"
			enctype="multipart/form-data">
			<img src="/static_resources/login/images/gsBank.png" class="gsb" alt="로고" />
			<h1>사용자 정보 등록</h1>

			<div>
				<div id="image_container" name="image_container"
					class="image_container"></div>
				<input type="file" id="photoNm" name="photoNm" accept="image/*"
					onchange="setThumbnail(event)" placeholder="사진등록" />
			</div>
			<br />

			<div>
				*사용자ID <input type="text" class="input-radius" id="userId"
					name="userId" placeholder="" required autofocus />
			</div>

			<div>
				*사용자명 : <input type="text" class="input-radius" id="userNm"
					name="userNm" placeholder="" />
			</div>
			<br />

			<div>
				*부서명 : <select id="deptNmValue" name="deptNmValue"
					class="form-control" oninput="setValueDeptNm()">
					<option disabled selected hidden>부서</option>
					<c:forEach items="${list2}" var="dept">
						<option><c:out value="${dept.codeNm}" /></option>
					</c:forEach>
				</select> <input type="hidden" class="input-radius" id="tdeptNm"
					name="tdeptNm" placeholder="" />
			</div>
			<br />
			<div>
				*직위 : <select id="jbpsTyCd" name="jbpsTyCd" class="form-control"
					oninput="setValueJbpsNm()">
					<option disabled selected hidden>선택</option>
					<c:forEach items="${list}" var="list">
						<option><c:out value="${list.codeNm}" /></option>
					</c:forEach>
				</select> <input type="hidden" class="input-radius" id="jbpsNm" name="jbpsNm"
					placeholder="" />
			</div>
			<br />

			<div>
				*연락처 : <input type="text" class="input-radius" id="picMblTelno"
					name="picMblTelno" placeholder="" />
			</div>
			<br />

			<div>
				*E-Mail ID : <input type="text" class="input-radius" id="picEmlAddr"
					name="picEmlAddr" placeholder="" oninput="checkEmail()" /> <br />
				<div id="checkEmailtext" class="error"></div>
			</div>
			<br />

			<div>
				*입사일자 : <input type="date" class="input-radius" id="jncmpYmd_date"
					name="jncmpYmd_date" required pattern="\d{4}\d{2}-\d{2}"
					placeholder="" oninput="setValueJncmpYmd()" /> <input
					type="hidden" class="input-radius" id="jncmpYmd" name="jncmpYmd" />
				<span class="validity"></span>
			</div>
			<br />

			<div>
				*기 타 : <input type="text" class="input-radius" id="etcTskCn"
					name="etcTskCn" placeholder="" />
			</div>
			<br />

			<div>
				*Password : <input type="password" class="input-radius"
					id="userPswd" name="userPswd" placeholder=""
					oninput="confirmPswdVl()" />
			</div>
			<br />

			<div>
				*PW Confirm : <input type="password" class="input-radius"
					id="pswdVlConfirm" name="pswdVlConfirm" placeholder=""
					oninput="confirmPswdVl()" /> <br />
				<div id="dynamicContent" class="error"></div>
			</div>
			<br />

			<button type="button" class="temp" onClick="cleanRegistForm()">
				입력데이터 초기화</button>
			<button type="button" class="temp" onClick="goMainPage()">
				이전페이지로</button>
			<input type="hidden" class="input-radius" id="deptNm" name="deptNm"
				placeholder="" />
			<button type="submit" class="temp">등록</button>
		</form>
	</main>
</body>


<!-- 내부 스타일 추가 -->
<style>
body {
	background: linear-gradient(135deg, #f5f5f5 0%, #e0e0e0 100%);
	padding: 0;
}

.form-signin {
	margin: 0 auto;
	background-color: #fff;
	border-radius: 12px; /* 모서리를 둥글게 설정 */
	box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
	padding: 15px; /* 내부 여백을 20px로 설정 */
	width: 90%; /* 너비를 부모 요소의 90%로 설정 */
	max-width: 500px;
	box-sizing: border-box; /* 패딩과 테두리를 너비와 높이에 포함 */
}

/* 제목 스타일 */
h1 {
	margin-top: 0; /* 상단 여백 제거 */
	font-size: 24px; /* 폰트 크기 줄임 */
	text-align: center; /* 가운데 정렬 */
	width: 100%; /* 너비를 100%로 설정하여 가운데 정렬 효과 유지 */
	color: #212121; /* 제목 색상 설정 (선택 사항) */
}

/* 입력 필드와 버튼의 패딩과 폰트 크기 조정 */
.form-signin input[type="text"], .form-signin input[type="password"],
	.form-signin input[type="date"], .form-signin input[type="file"],
	.form-signin select {
	width: 100%; /* 부모 요소의 너비에 맞춤 */
	padding: 8px; /* 패딩을 줄임 */
	font-size: 14px; /* 폰트 크기 줄임 */
	box-sizing: border-box; /* 패딩과 테두리를 너비에 포함시킴 */
	margin-top: 5px; /* 상단 여백 추가 */
	margin-bottom: 8px; /* 하단 여백 추가 */
}

/* 사용자 ID 필드 특별 조정 */
#userId {
	margin-top: 8px; /* 상단 여백 조정 */
	margin-bottom: 8px; /* 하단 여백 조정 */
	padding: 8px; /* 내부 여백 조정 */
}

/* 버튼 스타일 조정 */
button, input[type="submit"] {
	width: 100%; /* 부모 요소의 너비에 맞춤 */
	margin-top: 10px; /* 상단 여백 줄임 */
	padding: 8px; /* 패딩을 줄임 */
	font-size: 14px; /* 폰트 크기 줄임 */
	border: none;
	border-radius: 8px;
	background-color: #007bff;
	color: white;
	cursor: pointer;
	transition: background-color 0.3s ease, transform 0.3s ease;
	box-sizing: border-box; /* 패딩과 테두리를 너비에 포함시킴 */
}

button:hover, input[type="submit"]:hover {
	background-color: #0056b3;
	transform: scale(1.02);
}

button.temp {
	background-color: #6c757d;
	font-size: 14px;
	transition: background-color 0.3s ease, transform 0.3s ease;
}

button.temp:hover {
	background-color: #5a6268;
}

input[type="hidden"] {
	display: none;
}

.error {
	color: #dc3545;
	font-size: 14px;
}

.image_container {
	text-align: center;
}

.image_container img {
	max-width: 100%;
	border-radius: 8px;
}

.gsb {
	display: block;
	margin: 0;
	width: 200px;
	height: auto;
}
</style>


</html>
