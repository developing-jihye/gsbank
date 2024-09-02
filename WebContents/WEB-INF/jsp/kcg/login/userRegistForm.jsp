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

<!-- 제이쿼리 사용 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- 폰트어썸 4.0 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">

<!-- JS경로 -->
<script src="/static_resources/login/userRegistForm.js"></script>

<!-- 내부 스타일 추가 -->
<style>
/* Noto Sans KR 폰트 추가 */
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap');

body {
    font-family: 'Noto Sans KR', sans-serif;
    background: linear-gradient(135deg, #f5f5f5 0%, #e0e0e0 100%);
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
    padding: 0;
}

main.form-signin {
    background: #ffffff;
    border-radius: 12px;
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
    padding: 30px;
    width: 90%;
    max-width: 600px;
    box-sizing: border-box;
}

h1 {
    margin-top: 0;
    font-size: 28px;
    color: #333;
    text-align: center;
    font-weight: 700;
}

.form-signin input[type="text"], 
.form-signin input[type="password"], 
.form-signin input[type="date"], 
.form-signin input[type="file"], 
.form-signin select {
    width: calc(100% - 20px);
    padding: 12px;
    margin-top: 12px;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-sizing: border-box;
    font-size: 16px;
    transition: border-color 0.3s ease;
}

.form-signin input[type="text"]:focus, 
.form-signin input[type="password"]:focus, 
.form-signin select:focus {
    border-color: #007bff;
    outline: none;
}

button, input[type="submit"] {
    margin-top: 12px;
    padding: 12px 24px;
    border: none;
    border-radius: 8px;
    background-color: #007bff;
    color: white;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.3s ease;
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

@media (max-width: 600px) {
    .form-signin {
        width: 100%;
        padding: 20px;
    }

    h1 {
        font-size: 24px;
    }

    .form-signin input[type="text"], 
    .form-signin input[type="password"], 
    .form-signin input[type="date"], 
    .form-signin input[type="file"], 
    .form-signin select {
        width: calc(100% - 20px);
        padding: 10px;
    }

    button, input[type="submit"] {
        padding: 10px 20px;
        font-size: 14px;
    }
}
</style>


</head>

<body>
    <main class="form-signin">
        <form action="<c:url value='/login/userRegistProc'/>" method="post"
            id="userForm" onsubmit="return validateForm()"
            encType="multipart/form-data">
            <h1>사용자 정보 등록</h1>

            <div>
                <div id="image_container" name="image_container" class="image_container"></div>
                <input type="file" id="photoNm" name="photoNm" accept="image/*" onchange="setThumbnail(event)" placeholder="사진등록">
            </div>
            <br>

            <div>
                사용자ID <input type="text" class="input-radius" id="userId" name="userId" placeholder="" required autofocus>
            </div>

            <div>
                *사용자명 : <input type="text" class="input-radius" id="picNm" name="picNm" placeholder="">
            </div>
            <br>

            <div>
                *부서명 : <select id="deptNmValue" name="deptNmValue" class="form-control" oninput="setValueDeptNm()">
                    <option disabled selected hidden>부서</option>
                    <c:forEach items="${list}" var="list">
                        <option><c:out value="${list.codeNm}" /></option>
                    </c:forEach>
                </select>
            </div>
            <br>

            <div>
                *직위 : <select id="jbpsTyCd" name="jbpsTyCd" class="form-control" oninput="setValueJbpsNm()">
                    <option disabled selected hidden>선택</option>
                    <c:forEach items="${list2}" var="list2">
                        <option><c:out value="${list2.codeNm}" /></option>
                    </c:forEach>
                </select>
                <input type="hidden" class="input-radius" id="jbpsNm" name="jbpsNm" placeholder="">
            </div>
            <br>

            <div>
                연락처 : <input type="text" class="input-radius" id="picMblTelno" name="picMblTelno" placeholder="">
            </div>
            <br>

            <div>
                *E-Mail ID : <input type="text" class="input-radius" id="picEmlAddr" name="picEmlAddr" placeholder="" oninput="checkEmail()"> <br>
                <div id="checkEmailtext" class="error"></div>
            </div>
            <br>

            <div>
                *입사일자 : <input type="date" class="input-radius" id="jncmpYmd_date" name="jncmpYmd_date" required pattern="\d{4}\d{2}-\d{2}" placeholder="" oninput="setValueJncmpYmd()"> 
                <input type="hidden" class="input-radius" id="jncmpYmd" name="jncmpYmd">
                <span class="validity"></span>
            </div>
            <br>

            <div>
                *기 타 : <input type="text" class="input-radius" id="etcTskCn" name="etcTskCn" placeholder="">
            </div>
            <br>

            <div>
                *Password : <input type="password" class="input-radius" id="userPswd" name="userPswd" placeholder="" oninput="confirmPswdVl()">
            </div>
            <br>

            <div>
                *PW Confirm : <input type="password" class="input-radius" id="pswdVlConfirm" name="pswdVlConfirm" placeholder="" oninput="confirmPswdVl()"> <br>
                <div id="dynamicContent" class="error"></div>
            </div>
            <br>

            <button type="button" class="temp" onClick="cleanRegistForm()">입력데이터 초기화</button>
            <button type="button" class="temp" onClick="goMainPage()">이전페이지로</button>
            <input type="hidden" class="input-radius" id="deptNm" name="deptNm" placeholder="">
            <button type="submit" class="temp">등록</button>
        </form>
    </main>
</body>
</html>
