<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp"
	flush="false" />
<!-- Imported styles on this page -->
<link rel="stylesheet"
	href="/static_resources/system/js/datatables/datatables.css">
<link rel="stylesheet"
	href="/static_resources/system/js/select2/select2-bootstrap.css">
<link rel="stylesheet"
	href="/static_resources/system/js/select2/select2.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;700&display=swap">

<%-- 스타일 시작 --%>
<style type="text/css">
.has-text-centered {
	text-align: center
}

.has-text-prev {
	background-color: #ECEFF1
}

.has-text-next {
	background-color: #ECEFF1
}

.has-text-primary {
	background-color: #598987
}

.modal-content {
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.modal-header {
	border-bottom: 1px solid #e5e5e5;
	background-color: #f6f6f6;
	border-radius: 8px 8px 0 0;
}

.modal-header .close {
	color: #a6a6a6;
	font-size: 1.5em;
}

.modal-title {
	margin: 0;
	font-size: 1.25em;
	font-weight: 600;
}

.modal-body {
	padding: 20px;
	background-color: #fff;
}

.schedule-list {
	max-height: 500px;
	overflow-y: auto;
}

.schedule-item {
	display: flex;
	align-items: center;
	padding: 10px;
	margin-bottom: 10px;
	background-color: #fafafa;
	border: 1px solid #ddd;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.schedule-item:hover {
	background-color: #eaeaea;
}

.time {
	font-weight: 500;
	margin-right: 10px;
}

.task-type {
	font-style: italic;
	color: #666;
	margin-right: 10px;
}

.task-title {
	flex: 1;
}

.no-data {
	text-align: center;
	color: #888;
	padding: 20px;
}

.modal-footer {
	border-top: 1px solid #e5e5e5;
	background-color: #f6f6f6;
	border-radius: 0 0 8px 8px;
}

.btn {
	border-radius: 4px;
}

.btn-orange {
	background-color: #ff9900;
	color: #fff;
}

.btn-orange:hover {
	background-color: #e68a00;
	color: #fff;
}

.modal-dialog {
	max-width: 800px;
	margin: 30px auto;
}

.modal-content {
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.modal-title {
	font-size: 1.5rem;
	font-weight: bold;
}

.close {
	color: #fff;
	font-size: 1.5rem;
	opacity: 1;
}

.modal-body {
	padding: 40px;
}

.form-group {
	margin-bottom: 1rem;
}

.control-label {
	font-weight: bold;
	color: #333;
}

.input-group {
	display: flex;
	align-items: center;
}

.date-field {
	max-width: 80px;
	text-align: center;
	margin-right: 5px;
}

.time-select {
	max-width: 80px;
	margin-right: 5px;
}

.btn-primary {
	background-color: #0073e6;
	border-color: #0073e6;
}

.btn-primary:hover {
	background-color: #0056b3;
	border-color: #004a9d;
}

.btn-danger {
	background-color: #dc3545;
	border-color: #dc3545;
}

.btn-danger:hover {
	background-color: #c82333;
	border-color: #bd2130;
}

.btn-secondary {
	background-color: #f6f6f6;
	border-color: #6c757d;
}

.btn-secondary:hover {
	background-color: #a6a6a6;
	border-color: #545b62;
}

.form-control {
	position: relative;
	z-index: 2;
	float: left;
	width: 25% !important;
	margin-bottom: 0;
}

input.form-control {
	position: relative;
	z-index: 2;
	float: left;
	width: 25% !important;
	margin-bottom: 0;
}

label.control-label {
	display: block;
	margin-bottom: 5px;
}

@media ( min-width : 768px) {
	.form-horizontal .control-label {
		text-align: left;
		margin-bottom: 0;
		padding-top: 10px;
		padding-bottom: 15px;
	}
	.table-hover tbody tr:hover {
		background-color: #f6f6f6;
	}
	.table {
		width: 100%;
		max-width: 100%;
		margin-bottom: 0px;
	}
	
	  body.page-body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
        }

        .page-container {
            display: flex;
            flex-direction: row;
        }

        .main-content {
            flex: 1;
            padding: 20px;
             min-height: 600px; 
            overflow-y: auto;
        }

        .breadcrumb {
            background-color: #fff;
            border-radius: 4px;
            padding: 10px 20px;
            margin-bottom: 20px;
        }

        .breadcrumb a {
            color: #007bff;
            text-decoration: none;
        }

        .breadcrumb .active {
            color: #a6a6a6;
        }

        .breadcrumb i {
            margin-right: 5px;
        }

        h2 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #212121;
            font-family: 'Noto Sans', sans-serif;
        }

        .dataTables_wrapper {
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 100%; /* Ensure it doesn't exceed the container width */
            overflow-x: auto; /* Allow horizontal scrolling if necessary */
        }

        .subtitle {
            margin-bottom: 20px;
            font-size: 18px;
            font-family: 'Noto Sans', sans-serif !important;
        }

        .button.is-small.is-primary.is-outlined {
            border: 1px solid #0073e6;
            background-color: #fff;
            color: #0073e6;
            font-weight: bold;
        }

        .button.is-small.is-primary.is-outlined:hover {
            background-color: #0073e6;
            color: #fff;
        }

        table.table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        table.table th, table.table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        table.table th {
            background-color: #f8f9fa;
        }

        table.table td.has-text-prev {
            color: #a6a6a6;
        }

        table.table td.has-text-next {
            color: #6c757d;
        }

        table.table td.has-text-primary {
            background-color: #007bff;
            color: #fff;
        }


        .btn-icon.icon-left {
            display: inline-flex;
            align-items: center;
            font-size: 0.875em;
        }

        .entypo-plus {
            margin-left: 5px;
        }
        
        tr,td {
    	font-size: 14px;
		}
		
		th {
   		 color: #212121 !important;
		}
        
              
        * {
            font-family: 'Noto Sans', sans-serif;
        }
        
      
	
}
</style>

<%-- 스타일 끝 --%>



<title>관리자시스템</title>
</head>
<body class="page-body">

	<div class="page-container">

		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp"
			flush="false" />

		<div class="main-content">

			<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp"
				flush="false" />

			<ol class="breadcrumb bc-3">
				<li><a href="#none" onclick="cf_movePage('/system')"><i
						class="fa fa-home"></i>Home</a></li>
				<li class="active"><strong>스케쥴 관리</strong></li>
			</ol>

			<h2>${userInfoVO.userId}님의 스케쥴</h2>
			<br />

			<div class="dataTables_wrapper" id="vueapp">
				<template>
					<!-- 
			<div class="dt-buttons" style="padding-top: 15px;">		
				<button type="button" class="btn btn-orange btn-icon icon-left btn-small" @click="gotoDtl()">
					추가<i class="entypo-plus"></i>
				</button>modal-body
				<button type="button" class="btn btn-orange btn-icon icon-left btn-small" @click="gotoDtl()">
					이전달<i class="entypo-plus"></i>
				</button>
				<button type="button" class="btn btn-orange btn-icon icon-left btn-small" @click="gotoDtl()">
					다음달<i class="entypo-plus"></i>
				</button>
			</div>
			 -->
					<div class="dataTables_filter"></div>

					<div>
						<h2 class="subtitle has-text-centered">
							<button class="button is-small is-primary is-outlined mr-5"
								@click="calendarData(-1)">&lt;</button>
							<%-- 다음 달로 이동하는 버튼 --%>
							{{ year }}년 {{ month }}월
							<button class="button is-small is-primary is-outlined ml-5"
								@click="calendarData(1)">&gt;</button>
							<%-- 다음 달로 이동하는 버튼 --%>
						</h2>
					</div>

					<table class="table table-bordered datatable" id="grid_app">
						<thead>
							<th class="replace-inputs center" v-for="day in days" :key="day">{{
								day }}</th>
						</thead>
						<tbody>
							<template v-for="(date, idx) in dates" :key="idx">
								<tr style="height: 10px;">
									<td class='center' v-for="(day, secondIdx) in date"
										:key="secondIdx"
										:class="{ 'has-text-prev': idx === 0 && day >= lastMonthStart, 'has-text-next': dates.length - 1 === idx && nextMonthStart > day, 'has-text-primary': day === today && currentMonth === 0 }">
										{{ idx === 0 && day >= lastMonthStart ? (month === 1?13:month)
										-1 : dates.length - 1 === idx && nextMonthStart > day ? (month
										=== 12?0:month) + 1 : month}}월 {{ day }}일 <!-- 
			            <button type="button" class="btn btn-orange btn-icon icon-left btn-small" @click="itemaddclick()">
							추가<i class="entypo-plus"></i>
						</button>
						 -->
									</td>
								</tr>
								<tr style="height: 100px;">
									<td v-for="(day, secondIdx) in date" :key="secondIdx"
										:class="{ 'has-text-prev': idx === 0 && day >= lastMonthStart, 'has-text-next': dates.length - 1 === idx && nextMonthStart > day, 'has-text-primary': day === today && currentMonth === 0 }"
										@click.stop="itemclick( idx === 0 && day >= lastMonthStart ?  (month === 1?year-1:year)  : dates.length - 1 === idx && nextMonthStart > day ? (month === 12 ? year+1 : year)  : year ,idx === 0 && day >= lastMonthStart ?  (month === 1?13:month) -1 : dates.length - 1 === idx && nextMonthStart > day ? (month === 12?0:month) + 1 : month, day , dataList, $event)"
										v-on:onmouse="itemaddmouseover(this)" style="cursor: pointer;">
										<div v-for="item in dataList" style="width: 100%;"
											v-if="parseInt(item.TSK_BGNG_DT_MON) === (idx === 0 && day >= lastMonthStart ?  (month === 1?13:month) -1 : dates.length - 1 === idx && nextMonthStart > day ? (month === 12?0:month) + 1 : month) && parseInt(item.TSK_BGNG_DT_DD) === day ">
											{{item.TSK_TY_CD_NM}} {{item.TSK_SJ}}</div>
									</td>
								</tr>
							</template>
						</tbody>
					</table>

				</template>
			</div>

			<%-- <jsp:include page="/WEB-INF/jsp/kcg/_include/system/footer.jsp"
				flush="false" /> --%>
		</div>
	</div>
	<!-- 일별일정 팝업 -->
	<div class="modal fade" id="pop_info_day">
		<template>
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true" id="btn_popClose">&times;</button>
						<h4 class="modal-title" id="modify_nm">{{info.year}}년
							{{info.mon}}월 {{info.day}}일 일별 일정</h4>
					</div>
					<div class="modal-body">
						<div class="schedule-list">
							<template v-if="info.dataList.length">
								<div v-for="item in info.dataList" class="schedule-item"
									@click.stop="itemviewclick(info.year, info.mon, info.day)">
									<span class="time">{{parseInt(item.TSK_BGNG_DT_HH)}}시
										{{parseInt(item.TSK_BGNG_DT_MM)}}분</span> <span class="task-type">{{item.TSK_TY_CD_NM}}</span>
									<span class="task-title">{{item.TSK_SJ}}</span>
								</div>
							</template>
							<template v-else>
								<div class="no-data">일정이 없습니다.</div>
							</template>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-orange btn-icon icon-right"
							@click.stop="itemaddclick(info.year, info.mon, info.day)">
							일정추가<i class="entypo-plus"></i>
						</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal" @click="popupCustClose">Close</button>
					</div>
				</div>
			</div>
		</template>
	</div>
	<!--// 일별일정 팝업 -->

	<!-- 수정/등록 팝업 -->
	<div class="modal fade" id="pop_info_add">
		<template>
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true" id="btn_popClose">&times;</button>
						<h4 class="modal-title" id="modify_nm">일정 등록</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal">
							<div class="form-group">
								<label for="TSK_SJ" class="control-label">제목</label> <input
									class="form-control" type="text" id="TSK_SJ"
									v-model="info.TSK_SJ">
							</div>
							<div class="form-group">
								<label for="TSK_TY_CD" class="control-label">업무유형</label>
								<div class="input-group">
									<select id="TSK_TY_CD" class="form-control"
										v-model="info.TSK_TY_CD">
										<option value="1">고객상담</option>
										<option value="2">직무교육</option>
										<option value="3">일반업무수행</option>
									</select> <input type="text" id="TSK_TY_CD_NM" class="form-control"
										v-model="info.TSK_TY_CD_NM">
								</div>
							</div>
							<div class="form-group">
								<label class="control-label">시작</label>
								<div class="input-group">
									<input class="form-control date-field" type="text"
										id="TSK_BGNG_DT_YEAR" v-model="info.TSK_BGNG_DT_YEAR" readonly>
									<input class="form-control date-field" type="text"
										id="TSK_BGNG_DT_MON" v-model="info.TSK_BGNG_DT_MON" readonly>
									<input class="form-control date-field" type="text"
										id="TSK_BGNG_DT_DD" v-model="info.TSK_BGNG_DT_DD" readonly>
									<select class="form-control time-select" id="TSK_BGNG_DT_HH"
										v-model="info.TSK_BGNG_DT_HH">
										<option v-for="i in 24" :value="i-1">{{ i < 10 ? '0'
											+ (i-1) : (i-1) }}</option>
									</select> <select class="form-control time-select" id="TSK_BGNG_DT_MM"
										v-model="info.TSK_BGNG_DT_MM">
										<option v-for="i in 60" :value="i-1">{{ i < 10 ? '0'
											+ (i-1) : (i-1) }}</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label">종료</label>
								<div class="input-group">
									<input class="form-control date-field" type="text"
										id="TSK_END_DT_YEAR" v-model="info.TSK_END_DT_YEAR" readonly>
									<input class="form-control date-field" type="text"
										id="TSK_END_DT_MON" v-model="info.TSK_END_DT_MON" readonly>
									<input class="form-control date-field" type="text"
										id="TSK_END_DT_DD" v-model="info.TSK_END_DT_DD" readonly>
									<select class="form-control time-select" id="TSK_END_DT_HH"
										v-model="info.TSK_END_DT_HH">
										<option v-for="i in 24" :value="i-1">{{ i < 10 ? '0'
											+ (i-1) : (i-1) }}</option>
									</select> <select class="form-control time-select" id="TSK_END_DT_MM"
										v-model="info.TSK_END_DT_MM">
										<option v-for="i in 60" :value="i-1">{{ i < 10 ? '0'
											+ (i-1) : (i-1) }}</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="TSK_CUST_NM" class="control-label">접촉고객명</label>
								<div class="input-group">
									<input class="form-control" type="text" id="TSK_CUST_NM"
										v-model="info.TSK_CUST_NM">
									<button type="button" class="btn btn-primary" @click="custInfo">검색</button>
								</div>
							</div>
							<div class="form-group">
								<label for="TSK_DTL_CN" class="control-label">일정메모</label> <input
									class="form-control" type="text" id="TSK_DTL_CN"
									v-model="info.TSK_DTL_CN">
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" @click="save()">저장</button>
						<button type="button" class="btn btn-danger" @click="del()"
							v-if="info.save_mode === 'update'">삭제</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</template>
	</div>
	<!--// 수정/등록 팝업 -->

	<!-- 고객명 팝업 -->
	<div class="modal fade" id="pop_cust_info" tabindex="-1" role="dialog"
		aria-labelledby="pop_cust_infoLabel" aria-hidden="true">
		<template>
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="pop_cust_infoLabel">고객 목록</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="table-responsive">
							<table class="table table-striped table-hover">
								<thead class="thead-light">
									<tr>
										<th class="text-center" style="width: 20%;">고객명</th>
									</tr>
								</thead>
								<tbody>
									<tr v-for="item in custList" @click="selCustItem(item.cust_nm)"
										style="cursor: pointer;">
										<td class="text-center">{{item.cust_nm}}</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</template>
	</div>
	<!-- 고객명 팝업 -->


</body>
<script>
var vueapp = new Vue({
	el : "#vueapp",
	data : {
		dataList : [],
		days: [
	        '일요일',
	        '월요일',
	        '화요일',
	        '수요일',
	        '목요일',
	        '금요일',
	        '토요일',
	      ],
	      dates: [],
	      datesmonth: [],
	      currentYear: 0,
	      currentMonth: 0,
	      year: 0,
	      month: 0,
	      lastMonthStart: 0,
	      nextMonthStart: 0,
	      today: 0,
	},
	created() { // 데이터에 접근이 가능한 첫 번째 라이프 사이클
	    const date = new Date();
	    this.year = date.getFullYear();
	    this.month = date.getMonth() + 1;
	    this.calendarData();   
    },
	mounted : function(){		
		this.getList(true);
	},
	methods : {  
		getList : function(isInit){			
			var params = {
				year: this.year,
				month: this.month,
				lastMonthStart: this.lastMonthStart,
				nextMonthStart: this.nextMonthStart,
			}
			cf_ajax("/scheduleMng/getList", params, this.getListCB);
		},
		calendarData(arg) { // 인자를 추가
		      if (arg < 0) { // -1이 들어오면 지난 달 달력으로 이동
		        this.month -= 1;
		      } else if (arg === 1) { // 1이 들어오면 다음 달 달력으로 이동
		        this.month += 1;
		      }
		      if (this.month === 0) { // 작년 12월
		        this.year -= 1;
		        this.month = 12;
		      } else if (this.month > 12) { // 내년 1월
		        this.year += 1;
		        this.month = 1;
		      }
		      const [
		        monthFirstDay,
		        monthLastDate,
		        lastMonthLastDate,
		      ] = this.getFirstDayLastDate(this.year, this.month);
		      this.dates = this.getMonthOfDays(
		        monthFirstDay,
		        monthLastDate,
		        lastMonthLastDate,
		      ); 
		      
		      this.getList(true);
		      
		      
		},
	    getFirstDayLastDate(year, month) {
	      const firstDay = new Date(year, month - 1, 1).getDay(); // 이번 달 시작 요일
	      const lastDate = new Date(year, month, 0).getDate(); // 이번 달 마지막 날짜
	      let lastYear = year;
	      let lastMonth = month - 1;
	      if (month === 1) {
	        lastMonth = 12;
	        lastYear -= 1;
	      }
	      const prevLastDate = new Date(lastYear, lastMonth, 0).getDate(); // 지난 달 마지막 날짜
	      return [firstDay, lastDate, prevLastDate];
	    },
	    getMonthOfDays(
	      monthFirstDay,
	      monthLastDate,
	      prevMonthLastDate,
	    ) {
	      let day = 1;
	      let prevDay = (prevMonthLastDate - monthFirstDay) + 1;
	      const dates = [];
	      let weekOfDays = [];
	      while (day <= monthLastDate) {
	        if (day === 1) {
	          // 1일이 어느 요일인지에 따라 테이블에 그리기 위한 지난 셀의 날짜들을 구할 필요가 있다.
	          for (let j = 0; j < monthFirstDay; j += 1) {
	            if (j === 0) this.lastMonthStart = prevDay; // 지난 달에서 제일 작은 날짜
	            weekOfDays.push(prevDay);
	            prevDay += 1;
	          }
	        }
	        weekOfDays.push(day);
	        if (weekOfDays.length === 7) {
	          // 일주일 채우면
	          dates.push(weekOfDays);
	          weekOfDays = []; // 초기화
	        }
	        day += 1;
	      }
	      const len = weekOfDays.length;
	      if (len > 0 && len < 7) {
	        for (let k = 1; k <= 7 - len; k += 1) {
	          weekOfDays.push(k);
	        }
	      }
	      if (weekOfDays.length > 0) dates.push(weekOfDays); // 남은 날짜 추가
	      this.nextMonthStart = weekOfDays[0]; // 이번 달 마지막 주에서 제일 작은 날짜
	       
	      return dates;
	    },
		getListCB : function(data){
			this.dataList = data;
			console.log(data);
		},		
		itemaddmouseover: function (obj) {
			console.log(obj);  
        	  
        }, 
		itemclick : function(year,mon,day){
			//alert("itemclick");
			pop_info_day.init(year,mon,day);
			$('#pop_info_day').modal('show');
		},  
	}, 
}); 
 
var pop_info_day = new Vue({
	el : "#pop_info_day",
	data : {
		info : {
			year: 0,
			mon: 0,
			day: 0,
			datalist: [],
		},
	},	
	methods : {
		init : function(year,mon,day){
			this.initInfo(year,mon,day);
			this.getDayList();
		},
		initInfo : function(year,mon,day){
			this.info = {};			
			this.info.year = year; 
			this.info.mon = mon;
			this.info.day = day;
			this.info.dataList = [];
		}, 
		getDayList : function(){ 
			console.log("getDayList");
			var params = {
				year : this.info.year,
				mon : this.info.mon,
				day : this.info.day,
			}
						
			cf_ajax("/scheduleMng/getDayList", params, this.getDayListCB);
		},
		getDayListCB : function(data){
			this.info.dataList = data;
			console.log("getDayListCB >>>>> " + data);
			this.$forceUpdate();
		},
		itemaddclick : function(year,mon,day){
			//alert("itemaddclick"+mon+"-"+day);
			
			$('#pop_info_day').on('hidden.bs.modal', function (e) {   
				$('#pop_info_day').off();
				//sleep(3000);						 
				const save_mode = "insert";
// 				const param = {};
// 				param.TSK_BGNG_DT_YEAR = year;
// 				param.TSK_BGNG_DT_MON = mon;
// 				param.TSK_BGNG_DT_DD = day;
				
// 				alert("year==>" + year);
// 				alert("mon==>" + mon);
// 				alert("day==>" + day);
				
// 				alert("param.TSK_BGNG_DT_YEAR==>" + param.TSK_BGNG_DT_YEAR);
// 				alert("param.TSK_BGNG_DT_MON==>" + param.TSK_BGNG_DT_MON);
// 				alert("param.TSK_BGNG_DT_DD==>" + param.TSK_BGNG_DT_DD);
				
				pop_info_add.init(save_mode, year, mon, day);
				
				$('#pop_info_add').modal('show');
			});
			$('#pop_info_day').modal('hide');
			
		},  
		itemviewclick : function(year, mon, day){			
			$('#pop_info_day').on('hidden.bs.modal', function (e) { 
				$('#pop_info_day').off();	  
				
				const save_mode = "update";				
				pop_info_add.init(save_mode, year, mon, day);
				
				$('#pop_info_add').modal('show');
			});
			$('#pop_info_day').modal('hide');
			
		},
		popupCustClose: function () {
            $('#pop_cust_info').modal('hide');
        },
	},   
}); 
    
var pop_info_add = new Vue({
	el : "#pop_info_add",
	data : {
		info : {
			TSK_SN: 0,
			TSK_TY_CD: "",
		    TSK_TY_CD_NM: "",
		    TSK_BGNG_DT_YEAR: "",
		    TSK_BGNG_DT_MON: "",
		    TSK_BGNG_DT_DD: "",
		    TSK_BGNG_DT_HH: "",
		    TSK_BGNG_DT_MM: "",
		    TSK_END_DT_YEAR: "",
		    TSK_END_DT_MON: "",
		    TSK_END_DT_DD: "",
		    TSK_END_DT_HH: "",
		    TSK_END_DT_MM: "",
		    TSK_CUST_NM: "",
		    TSK_SJ: "",
		    TSK_DTL_CN: "",
		}
	},  
	methods : { 
		init : function(save_mode, year, mon, day){
			
			this.initInfo(save_mode, year, mon, day);
			
			
			$('#pop_info_add').on('hidden.bs.modal', function (e) {  
				$('#pop_info_add').off();
				
				pop_info_day.init(year, mon, day);
				$('#pop_info_day').modal('show');
			}); 
			
			 
		},   
		initInfo : function(save_mode, year, mon, day){ 
			this.info = {
				save_mode : save_mode,
				year : year,
			    mon : mon,
			    day : day,
			}
			
			this.info.save_mode = save_mode;
// 			this.info.TSK_BGNG_DT_YEAR = year;
// 			this.info.TSK_BGNG_DT_MON = mon;
// 			this.info.TSK_BGNG_DT_DD = day;
			
			if(save_mode == "insert"){
				var mon_mon = "";
			    var day_day = "";
			
				if (mon.toString().length === 1) {
					mon_mon = '0' + mon;
				} else {
					mon_mon = mon;
				}
				
				if (day.toString().length === 1) {
					day_day = '0' + day;
				} else {
					day_day = day;
				}
				
				this.info.TSK_SN = "";
				this.info.TSK_TY_CD = "1";
				this.info.TSK_BGNG_DT_YEAR = year;
				this.info.TSK_BGNG_DT_MON = mon_mon;
				this.info.TSK_BGNG_DT_DD = day_day;
				this.info.TSK_BGNG_DT_HH = "";
				this.info.TSK_BGNG_DT_MM = "";
				this.info.TSK_END_DT_YEAR = year;
				this.info.TSK_END_DT_MON = mon_mon;
				this.info.TSK_END_DT_DD = day_day;
				this.info.TSK_END_DT_HH = ""; 
				this.info.TSK_END_DT_MM = "";
				this.info.TSK_CUST_NM = "";
				this.info.TSK_SJ = ""; 
				this.info.TSK_DTL_CN = "";
			}else if(save_mode == "update"){		
				this.getInfo(year, mon, day); 
			} 
		}, 
		getInfo : function(year, mon, day){
			var params = {
					year : year,
				    mon : mon,
				    day  : day,
			}
			cf_ajax("/scheduleMng/getInfo", params, this.getInfoCB);
		},
		getInfoCB : function(data){
			this.info.TSK_TY_CD = data.TSK_TY_CD;
			this.info.TSK_TY_CD_NM = data.TSK_TY_CD_NM;
			this.info.TSK_BGNG_DT_YEAR = data.TSK_BGNG_DT_YEAR;
			this.info.TSK_BGNG_DT_MON = data.TSK_BGNG_DT_MON;
			this.info.TSK_BGNG_DT_DD = data.TSK_BGNG_DT_DD;
			this.info.TSK_BGNG_DT_HH = data.TSK_BGNG_DT_HH;
			this.info.TSK_BGNG_DT_MM = data.TSK_BGNG_DT_MM;
			this.info.TSK_END_DT_YEAR = data.TSK_BGNG_DT_YEAR;
			this.info.TSK_END_DT_MON = data.TSK_END_DT_MON;
			this.info.TSK_END_DT_DD = data.TSK_END_DT_DD;
			this.info.TSK_END_DT_HH = data.TSK_END_DT_HH;
			this.info.TSK_END_DT_MM = data.TSK_END_DT_MM;
			this.info.TSK_CUST_NM = data.TSK_CUST_NM;
			this.info.TSK_SJ = data.TSK_SJ;
			this.info.TSK_DTL_CN = data.TSK_DTL_CN;
			this.info.TSK_SN     = data.TSK_SN;
			this.$forceUpdate();
		},
		save : function(){
			if(cf_isEmpty(this.info.TSK_SJ)){
				alert("제목을 입력하여 주십시오");
				return;
			}
			if(cf_isEmpty(this.info.TSK_TY_CD)){
				alert("업무유형을 선택하여 주십시오.");
				return;
			}
			if(cf_isEmpty(this.info.TSK_BGNG_DT_HH) || cf_isEmpty(this.info.TSK_BGNG_DT_MM)){
				alert("일정시작시간이 올바르지 않습니다.");
				return;
			}
			
			if(cf_isEmpty(this.info.TSK_END_DT_HH) || cf_isEmpty(this.info.TSK_END_DT_MM)){
				alert("일정종료시간이 올바르지 않습니다.");
				return;
			}
			
			if(parseInt(this.info.TSK_BGNG_DT_HH + this.info.TSK_BGNG_DT_MM) >= parseInt(this.info.TSK_END_DT_HH + this.info.TSK_END_DT_MM)){				
				alert("일정종료시간이 시작시간보다 빠릅니다.");
				return;
			}
			
			if(cf_isEmpty(this.info.TSK_CUST_NM)){
				alert("접촉고객을 입력하여 주십시오.");
				return;
			}
			
			if(!confirm("저장하시겠습니까?")) return;
			
			/*  this.info.TSK_BGNG_DT_HH = this.padZero(this.info.TSK_BGNG_DT_HH);
			 this.info.TSK_BGNG_DT_MM = this.padZero(this.info.TSK_BGNG_DT_MM);
			 this.info.TSK_END_DT_HH = this.padZero(this.info.TSK_END_DT_HH);
			 this.info.TSK_END_DT_MM = this.padZero(this.info.TSK_END_DT_MM); */
			
			cf_ajax("/scheduleMng/save", this.info, this.saveCB);
			
		}, 
		
		padZero: function(value) {
		    return value.toString().padStart(2, '0');
		},
	
		saveCB : function(data){			
			if (data.status == "OK") {
				alert("활동정보 입력 완료");
			}
			vueapp.getList(true);
			$("#pop_info_add #btn_popClose").click();
		},
		custInfo: function() {
			cust_nm = this.info.TSK_CUST_NM;
			pop_cust_info.init(cust_nm);
			$('#pop_cust_info').modal('show');
		},
		gotoDtl: function (cust_nm) {
			this.info.TSK_CUST_NM = cust_nm;
			this.$forceUpdate();
		},
		del : function(){
			var params = {
					TSK_SN : this.info.TSK_SN,
				}
			if(!confirm("일정을 삭제하시겠습니까?")) return;
			cf_ajax("/scheduleMng/delete", params, this.delCB); 
		},
		delCB : function(data){
			alert("활동정보 삭제 완료");
			vueapp.getList(true);
			$("#pop_info_add #btn_popClose").click();
		}
			
	}
});

var pop_cust_info = new Vue({
	el: "#pop_cust_info",
	data: {
		custList: [],
	},
	methods: {
		init: function (cust_nm) {
			this.getCustInfo(cust_nm);
		},
		getCustInfo: function (cust_nm) {
			this.custList = [];
			var params = {
				cust_nm: cust_nm,
			}

			cf_ajax("/scheduleMng/getCustInfo", params, function (data) {
				pop_cust_info.custList = data;
			});
		},
		selCustItem: function (cust_nm) {

			$('#pop_cust_info').hide();
			pop_info_add.gotoDtl(cust_nm);;
		},
	},
});

</script>
</html>