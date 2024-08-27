<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />

                <title> 사용자 PW 찾기 </title>

                <!-- 제이쿼리 사용 -->
                <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

                <!-- 폰트어썸 4.0 -->
                <link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">

                
            </head>

            <body>

                <form action="<c:url value='/test.do'/>" method="post" id="userForm" onsubmit="">
                    <!-- encType = "multipart/form-data" --> <!-- 파일을 보내기위해선 이설정을 해야하는데 이 설정 때문에 잘되던게 안됨 -->
                    <div class="title"> 사용자PW 찾기 </div>
                    <br>
                    *사용자명 :
                    <input type="text" class="" id="userNm" name="userNm" placeholder="" required autofocus>


                    <button class="submitButton" type="button" onclick="findUserInfo()">확인</button>

                    <br>


                    *연락처 :
                    <input type="text" class="" id="mblTelno" name="mblTelno" placeholder="-를 제외한 번호를 입력해주세요" required autofocus>
                    <button class="submitButton" type="button" onclick="alert('뒤로가기')">종료</button>

                    <br>

                    *입사일자 :
                    <input type="date" class="" id="jncmpYmd" name="jncmpYmd" required pattern="\d{4}-\d{2}-\d{2}" placeholder="" required autofocus>
                    <br>

                    사용자ID :
                    <input type="text" class="" id="emlAddr" name="emlAddr" placeholder="" readonly>
                    <br>

                    <div>
                        <div class="regist">
                            1. 회원가입
                            <br>
                            <div class="contents">
                                홈페이지 회원으로 가입하시면 다양하고 유익한 혜택을 드립니다.

                            </div>


                            <br>
                            <div class="buttonArr">
                                <button class="serviceButton" type="button" onClick="location.href = '/getUserRegistForm.do'"> 서비스 바로가기 </button>
                            </div>

                        </div>


                        <div class="findPw">
                            2. 비밀번호 찾기
                            <br>
                            <div class="contents">
                                회원비밀번호를 잊으신 경우 비밀번호 찾기를 이용하여 주세요

                            </div>

                            <br>
                            <div class="buttonArr">
                                <button class="serviceButton" type="button" onClick="location.href = '/findUserPw.do'"> 서비스 바로가기 </button>
                            </div>
                        </div>

                        <!-- <div class="box"></div>
        <div class="fixed box"></div> -->

                    </div>






                    <!--
    <input type="text" class = "" id="" name="" placeholder="">
 -->
                </form>

            </body>

            </html>