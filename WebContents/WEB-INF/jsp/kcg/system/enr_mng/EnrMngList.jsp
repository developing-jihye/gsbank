<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp" flush="false" />
    <link rel="stylesheet" href="/static_resources/system/js/datatables/datatables.css">
    <link rel="stylesheet" href="/static_resources/system/js/datatables/enrmnglist.css">
    <link rel="stylesheet" href="/static_resources/system/js/select2/select2-bootstrap.css">
    <link rel="stylesheet" href="/static_resources/system/js/select2/select2.css">
    <title>관리자시스템</title>
    <script src="https://cdn.jsdelivr.net/npm/vue@2"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body class="page-body">
    <div class="page-container">
        <jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp" flush="false" />
        <div class="main-content">
            <jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp" flush="false" />
            <ol class="breadcrumb bc-3">
                <li><a href="#none" onclick="cf_movePage('/system')"><i class="fa fa-home"></i>Home</a></li>
                <li class="active"><strong>상품가입</strong></li>
            </ol>
            <h2>상품가입</h2>
            <br />
            <div class="container" id="vueapp">
                <div class="left">
                    <div class="form-group2">
                        <label for="prodCode" class="form-control">고객:</label>
                        <select v-model="selectedCustomer" class="form-control">
                            <option value="0">전체</option>
                            <option value="1">일반개인</option>
                            <option value="2">청년생활지원</option>
                        </select>
                    </div>
                    <div class="form-group2">
                        <label for="prodCode" class="form-control">상품:</label>
                        <select v-model="selectedProduct" class="form-control">
                            <option value="0">전체</option>
                            <option value="1">상품1</option>
                            <option value="2">상품2</option>
                        </select>
                    </div>
                    <div class="Align_A">
                        <button type="button" class="btn btn-blue" @click="getListCond()">가입하기</button>
                    </div>
                </div>
                <div class="right">
                    <div class="table-container" style="max-height: 580px overflow-y: auto border: 1px solid #999999">
                        <table class="table table-bordered datatable dataTable custom-table" id="grid_app" style="width: 100% border-collapse: collapse">
                            <thead>
                                <tr class="replace-inputs">
                                    <th style="width: 4%" class="center hidden-xs nosort"><input type="checkbox" id="allCheck"></th>
                                    <th style="width: 24%" class="center">가입ID</th>
                                    <th style="width: 24%" class="center">고객이름</th>
                                    <th style="width: 24%" class="center">상품명</th>
                                    <th style="width: 24%" class="center">가입날짜</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(item, index) in items" :key="index">
                                    <td class="center"><input type="checkbox" name="is_check"></td>
                                    <td class="center center-align">{{ item.enrl_id }}</td>
                                    <td class="center center-align">{{ item.cust_nm }}</td>
                                    <td class="center center-align">{{ item.prod_nm }}</td>
                                    <td class="center center-align">{{ new Date(item.enrl_dt).toLocaleDateString() }}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div style="height: 15px"></div>
                    <div class="flex flex-100 flex-padding-10 flex-gap-10 white-background" style="justify-content: flex-end border: 1px solid #999999">
                        <button type="button" class="btn btn-orange btn-small align11" @click="cf_movePage('/prod_mng/dtl')">삭제</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
new Vue({
    el: '#vueapp',
    data: {
        selectedCustomer: '0',
        selectedProduct: '0',
        items: [] // Initialize items as an empty array
    },
    mounted() {
        console.log("Vue instance mounted");
        this.fetchData(); // Fetch data when the component is mounted
    },
    methods: {
        fetchData() {
            console.log("Fetching data...");
            axios.get('/enr_mng/getlist')
                .then(response => {
                    console.log("API response:", response);
                    console.log("Response data:", response.data);
                    console.log("Response body:", response.data.body);
                    this.items = response.data
                    /*
                    if (response.data && response.data.body) {
                        console.log("Response body:", response.data.body);
                        this.items = response.data.body
                        
                        this.convertToJSON(response.data.body);
                        
                    } else {
                        console.error("Unexpected response data structure:", response.data);
                    }*/
                })
                .catch(error => {
                    console.error("There was an error fetching the data:", error);
                });
            console.log("this.items :", this.items);
            
        },
        getListCond(flag) {
            console.log("getListCond called with flag:", flag);
        },
        cf_movePage(url) {
            console.log("Redirecting to:", url);
            window.location.href = url
        },
        
        convertToJSON(data) {
            try {
                // JSON.stringify를 사용하여 JavaScript 객체를 JSON 문자열로 변환
                const jsonString = JSON.stringify(data, null, 2); // `null`과 `2`는 포맷팅을 위한 것
                
                console.log("jsonString == " + jsonString);
                
                return jsonString;
            } catch (error) {
                console.error('Error converting to JSON:', error);
                return null;
            }
        },

    }
});
</script>
</body>
</html>