<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<style>
button:hover {
color: #fff !important;
}
</style>

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
                            <option v-for="customer in uniqueCustomers" :value="customer">{{ customer }}</option>
                        </select>
                    </div>
                    <div class="form-group2">
                        <label for="prodCode" class="form-control">상품:</label>
                        <select v-model="selectedProduct" class="form-control">
                            <option value="0">전체</option>
                            <option v-for="product in uniqueProducts" :value="product">{{ product }}</option>
                        </select>
                    </div>
                    <div class="Align_A">
                        <button type="button" class="btn btn-blue2 btn-icon icon-left" @click="getListCond()">가입하기</button>
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
                        <button type="button" class="btn btn-red btn-icon icon-left" @click="cf_movePage('/prod_mng/dtl')">삭제</button>
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
            items: [], // 전체 데이터
            uniqueItems: [], // 중복 제거된 데이터
            uniqueCustomers: [], // 중복 제거된 고객 이름
            uniqueProducts: [] // 중복 제거된 상품명
        },
        mounted() {
            console.log("Vue instance mounted");
            this.fetchData(); // 컴포넌트가 마운트되면 데이터 가져오기
        },
        methods: {
            fetchData() {
                console.log("Fetching data...");
                axios.get('/enr_mng/getlist')
                    .then(response => {
                        console.log("API response:", response);
                        this.items = response.data; // 전체 데이터 저장
                        this.filterUniqueItems(); // 중복 제거된 데이터 추출
                        this.extractUniqueCustomers(); // 중복 제거된 고객 이름 추출
                        this.extractUniqueProducts(); // 중복 제거된 상품명 추출
                    })
                    .catch(error => {
                        console.error("There was an error fetching the data:", error);
                    });
            },
            filterUniqueItems() {
                const seen = new Set();
                this.uniqueItems = this.items.filter(item => {
                    const key = item.cust_nm + '|' + item.prod_nm;
                    if (seen.has(key)) {
                        return false;
                    }
                    seen.add(key);
                    return true;
                });
                console.log("Unique items:", this.uniqueItems);
            },
            extractUniqueCustomers() {
                const seen = new Set();
                this.uniqueCustomers = this.items
                    .map(item => item.cust_nm) // 고객 이름 추출
                    .filter(name => {
                        if (seen.has(name)) {
                            return false;
                        }
                        seen.add(name);
                        return true;
                    });
                console.log("Unique customers:", this.uniqueCustomers);
            },
            extractUniqueProducts() {
                const seen = new Set();
                this.uniqueProducts = this.items
                    .map(item => item.prod_nm) // 상품명 추출
                    .filter(name => {
                        if (seen.has(name)) {
                            return false;
                        }
                        seen.add(name);
                        return true;
                    });
                console.log("Unique products:", this.uniqueProducts);
            },
            getListCond(flag) {
                console.log("getListCond called with flag:", flag);
            },
            cf_movePage(url) {
                console.log("Redirecting to:", url);
                window.location.href = url;
            }
        }
    });
    </script>
</body>
</html>