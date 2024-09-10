<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp"
	flush="false" />
<link rel="stylesheet"
	href="/static_resources/system/js/datatables/datatables.css">
<link rel="stylesheet"
	href="/static_resources/system/js/datatables/enrmnglist.css">
<link rel="stylesheet"
	href="/static_resources/system/js/select2/select2-bootstrap.css">
<link rel="stylesheet"
	href="/static_resources/system/js/select2/select2.css">
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
                            <option v-for="customer in customers" :key="customer.cust_nm" :value="customer.cust_nm">{{ customer.cust_nm }}</option>
                        </select>
                    </div>
                    <div class="Align_A">
                        <button type="button" class="btn btn-blue" @click="getListCond()">조회하기</button>
                    </div>
                </div>
                <div class="right">
                    <div class="table-container" style="max-height: 580px; overflow-y: auto; border: 1px solid #999999;">
                        <table class="table table-bordered datatable dataTable custom-table" id="grid_app" style="width: 100%; border-collapse: collapse;">
                            <thead>
                                <tr class="replace-inputs">
                                    <th style="width: 4%" class="center hidden-xs nosort">
                                        <input type="checkbox" id="allCheck" @change="toggleAllChecks">
                                    </th>
                                    <th style="width: 24%" class="center">가입ID</th>
                                    <th style="width: 24%" class="center">상품명</th>
                                    <th style="width: 24%" class="center">가입날짜</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(item, index) in items" :key="index">
                                    <td class="center">
                                        <input type="checkbox" :value="item.enrl_id" v-model="selectedItems">
                                    </td>
                                    <td class="center center-align">{{ item.enrl_id }}</td>
                                    <td class="center center-align">{{ item.prod_nm }}</td>
                                    <td class="center center-align">{{ new Date(item.enrl_dt).toLocaleDateString() }}</td>
                                </tr>
                                <tr v-if="items.length === 0">
                                    <td colspan="4" class="center">데이터가 없습니다</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div style="height: 15px"></div>
                    <div class="flex flex-100 flex-padding-10 flex-gap-10 white-background" style="justify-content: flex-end border: 1px solid #999999">
                        <button type="button" class="btn btn-orange btn-small align11" @click="deleteSelectedItems">삭제</button>
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
            items: [], // 필터된 데이터
            customers: [], // 고객 데이터
            selectedItems: [] // 선택된 항목의 ID
        },
        mounted() {
            console.log("Vue instance mounted");
            this.fetchCustomers(); // 컴포넌트가 마운트되면 고객 데이터 가져오기
        },
        watch: {
            selectedItems(newVal) {
                console.log('Selected items updated:', newVal); // selectedItems 값 변경 시 로그 출력
            }
        },
        methods: {
            fetchCustomers() {
                console.log("Fetching customers...");
                axios.get('/enr_mngg/custlist') // 고객 목록을 가져오는 API 호출
                    .then(response => {
                        console.log("Customer list response:", response);
                        this.customers = response.data;
                        console.log("Customers:", this.customers); // 디버깅용
                    })
                    .catch(error => {
                        console.error("There was an error fetching the customer list:", error);
                    });
            },
            getListCond() {
                console.log("Fetching data for selected customer...");
                const params = { customer: this.selectedCustomer };

                axios.get('/enr_mngg/getlist', { params: params })
                    .then(response => {
                        console.log("Filtered data response:", response);
                        this.items = response.data; // 필터된 데이터 저장
                    })
                    .catch(error => {
                        console.error("There was an error fetching the filtered data:", error);
                    });
            },
            deleteSelectedItems: function() {
                console.log("선택된 항목 확인:", this.selectedItems); // 선택된 항목 확인

                if (this.selectedItems.length === 0) {
                    alert('삭제할 항목을 선택해 주세요.');
                    return;
                }

                var params = { enrl_id: this.selectedItems }; // 전송할 데이터
                console.log("보내기전 로그확인:", params); // 서버에 보내기 전에 로그로 확인

                // cf_ajax로 데이터 전송
                cf_ajax("/enr_mngg/delete", params, function(response) {
                    console.log("Delete response:", response); // 성공 시 응답 출력
                    if (response.success) {
                        console.log("Delete successful."); // 성공 메시지
                        // 목록 갱신 또는 추가 처리
                    } else {
                        alert('삭제 중 오류가 발생했습니다.');
                    }
                }, function(error) {
                    console.error("There was an error deleting the items:", error); // 실패 시 오류 출력
                });
            },
            toggleAllChecks(event) {
                console.log("toggleAllChecks method called"); // 메서드 호출 확인
                if (!event || !event.target) {
                    console.error('Event or event.target is undefined.');
                    return;
                }
                
                const isChecked = event.target.checked;
                console.log('Checkbox state:', isChecked); // 체크박스의 체크 상태를 로그로 출력

                // 모든 항목의 ID를 선택하거나 해제
                this.selectedItems = isChecked ? this.items.map(item => item.enrl_id) : [];
                console.log('Selected items after toggle:', this.selectedItems); // 선택된 항목의 ID를 로그로 출력
            }
        }
    });
    </script>
</body>
</html>