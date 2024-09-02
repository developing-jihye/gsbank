<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<!-- 제이쿼리 사용 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script src="/static_resources/lib/vue/2.6.12/vue.min.js?rscVer=${properties.rscVer}"></script> <script src="/static_resources/lib/babel-polyfill/7.4.4/polyfill.min.js?rscVer=${properties.rscVer}"></script>
    <script src="/static_resources/lib/axios/0.21.0/axios.min.js?rscVer=${properties.rscVer}"></script>
    <script src="/static_resources/js/commonLib.js?rscVer=${properties.rscVer}"></script>
    <script src="/static_resources/js/prototype_polyfill.js?rscVer=${properties.rscVer}"></script>
    
    <script src="/static_resources/lib/vue/2.6.12/vue.min.js"></script>


<body>

    <h2>페이지 이동</h2>
    <div>{{statData}}</div>
    <p>Parameter Value: ${statData}</p>
    <c:out value="${statData}" />

<div>{{col1}}</div>
<p>Parameter Value: ${col1}</p>
<c:out value="${col1}"/>
<div>{{col2}}</div>
<p>Parameter Value: ${col2}</p>
<c:out value="${col2}"/>
<div>{{col3}}</div>
<p>Parameter Value: ${col3}</p>
<c:out value="${col3}"/>

</body>


</html>l>