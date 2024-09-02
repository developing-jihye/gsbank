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
<link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">

<!-- JS경로 -->
<script src="/static_resources/login/userRegistForm.js"></script>

<!-- CSS 경로-->
<link rel="stylesheet" type="text/css" href="/static_resources/login/userRegistForm.css">


</head>

<!-- 추후 주석처리 할것 -->
<button type="button" onClick="setValue()"> 값 세팅 </button>

<body style="text-align: center; margin: 0 auto; display: inline; padding-top: 100px;">
<main class="form-signin">


  <form action="<c:url value='/login/userRegistProc'/>" method="post" id="userForm"
  		onsubmit="return validateForm()" 
  		encType = "multipart/form-data"
  		>
	<br>
	
	<div>

	  <div id="image_container" name="image_container" class="image_container"></div>
	  <input type="file" id="photoNm" name="photoNm" accept="image/*" onchange="setThumbnail(event)" placeholder="사진등록">	 
	</div>
	<br>

  <div>사용자ID
  <input type="text" class = "input-radius" id="userId" name="userId" placeholder="" required autofocus>
  </div>

	<div>*사용자명 :
    <input type="text" class = "input-radius" id="picNm" name="picNm" placeholder="">
    	<button class="neww" type="button" onClick="cleanRegistForm()"> 신규 </button>
    </div>
    <br>

	<div>*부서명 :

		<select id="deptNmValue" name="deptNmValue" class="form-control" oninput="setValueDeptNm()" >
    		<option disabled selected hidden>부서</option>
    			<c:forEach items="${list}" var="list">
        	<option><c:out value="${list.codeNm}"/></option>
    			</c:forEach>
		</select>

    <input type="hidden" class = "input-radius" id="deptNm" name="deptNm" placeholder="" >

    	<input type="submit" value="등록">
    	<!-- <button type="button" onClick="userRegistProc()"> 등록 </button> -->
    </div>
    <br>

    <div>*직위 :
      <select id="jbpsTyCd" name="jbpsTyCd" class="form-control" oninput="setValueJbpsNm()">
    		<option disabled selected hidden>선택</option>
    			<c:forEach items="${list2}" var="list2">
        	<option><c:out value="${list2.codeNm}"/></option>
    			</c:forEach>
		</select>



    <input type="hidden" class = "input-radius" id="jbpsNm" name="jbpsNm" placeholder="">
    </div>
    <br>

    <div>연락처 :
    <input type="text" class = "input-radius" id="picMblTelno" name="picMblTelno" placeholder="">
    </div>
    <br>

    <div>*E-Mail ID :
    <input type="text" class = "input-radius" id="picEmlAddr" name="picEmlAddr" placeholder="" oninput="checkEmail()">
    
    <br>
    
    <div id="checkEmailtext"></div>
    </div>
    <br>

    <div>*입사일자 :
    <input type="date" class = "input-radius" id="jncmpYmd_date" name="jncmpYmd_date"
    	   required pattern="\d{4}\d{2}-\d{2}" placeholder="" oninput="setValueJncmpYmd()">
    	   
    <input type="hidden" class = "input-radius" id="jncmpYmd" name="jncmpYmd">
    <span class="validity"></span>
    </div>
    <br>

    <div>*기 타 :
    <input type="text" class = "input-radius" id="etcTskCn" name="etcTskCn" placeholder="" >
    </div>
    <br>


    <div>*Password :
    <input type="password" class = "input-radius" id="userPswd" name="userPswd" placeholder="" oninput="confirmPswdVl()">
    </div>
    <br>

    <div>*PW Confirm :
    <input type="password" class = "input-radius" id="pswdVlConfirm" name="pswdVlConfirm" placeholder=""  oninput="confirmPswdVl()">
    <br>
    <div id="dynamicContent"></div>
    </div>
    <br>

	<button type="button" onClick="goMainPage()">종료</button>

  </form>



</main>

</body>
</html>