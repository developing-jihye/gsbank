	// 메인화면 이동
	function goMainPage() {
		console.log("메인화면으로 이동");
		location.href = "/login"
	}

	
	// 입력창 초기화
	function cleanRegistForm() {

		 if(confirm("입력하신 정보가 초기화 됩니다."))
		 {
				console.log("clean form");
				$("#userForm")[0].reset();
		 }
		 else
		 {

		 }

	}

	// 등록
	function userRegistProc() {
		console.log("회원정보 등록");
		location.href = "/login/userRegistProc"
	}

	
	// 입사일자 담기
	function setValueJncmpYmd() {

		var jncmpYmd = document.getElementById("jncmpYmd_date").value;
		// document.getElementById('jncmpYmd').value = jncmpYmd.toISOString().substring(0, 10)
	    // console.log(jncmpYmd);
	    $('#jncmpYmd').attr('value', jncmpYmd);
	}
	
	// 히든인풋에 부서명 기입
	function setValueDeptNm() {
		// console.log($("#deptNmValue option:selected").val());
	    $('#deptNm').attr('value', $("#deptNmValue option:selected").val());
	}
	

	// 히든인풋에 직위명 기입
	function setValueJbpsNm() {
		console.log($("#jbpsTyCd option:selected").val());
	    $('#jbpsNm').attr('value', $("#jbpsTyCd option:selected").val());
	}

	
	// 테스트를 위한 값 세팅
	function setValue() {
		$('#picNm').attr('value', "테스터박");

		$('#jbpsNm').attr('value', "사원");
		$('#picMblTelno').attr('value', "01012341234");
		$('#picEmlAddr').attr('value', "testPark@naver.com");

		$('#etcTskCn').attr('value', "기타 내용");
		$('#userPswd').attr('value', "1q2w3e4r@");
		$('#pswdVlConfirm').attr('value', "1q2w3e4r@");

		
	}
	/*
	// 비밀번호 확인
	function confirmPswdVl() {

		var pw1	= document.getElementById("userPswd").value;
		var pw2 = document.getElementById("pswdVlConfirm").value;
		
		var num = pw1.search(/[0-9]/g);
		var eng = pw1.search(/[a-z]/ig);
		var spe = pw1.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
		
		 if(pw1.length < 8 || pw1.length > 20){
		
		  // alert("8자리 ~ 20자리 이내로 입력해주세요.");
		  
		  var dynamicString = "8자리 ~ 20자리 이내로 입력해주세요.";
	        var dynamicContentDiv = document.getElementById("dynamicContent");
	        dynamicContentDiv.innerHTML = dynamicString;
	        dynamicContentDiv.style.color = "red";

		  
		 }else if(pw1.search(/\s/) != -1){
			 
		  // alert("비밀번호는 공백 없이 입력해주세요.");
		   var dynamicString = "비밀번호는 공백 없이 입력해주세요.";
	        var dynamicContentDiv = document.getElementById("dynamicContent");
	        dynamicContentDiv.innerHTML = dynamicString;
	        dynamicContentDiv.style.color = "red";

		  
		 }else if(num < 0 || eng < 0 || spe < 0 ){
			 
		  // alert("영문,숫자, 특수문자를 혼합하여 입력해주세요.");
		  		   var dynamicString = "영문,숫자, 특수문자를 혼합하여 입력해주세요.";
	        var dynamicContentDiv = document.getElementById("dynamicContent");
	        dynamicContentDiv.innerHTML = dynamicString;
	        dynamicContentDiv.style.color = "red";
		  
		 }else {
			 
			console.log("유효성 검사 통과"); 
			var dynamicString = "사용 가능한 비밀번호 입니다.";
	        var dynamicContentDiv = document.getElementById("dynamicContent");
	        dynamicContentDiv.innerHTML = dynamicString;
	        dynamicContentDiv.style.color = "blue";
			
			if (pw1 == pw2) {

			var dynamicString = "비밀번호가 일치합니다.";
	        var dynamicContentDiv = document.getElementById("dynamicContent");
	        dynamicContentDiv.innerHTML = dynamicString;
	        dynamicContentDiv.style.color = "green";
			//$('#pswdVlConfirmResult').attr('value', "패스워드 일치");
			return "true";
			
		} else {

			var dynamicString = "비밀번호가 일치하지 않습니다.";
	        var dynamicContentDiv = document.getElementById("dynamicContent");
	        dynamicContentDiv.innerHTML = dynamicString;
	        dynamicContentDiv.style.color = "red";
			//$('#pswdVlConfirmResult').attr('value', "패스워드 불일치");
			return "false";
		}
		    
		 }
		
		
		

	}*/
	
	// 이메일 형식, 중복 체크
	/*
	function checkEmail() {

		var picEmlAddr = document.getElementById("picEmlAddr").value;	
		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		var checkEmailtextDiv = document.getElementById("checkEmailtext");
		
		if (picEmlAddr.match(regExp) != null) {
		    console.log('올바른 이메일 형식입니다.');
		    var emlAddrCheckState = "";
		    $.ajax({
				async: false, //값을 리턴시 해당코드를 추가하여 동기로 변경 false : 동기, true : 비동기
		        url: '/ajaxEmailcheck.do',
		        type: "GET",
		        dataType: "json", // 서버에서 보내주는 데이터를 어떤 타입으로 받을건지
		        data : {
		            picEmlAddr: picEmlAddr
		        },
		        headers: {
		            "Accept-Language": "ko-KR" // 한글을 지원하는 언어 코드로 설정
		        },
		        
		        success: function(response) {
					console.log("ajax 통신 성공");
		            console.log("서버 응답:", response.message);
		            
		            if(response.message == "not allowed") {
						emlAddrCheckState = "false";
		        		checkEmailtextDiv.innerHTML = "사용불가능한 이메일 입니다.";
		    			checkEmailtextDiv.style.color = "red";
		    			
		    			
					} else if (response.message == "allowed") {
						emlAddrCheckState = "true";	
						checkEmailtextDiv.innerHTML = "사용가능한 이메일 입니다.";
		    			checkEmailtextDiv.style.color = "green";	    
		    					
					} 	            
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
		    });		    
		    return emlAddrCheckState;
		}
		else {
			emlAddrCheckState =  "false";
			checkEmailtextDiv.innerHTML = "이메일 형식이 올바르지 않아요~";
			checkEmailtextDiv.style.color = "red";
			
			// console.log("이메일 형식이 올바르지 않아요~");
		}
		console.log("emlAddrCheckState == " + emlAddrCheckState);
		return emlAddrCheckState;
	}*/


	
	// form 데이터 보내기전 최종 검사
    function validateForm() {
    	console.log("validation check");
		/*
    	var pwsdVlCheckState = confirmPswdVl(); // 비밀번호, 비밀번호확인값 검사결과
    	var emlAddrCheckState = checkEmail(); // 이메일 유효성검사 결과
    	console.log("비밀번호 유효성 검사결과 == " + pwsdVlCheckState);
    	console.log("이메일 유효성검사 결과 == " + emlAddrCheckState);
    	
    	//const formData = new FormData();
		//formData.append('picNm', document.getElementById("picNm").value);
	
    	// 이메일 AND 비밀번호 유효성 검사 통과할 경우에만 등록
    	if (pwsdVlCheckState === "true" && emlAddrCheckState === "true") {
			alert("등록성공");
			return true;
		}
		alert("유효성 검사 실패");
        return false; //true 일경우에만 submit함
		*/
    }
    

      
	function setThumbnail(event) {
		// 기존 이미지 제거
		var imageContainer = document.querySelector("div#image_container");
		imageContainer.innerHTML = ''; // 이 부분을 변경합니다.
	
		var reader = new FileReader();
	
		reader.onload = function(event) {
			var img = document.createElement("img");
			img.setAttribute("src", event.target.result);
	
			// 이미지 크기 조절
			img.style.maxWidth = "50px"; // 'px' 추가
			img.style.maxHeight = "40px";
	
			document.querySelector("div#image_container").appendChild(img);
		};
	
		reader.readAsDataURL(event.target.files[0]);
	}