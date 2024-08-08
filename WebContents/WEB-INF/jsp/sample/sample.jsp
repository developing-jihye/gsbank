<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>SMS 전송</title>
    </head>

    <!-- 제이쿼리 사용 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>


    <!-- 공통 Lib Js 사용-->
    <script src="/static_resources/lib/vue/2.6.12/vue.min.js?rscVer=${properties.rscVer}"></script>
    <script src="/static_resources/lib/babel-polyfill/7.4.4/polyfill.min.js?rscVer=${properties.rscVer}"></script>
    <script src="/static_resources/lib/axios/0.21.0/axios.min.js?rscVer=${properties.rscVer}"></script>
    <script src="/static_resources/js/commonLib.js?rscVer=${properties.rscVer}"></script>
    <script src="/static_resources/js/prototype_polyfill.js?rscVer=${properties.rscVer}"></script>

    <!-- vue 사용 -->
    <script src="/static_resources/lib/vue/2.6.12/vue.min.js"></script>


    </head>

    <body>

        <!-- 좌측으로 이동 출력되는 태그-->
        <MARQUEE>${userNm} 님 환영합니다.K-디지털트레이닝 GSITM 부트캠프 금융Project 참여를 환영합니다.</MARQUEE>

        <h2> MVC 샘플 </h2>

        <form id="mvcSample">

            <input type="text" id="inputVl1" name="inputVl1" required><br>
            <input type="text" id="inputVl2" name="inputVl2" required><br>


            <button type="submit"> 서브밋 </button>

            <button type="button" onclick="sendSms()">보내기</button>

        </form>

        <p>현재 웹 애플리케이션의 컨텍스트 경로는: ${pageContext.request.contextPath}</p>
        <img src="${pageContext.request.contextPath}/images/logo.png" alt="로고">

        <% String contextPath=request.getContextPath(); %>
            <p>현재 웹 애플리케이션의 컨텍스트 경로는: <%= contextPath %>
            </p>

            <div>${pageContext.request.contextPath}</div>
            <div>${pageContext.request.requestURL}</div>
            <div>${pageContext.request.scheme}</div>
            <div>${pageContext.request.serverName}</div>
            <div>${pageContext.request.serverPort}</div>
            <div>${pageContext.request.requestURI}</div>
            <div>${pageContext.request.servletPath}</div>


            <h2>AJAX 전송 샘플</h2>
            <form id="smsForm">
                <label for="from">발신 번호:</label><br>
                <input type="text" id="from" name="from" required><br>
                <label for="to">받는 사람 번호:</label><br>
                <input type="text" id="to" name="to" required><br>
                <label for="text">메시지 내용:</label><br>
                <textarea id="text" name="text" rows="4" required></textarea><br>
                <button type="button" onclick="sendSms()">보내기</button>

                <button type="button" onclick="sendSms()">보내기</button>

            </form>

            <div id="app">

                <h2>VUE.JS 샘플</h2>


                {{ message }}

                <input v-on:keyup.enter="alertClick">

                <button v-on:click="alertClick()"> 클릭 </button>

                
                <button @click="getCustInfoListAll(true)"> 리스트 가져오기 </button>

                <input type="file">파일파일히히힣



                <table class="" id="grid_app" style="border: 1px solid #999999;">
                    <thead>
                        <tr class="">
                            <th style="width: 5%;" class="center">
                                <input type="checkbox" id="allCheck" @click="all_check(event.target)"
                                    style="cursor: pointer;">
                            </th>
                            <th style="width: 20%;" class="center">성명</th>
                            <th style="width: 15%;" class="center">생년월일</th>
                            <th style="width: 15%;" class="center">핸드폰번호</th>
                            <th style="width: 15%;" class="center">직업</th>
                            <th style="width: 30%;" class="center">주소</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="item in dataList" @dblclick="gotoDtl(item.col1)" style="cursor: pointer;">
                            <td class="center" @dblclick.stop="return false;"><input type="checkbox"
                                    :data-idx="item.col1" name="is_check" @click.stop="onCheck"
                                    style="cursor: pointer;">
                            </td>
                            <td class="center">{{item.col1}}</td>
                            <td class="center">{{item.col2}}</td>
                            <td class="center">{{item.col3}}</td>
                            <td class="center">{{item.col4}}</td>
                            <td class="center">{{item.col5}}</td>
                        </tr>
                    </tbody>
                </table>

                <div class="dataTables_paginate paging_simple_numbers"
                id="div_paginate"></div>
            </div>


            <!-- Vue 인스턴스 생성 -->
            <script>
                new Vue({
                    el: '#app', // Vue.js가 적용될 HTML 요소의 ID 
                    data: {
                        dataList: [],
                        message: 'Hello, Vue!',
                        col1:"",
                        col2:"",
                    },
                    mounted: function () { //(예시) <div id="app">  </div>   <- 이게 페이지에 온보딩될때 발생할 VUE임
                        // this.alertClick();
                        var fromDtl = cf_getUrlParam("fromDtl");
                        var pagingConfig = cv_sessionStorage.getItem("pagingConfig");
                        if ("Y" === fromDtl && !cf_isEmpty(pagingConfig)) {
                            cv_pagingConfig.pageNo = pagingConfig.pageNo;
                            cv_pagingConfig.orders = pagingConfig.orders;

                            this.getList();
                        } else {
                            cv_sessionStorage
                                .removeItem("pagingConfig")
                                .removeItem("params");
                            this.getList(true);
                        }

                    },
                    methods: {
                        alertClick() {
                            alert("enter");
                        },
                        getList: function (isInit) {

                            cv_pagingConfig.func = this.getList;

                            if (isInit === true) {
                                cv_pagingConfig.pageNo = 1;

                                /* cv_pagingConfig.orders = [{target : "reg_dt", isAsc : false}]; */ // 정렬기준이될 컬럼명
                            }

                            var params = {

                            }
                            /*
                            if (this.all_srch != "Y") {
                                params = {
                                    prod_nm: this.prod_nm,
                                    sbstg_ty_cd: this.sbstg_ty_cd,
                                    pay_ty_cd: this.pay_ty_cd,
                                    from_date: this.from_date,
                                }
                            }*/
                            cv_sessionStorage
                                .setItem('pagingConfig', cv_pagingConfig)
                                .setItem('params', params);

                            cf_ajax("/sample/sampleBasc/getAllList", params,
                                this.getListCB);
                        },
                        getListCB: function (data) {
                            console.log("data >>" + data.list);


                            console.log("data >>");
                            data.list.forEach((item, index) => {
                                console.log(`Item ${index + 1}:`, item);
                            });
                            
                            this.dataList = data.list;


                            
                            for (var i = 0; i < this.dataList.length; i++) {
                                console.log(this.dataList[i].col1);
                                console.log(this.dataList[i].col2);
                            }
                            

                            /*
                            for (var i = 0; i < this.dataList.length; i++) {
                                this.dataList[i].ntsl_amt_min = this.dataList[i].ntsl_amt_min
                                    .numformat();
                                this.dataList[i].ntsl_amt_max = this.dataList[i].ntsl_amt_max
                                    .numformat();
                            }*/

                            cv_pagingConfig.renderPagenation("system");
                        },
                    }
                });
            </script>




            <script>
                // AJAX를 통해 SMS 보내는 함수
                function sendSms() {

                    console.log("sendSms() Called");

                    var from = document.getElementById("from").value;
                    var to = document.getElementById("to").value;
                    var text = document.getElementById("text").value;

                    var params = {
                        from: from,
                        to: to,
                        text: text
                    }

                    cf_ajax("/sample/sampleBasc/ajaxSample", params);

                    /*
                        $.ajax({
                                    async: false, //값을 리턴시 해당코드를 추가하여 동기로 변경 false : 동기, true : 비동기
                                    url: '/sample/sampleBasc/ajaxSample',
                                    type: "post",
                                    dataType: "json", // 서버에서 보내주는 데이터를 어떤 타입으로 받을건지
                                    data: {
                                            from: from, 
                                            to: to,
                                            text: text
                                    },
                                    headers: {
                                        "Accept-Language": "ko-KR" // 한글을 지원하는 언어 코드로 설정
                                    },
                                    
                                    success: function(response) {
                                        console.log("ajax 통신 성공");
                                        console.log("서버 응답:", response.message);
                               
                                    },
                                    
                                    error: function(xhr, status, error) {
                                        console.log("ajax 통신 실패");
                                        console.error("에러 발생:", xhr, status, error);
                                        console.log("서버 응답 상세:", xhr.responseText);
                                    },
                                    
                                    complete : function(response) {
                                        console.log("완료후 로직 실행되는 로직");
                                        console.log(response.message);
                                    	
                                    },
                                      // 추가: charset 옵션을 설정
                                    beforeSend: function(xhr) {
                                        xhr.overrideMimeType("text/plain; charset=utf-8");
                                    }
                                });		*/
                }
            </script>


    </body>

    </html>