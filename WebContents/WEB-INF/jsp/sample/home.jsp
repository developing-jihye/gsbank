<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테스트 페이지</title>
</head>

<!-- 제이쿼리 사용 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script src="/static_resources/lib/vue/2.6.12/vue.min.js?rscVer=${properties.rscVer}"></script> <script src="/static_resources/lib/babel-polyfill/7.4.4/polyfill.min.js?rscVer=${properties.rscVer}"></script>
    <script src="/static_resources/lib/axios/0.21.0/axios.min.js?rscVer=${properties.rscVer}"></script>
    <script src="/static_resources/js/commonLib.js?rscVer=${properties.rscVer}"></script>
    <script src="/static_resources/js/prototype_polyfill.js?rscVer=${properties.rscVer}"></script>
    
    <script src="/static_resources/lib/vue/2.6.12/vue.min.js"></script>
    
<body> 
 <MARQUEE>${userNm} 환영해용.K-디지털트레이닝 GSITM 부트캠프 금융Project 참여를 환영해용.</MARQUEE>


<!--  <div id="mvcSample">

            <input type="text" id="inputVl1" name="inputVl1" required><br>
            <input type="text" id="inputVl2" name="inputVl2" required><br>
            <input type="text" id="inputVl3" name="inputVl3" required><br>
           
<button @click="sendData()"> 보내기 </button>

</div>
 -->
 <div id="mvcdSample">
<h6> 강아지</h6>
            <input type="text" id="inputVl1" name="inputVl1" required><br>
          
           
<button @click="sendData()"> 보내기 </button>

</div>
      
        
     
        <script>
        function sendSms() {
        alert("enter");
        }
       
        </script>
        
            <script>
                new Vue({
                    el: '#mvcdSample', 
                    data: {
                        message: 'Hello, Vue!',
                    },
                    mounted: function () { 
                    
                    },
                    methods: {
                    sendData(){
                    
                alert("Send");
                
                  var inputVl1 = document.getElementById("inputVl1").value;
                  var inputVl2 = document.getElementById("inputVl2").value;
                  var inputVl3 = document.getElementById("inputVl3").value;
                  
                var params = {
                inputVl1: inputVl1,
                inputVl2: inputVl2,
                inputVl3: inputVl3
                }
                
                cf_movePage("/sample/sampleMovePage",params);
                    }
                }
            });
            </script>
        
</body>
</html>