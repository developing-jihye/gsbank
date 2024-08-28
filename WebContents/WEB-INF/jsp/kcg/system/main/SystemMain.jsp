<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.ArrayList"  %>
<%@ page import="java.util.List"  %>
<%@ page import="common.utils.common.CmmnMap"  %>
<%@ page import="common.utils.json.JsonUtil"  %>
<%
	CmmnMap statData = (CmmnMap) request.getAttribute("statData");
	String today = statData.getString("today");
	

	CmmnMap visitStat = statData.getCmmnMap("visitStat");
	String visitChart_title = visitStat.getString("title");
	List<CmmnMap> visitChart_dataList = visitStat.getCmmnMapList("dataList");
	List<String> visitChart_labels = new ArrayList<String>();
	List<Integer> visitChart_datasets_data = new ArrayList<Integer>();
	for(CmmnMap map : visitChart_dataList){
		visitChart_labels.add(map.getString("mmdd_date"));
		visitChart_datasets_data.add(map.getInt("visit_cnt"));
	}
	String jsn_visitChart_labels = JsonUtil.toJsonStr(visitChart_labels);
	String jsn_visitChart_datasets_data = JsonUtil.toJsonStr(visitChart_datasets_data);
	
	
	CmmnMap reqStat = statData.getCmmnMap("reqStat");
	List<Integer> reqChart_datasets_data = new ArrayList<>();
	reqChart_datasets_data.add(reqStat.getInt("req_anal_tool_cnt"));
	reqChart_datasets_data.add(reqStat.getInt("req_data_anal_cnt"));
	reqChart_datasets_data.add(reqStat.getInt("req_data_collect_cnt"));
	reqChart_datasets_data.add(reqStat.getInt("req_dnld_cnt"));
	String jsn_reqChart_datasets_data = JsonUtil.toJsonStr(reqChart_datasets_data);
	
%>
<!DOCTYPE html>
<html>
<head>
	<!-- 헤더META-->
	<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp" flush="false"/>

	<script src="/static_resources/lib/Chart.js/2.9.4/Chart.min.js"></script>
	
	<script src="/static_resources/system/js/bootstrap-datepicker.js"></script>
	<script src="/static_resources/system/js/bootstrap-datepicker.ko.js"></script>

	<!-- 현재 위치 받아오기 -->
	<script src="/static_resources/js/hnpTest.js"></script>
	<style>
	body{

	}
	
	</style>
	
	<title>관리자시스템 | Dashboard</title>
</head>
<body class="page-body" data-url="http://neon.dev">

<div class="page-container" class="main-content" style = "background-image:url('/static_resources/system/images/main_board.jpg');
								  background-size:cover;
								  size:container;
								  background-position:center;
								  repeat:no-repeat"><!-- add class "sidebar-collapsed" to close sidebar by default, "chat-visible" to make chat appear always -->

	<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp" flush="false"/>

	<div style= "opacity:0.9">

		<!-- 헤더 -->
		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp" flush="false"/>
		
		<ol class="breadcrumb bc-3">
			<li><a href="#none" onclick="cf_movePage('/system')"><i class="fa fa-home"></i>Home</a></li>
			<li class="active"><strong>대시보드</strong></li>
		</ol>
	
		<h2>대시보드</h2>
		

		<br/>
		
		<div class="row">
			<div class="col-sm-6">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<div class="panel-title">
							<label class="control-label" style="font-size: 40px;">최근 10일간 접속통계</label>
						</div>
					</div>
					<div class="panel-body">
						<div style="height: 300px">
							<canvas id="visitChart" style="width:100%; height:100%;"></canvas>
							<script>
							var ctx = document.getElementById('visitChart').getContext('2d');
							var visitChart = new Chart(ctx, {
							    type: 'bar',
							    data: {
							        labels: <%=jsn_visitChart_labels%>,
							        datasets: [{
							            label: '<%=visitChart_title%>',
							            data: <%=jsn_visitChart_datasets_data%>,
							            borderWidth: 1
							        }]
							    },
							    options: {
							        scales: {
							            y: {
							                beginAtZero: true
							            }
							        },
							        legend: {
							            display: false
							        },
							    }
							});
							</script>
						</div>
					</div>
				</div>
			</div>

		<div class="row">
			<div class="col-sm-6">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<div class="panel-title">
							<label class="control-label" style="font-size: 40px;">기상청 날씨 정보(제거)</label>
						</div>
					</div>

 <!-- 기상청 API 받아옴 -->
	<div class = "MeteorologicalAdministration">
		<div id="weatherInfo">
        <p><strong>날짜:</strong> <span id="dateElement"></span></p>
        <p><strong>시간:</strong> <span id="timeElement"></span></p>
        <p><strong>날씨:</strong> <span id="weatherElement"></span></p>
        <p><strong>온도:</strong> <span id="temperaturesElement"></span></p>
        <p><strong>습도:</strong> <span id="humidityElement"></span></p>
    </div>
	</div>
<!-- 기상청 API 받아옴 종료-->
</div>
</body>

				<div class="MeteorologicalAdministration">
					<a href="#gm" onclick="cf_movePage('/system')">
						<img src="/static_resources/system/images/img_title.png" width="800" alt="" />
					</a>
				</div>


</html>