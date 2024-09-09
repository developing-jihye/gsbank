<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="common.utils.common.CmmnMap"%>
<%@ page import="common.utils.json.JsonUtil"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="org.json.JSONObject"%>

<%
// ageDistr 데이터를 JSON 형식으로 변환
List<CmmnMap> ageDistr = (List<CmmnMap>) request.getAttribute("ageDistr");
JSONArray ageJsonArray = new JSONArray();

for (CmmnMap ageData : ageDistr) {
	JSONObject ageJson = new JSONObject();
	ageJson.put("ageGroup", ageData.get("ageGroup"));
	ageJson.put("count", ageData.get("count"));
	ageJsonArray.put(ageJson);
}

// genderDistr 데이터 변환
List<CmmnMap> genderDistr = (List<CmmnMap>) request.getAttribute("genderDistr");
JSONArray genderJsonArray = new JSONArray();

for (CmmnMap genderData : genderDistr) {
	JSONObject genderJson = new JSONObject();
	genderJson.put("gender", genderData.get("gender"));
	genderJson.put("count", genderData.get("count"));
	genderJsonArray.put(genderJson);
}

//jobDistr 데이터 변환
List<CmmnMap> jobDistr = (List<CmmnMap>) request.getAttribute("jobDistr");
JSONArray jobJsonArray = new JSONArray();

for (CmmnMap jobData : jobDistr) {
	JSONObject jobJson = new JSONObject();
	jobJson.put("code_nm", jobData.get("code_nm"));
	jobJson.put("count", jobData.get("count"));
	jobJsonArray.put(jobJson);
}

//mySales 데이터 변환
List<CmmnMap> mySales = (List<CmmnMap>) request.getAttribute("mySales");
JSONArray mySalesJsonArray = new JSONArray();

for (CmmnMap mySalesData : mySales) {
	JSONObject mySalesJson = new JSONObject();
	mySalesJson.put("enrl_dt", mySalesData.get("enrl_dt"));
	mySalesJson.put("sales_count", mySalesData.get("sales_count"));
	mySalesJsonArray.put(mySalesJson);
}

//popSavings 데이터 변환
List<CmmnMap> popSavings = (List<CmmnMap>) request.getAttribute("popSavings");
JSONArray popSavingsJsonArray = new JSONArray();

for (CmmnMap popSavingsData : popSavings) {
	JSONObject popSavingsJson = new JSONObject();
	popSavingsJson.put("prod_nm", popSavingsData.get("prod_nm"));
	popSavingsJson.put("total_sales", popSavingsData.get("total_sales"));
	popSavingsJsonArray.put(popSavingsJson);
}

//popDeposit 데이터 변환
List<CmmnMap> popDeposit = (List<CmmnMap>) request.getAttribute("popDeposit");
JSONArray popDepositJsonArray = new JSONArray();

for (CmmnMap popDepositData : popDeposit) {
	JSONObject popDepositJson = new JSONObject();
	popDepositJson.put("prod_nm", popDepositData.get("prod_nm"));
	popDepositJson.put("total_sales", popDepositData.get("total_sales"));
	popDepositJsonArray.put(popDepositJson);
}

//popLoan 데이터 변환
List<CmmnMap> popLoan = (List<CmmnMap>) request.getAttribute("popLoan");
JSONArray popLoanJsonArray = new JSONArray();

for (CmmnMap popLoanData : popLoan) {
	JSONObject popLoanJson = new JSONObject();
	popLoanJson.put("prod_nm", popLoanData.get("prod_nm"));
	popLoanJson.put("total_sales", popLoanData.get("total_sales"));
	popLoanJsonArray.put(popLoanJson);
}
%>



<!DOCTYPE html>
<html>
<head>
<!-- 헤더META-->
<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp"
	flush="false" />

<script src="/static_resources/lib/Chart.js/2.9.4/Chart.min.js"></script>
<script src="/static_resources/system/js/bootstrap-datepicker.js"></script>
<script src="/static_resources/system/js/bootstrap-datepicker.ko.js"></script>

<!-- 스타일 시트 -->
<link rel="stylesheet" href="/static_resources/system/css/systemMain.css" />

<!-- chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>

<!-- 웹소켓 -->
<script
	src="https://cdn.jsdelivr.net/npm/@stomp/stompjs@7.0.0/bundles/stomp.umd.min.js"></script>

<title>관리자시스템 | Dashboard</title>
</head>
<body class="page-body" data-url="http://neon.dev">

	<div class="page-container" class="main-content">
		<!-- add class "sidebar-collapsed" to close sidebar by default, "chat-visible" to make chat appear always -->

		<!-- 사이드바 -->
		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp"
			flush="false" />

		<!-- 헤더 -->
		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp"
			flush="false" />

		<!-- 메인 -->
		<main>
			<!-- 좌측 -->
			<div class="personal-side">
				<div class="my-customers small">
					<h1 class="title">담당 고객 분석</h1>
					<div class="cus-gender">
						<h2 class="subtitle">성별 분포</h2>
						<div>
							<canvas id="myCusGender"></canvas>
						</div>

						<script>
						// 브랜드 색상
						const brandColors = ['rgb(0, 51, 102)', 'rgb(0, 51, 102, 0.3)', 'rgb(0, 115, 230)', 'rgb(0, 115, 230, 0.3)', '#FF9900', '#66CC66'];
						const generateBrandColors = (count) => {
							  const colors = [];
							  for (let i = 0; i < count; i++) {
							    colors.push(brandColors[i % brandColors.length]);
							  }
							  return colors;
							};
						
								// JSP에서 생성된 JSON 데이터를 JavaScript 변수에 할당
						    	const genderDistrData = <%=genderJsonArray.toString()%>;
						    	console.log("Gender Distribution Data:", genderDistrData);

						    	// 차트 생성 시 데이터를 genderDistrData로 대체
								const ct_gender = document.getElementById('myCusGender');

								new Chart(ct_gender, {
									type : 'doughnut',
									data : {
										label: "인원 수: ",
										labels : [ '남성', '여성' ],
										datasets : [ {
											label: "고객 수: ",
											data : genderDistrData.map(item => item.count),
											borderWidth : 1,
											backgroundColor: generateBrandColors(genderDistrData.length)
										} ]
									},
									options: {
							            plugins: {
							            	legend: {
							            		display: false
							            	},
							                datalabels: {
							                    color: '#fff',
							                    formatter: (value, context) => {
							                        return context.chart.data.labels[context.dataIndex];
							                    },
							                    font: {
							                        weight: 'bold',
							                        size: 10
							                    }
							                }
							            }
							        },
							        plugins: [ChartDataLabels]
							    });
							</script>

					</div>
					<div class="cus-age">
						<h2 class="subtitle">연령 분포</h2>
						<div class="graph">
							<canvas id="myCusAge"></canvas>
						</div>

						<script>
							// JSP에서 생성된 JSON 데이터를 JavaScript 변수에 할당
					    	const ageDistrData = <%=ageJsonArray.toString()%>;
					    	console.log("Age Distribution Data:", ageDistrData);

					    	// 차트 생성 시 데이터를 ageDistrData로 대체
							const ct_age = document.getElementById('myCusAge');

						    new Chart(ct_age, {
						        type: 'doughnut',
						        data: {
						            labels: ['20대', '30대', '40대', '50대', '60대', '기타'],
						            datasets: [{
						            	label: "고객 수: ",
						                data: ageDistrData.map(item => item.count),
						                borderWidth: 1,
						                backgroundColor: generateBrandColors(ageDistrData.length)
						            }]
						        },
						        options: {
						            plugins: {
						            	legend: {
						            		display: false
						            	},
						                datalabels: {
						                    color: '#fff',
						                    formatter: (value, context) => {
						                        return context.chart.data.labels[context.dataIndex];
						                    },
						                    font: {
						                        weight: 'bold',
						                        size: 10
						                    }
						                }
						            }
						        },
						        plugins: [ChartDataLabels]
						    });

						</script>

					</div>
					<div class="cus-job">
						<h2 class="subtitle">직업군 분포</h2>
						<div>
							<canvas id="myCusJob"></canvas>
						</div>

						<script>
							// JSP에서 생성된 JSON 데이터를 JavaScript 변수에 할당
					    	const jobDistrData = <%=jobJsonArray.toString()%>;
					    	console.log("Job Distribution Data:", jobDistrData);

					    	// 차트 생성 시 데이터를 genderDistrData로 대체
							const ct_job = document.getElementById('myCusJob');

							new Chart(ct_job, {
								type : 'doughnut',
								data : {
									labels : jobDistrData.map(item => item.code_nm),
									datasets : [ {
										label: "고객 수: ",
										data : jobDistrData.map(item => item.count),
										borderWidth : 1,
										backgroundColor: generateBrandColors(jobDistrData.length)
									} ]
								},
								options: {
						            plugins: {
						            	legend: {
						            		display: false
						            	},
						                datalabels: {
						                    color: '#fff',
						                    formatter: (value, context) => {
						                        return context.chart.data.labels[context.dataIndex];
						                    },
						                    font: {
						                        weight: 'bold',
						                        size: 10
						                    }
						                }
						            }
						        },
						        plugins: [ChartDataLabels]
						    });
						</script>
					</div>
				</div>
			</div>
			<!-- 메인 -->
			<div class="main-side">
				<div class="my-sales">
					<h1 class="title">나의 판매 현황</h1>
					<div class="chart">
						<canvas id="myChart"></canvas>
					</div>
					<script>
							// JSP에서 생성된 JSON 데이터를 JavaScript 변수에 할당
				    		const mySalesData = <%=mySalesJsonArray.toString()%>;
				    		console.log("My Sales Data:", mySalesData);
				    	
					        const ctx = document.getElementById('myChart');
					        ctx.height = 280;
					

					        new Chart(ctx, {
					            type: 'line',
					            data: {
					                labels: mySalesData.map(item => item.enrl_dt),
					                datasets: [{
					                    label: '판매량: ',
					                    data: mySalesData.map(item => item.sales_count),
					                    borderColor: 'rgb(0, 115, 230)',
					                    backgroundColor: 'rgb(0, 115, 230, 0.3)',
					                    borderWidth: 3,
					                    fill: true
					                }]
					            },
					            options: {
					                scales: {
					                    y: {
					                        beginAtZero: false
					                    }
					                },
					                responsive: true,
					                plugins: {
					                    legend: {
					                        display: false
					                    }
					                }
					            }
					        });
				    </script>
				</div>


				<div class="sales-monitor">
					<h1 class="title">실시간 인기 상품</h1>
					<!-- 탭 영역 -->
					<div class="tabs">
						<button class="tab-button active"
							onclick="showTabContent('savings')">적금</button>
						<button class="tab-button" onclick="showTabContent('deposit')">
							예금</button>
						<button class="tab-button" onclick="showTabContent('loan')">
							대출</button>
					</div>
					<!-- 콘텐츠 영역 -->
					<div class="tab-content" id="savings">
						<div class="chart savings">
							<canvas id="popSavings"></canvas>
						</div>

						<script>
							// JSP에서 생성된 JSON 데이터를 JavaScript 변수에 할당
					    	const popSavingsData = <%=popSavingsJsonArray.toString()%>;
					    	console.log("인기 적금 상품:", popSavingsData);

					    	// 차트 생성 시 데이터를 ageDistrData로 대체
							const ct_savings = document.getElementById('popSavings');
							ct_savings.style.width = '980px';
							ct_savings.style.height = '300px';
							
						    new Chart(ct_savings, {
						        type: 'bar',
						        data: {
						            labels: popSavingsData.map(item => item.prod_nm),
						            datasets: [{
						            	label: "판매량: ",
						                data: popSavingsData.map(item => item.total_sales),
						                backgroundColor: 'rgb(0, 115, 230, 0.3)',
						                borderWidth: 0,
						                barThickness: 'flex' 
						            }]
						        },
						        options: {
						        	scales: {
						                x: {
						                    ticks: {
						                        autoSkip: false // 모든 라벨 표시
						                    }
						                },
						                y: {
						                    beginAtZero: true
						                }
						            },
						            plugins: {
						            	legend: {
						            		display: false
						            	}
						            }
						        },
						        plugins: [ChartDataLabels]
						    });
						</script>
					</div>
					<div class="tab-content" id="deposit" style="display: none">
						<div class="chart deposit">
							<canvas id="popDeposit"></canvas>
						</div>

						<script>
							// JSP에서 생성된 JSON 데이터를 JavaScript 변수에 할당
					    	const popDepositData = <%=popDepositJsonArray.toString()%>;
					    	console.log("인기 예금 상품:", popDepositData);

					    	// 차트 생성 시 데이터를 ageDistrData로 대체
							const ct_deposit = document.getElementById('popDeposit');
							ct_deposit.style.width = '980px';
							ct_deposit.style.height = '300px';

						    new Chart(ct_deposit, {
						        type: 'bar',
						        data: {
						            labels: popDepositData.map(item => item.prod_nm),
						            datasets: [{
						            	label: "고객 수: ",
						                data: popDepositData.map(item => item.total_sales),
						                backgroundColor: 'rgb(0, 115, 230, 0.3)',
						                borderWidth: 0,
						                barThickness: 'flex' 
						            }]
						        },
						        options: {
						        	scales: {
						                x: {
						                    ticks: {
						                        autoSkip: false // 모든 라벨 표시
						                    }
						                },
						                y: {
						                    beginAtZero: true
						                }
						            },
						            plugins: {
						            	legend: {
						            		display: false
						            	}
						            }
						        },
						        plugins: [ChartDataLabels]
						    });
						</script>
					</div>
					<div class="tab-content" id="loan" style="display: none">
						<div class="chart loan">
							<canvas id="popLoan"></canvas>
						</div>

						<script>
							// JSP에서 생성된 JSON 데이터를 JavaScript 변수에 할당
					    	const popLoanData = <%=popLoanJsonArray.toString()%>;
					    	console.log("인기 대출 상품:", ageDistrData);

					    	// 차트 생성 시 데이터를 ageDistrData로 대체
							const ct_loan = document.getElementById('popLoan');
							ct_loan.style.width = '980px';
							ct_loan.style.height = '300px';

						    new Chart(ct_loan, {
						        type: 'bar',
						        data: {
						            labels: popLoanData.map(item => item.prod_nm),
						            datasets: [{
						            	label: "고객 수: ",
						                data: popLoanData.map(item => item.total_sales),
						                backgroundColor: 'rgb(0, 115, 230, 0.3)',
						                borderWidth: 0,
						                barThickness: 'flex' 
						            }]
						        },
						        options: {
						        	scales: {
						                x: {
						                    ticks: {
						                        autoSkip: false // 모든 라벨 표시
						                    }
						                },
						                y: {
						                    beginAtZero: true
						                }
						            },
						            plugins: {
						            	legend: {
						            		display: false
						            	}
						            }
						        },
						        plugins: [ChartDataLabels]
						    });
						</script>
					</div>
				</div>
			</div>
			<!-- 우측 -->
			<div class="companion-side">
				<div class="best-marketer small">
					<h1 class="title">이달의 마케터</h1>
					<div class="person">
						<p class="rank">1위</p>
						<img
							src="${bestMarketer[0].profile_image}"
							alt="프로필 사진" />
						<div class="person-info">
							<p class="name">${bestMarketer[0].marketer_name}</p>
							<p class="sales">당월 누적 판매
								${bestMarketer[0].total_sales_count} 건</p>
						</div>
					</div>
					<div class="person">
						<p class="rank">2위</p>
						<img
							src="${bestMarketer[1].profile_image}"
							alt="프로필 사진" />
						<div class="person-info">
							<p class="name">${bestMarketer[1].marketer_name}</p>
							<p class="sales">당월 누적 판매
								${bestMarketer[1].total_sales_count} 건</p>
						</div>
					</div>
					<div class="person">
						<p class="rank">3위</p>
						<img
							src="${bestMarketer[2].profile_image}"
							alt="프로필 사진" />
						<div class="person-info">
							<p class="name">${bestMarketer[2].marketer_name}</p>
							<p class="sales">당월 누적 판매
								${bestMarketer[2].total_sales_count} 건</p>
						</div>
					</div>
				</div>
				<div class="chat-wrap">
					<h1 class="title">실시간 채팅</h1>
					<div class="chatting-room small">
						<div class="chat">
							<img
								src="https://i.namu.wiki/i/M0j6sykCciGaZJ8yW0CMumUigNAFS8Z-dJA9h_GKYSmqqYSQyqJq8D8xSg3qAz2htlsPQfyHZZMmAbPV-Ml9UA.webp"
								alt="글쓴이 프로필 사진" />
							<div class="chat-info">
								<span class="name">GS Bank</span> <span class="chattedAt"></span>
								<p class="message">
									안녕하세요, GS Bank 팀 여러분!<br /> <br /> 올 한 해 동안 여러분의 노고와 열정에 진심으로
									감사드립니다. 고객과의 소통을 통해 GS Bank의 가치를 더욱 빛내주신 여러분 덕분에 많은 성과를 이룰 수
									있었습니다. <br /> <br /> 이번 추석, 가족과 함께 따뜻하고 풍요로운 시간을 보내시길 바랍니다. <br />
									<br /> 앞으로도 함께 성장하고 발전하는 GS Bank이 되기를 기대합니다. 행복한 추석 되세요! 🏮🌾
								</p>
							</div>
						</div>

						<!-- 메시지 입력 창 및 전송 버튼 -->
						<div class="chat-input">
							<input type="text" id="messageInput" placeholder="메시지를 입력하세요..." />
							<button onclick="sendMessage()">전송</button>
						</div>
					</div>
				</div>

			</div>
		</main>

		<script>
			// 탭 콘텐츠 표시 함수
			function showTabContent(tabName) {
				var contents = document.getElementsByClassName("tab-content");
				for (var i = 0; i < contents.length; i++) {
					contents[i].style.display = "none";
				}

				var tabs = document.getElementsByClassName("tab-button");
				for (var i = 0; i < tabs.length; i++) {
					tabs[i].classList.remove("active");
				}

				document.getElementById(tabName).style.display = "block";
				event.currentTarget.classList.add("active");
			}

			// 웹소켓
			const stompClient = new StompJs.Client({
			    brokerURL: 'ws://localhost:8080/live-chat'
			});
			
			stompClient.onConnect = (frame) => {
			    console.log('Connected: ' + frame);
			    // 구독
			    stompClient.subscribe('/topic/chatted', (wsMessage) => {
			    	showMessage(JSON.parse(wsMessage.body));
			    });
			};
			
			stompClient.activate();
			
			// 메시지 전송 함수
			function sendMessage() {
				var userName = "${userName}";
				var profileImage = "${profileImage}";
				
				var input = document.getElementById("messageInput").value;
				
				stompClient.publish({
					destination: "/app/hello",
					body: JSON.stringify({'message': input, "name": userName, "profileImage": profileImage})
				});
			}
			
			// 메시지 화면 출력 함수
			function showMessage(chat) {
				if (chat !== "") {
					var chatRoom = document.querySelector(".chatting-room");
					var newChat = document.createElement("div");
					newChat.className = "chat";
					newChat.innerHTML = '<img src="' + chat.profileImage + '" alt="프로필사진" />'
							+ '<div class="chat-info">'
							+ '<span class="name">' + chat.name + '</span>'
							+ '<span class="chattedAt">' + chat.time + '</span>'
							+ '<p class="message">'
							+ chat.message
							+ "</p>"
							+ "</div>";
					chatRoom.insertBefore(newChat, chatRoom.lastElementChild);
					scrollToBottom(); // 메시지 전송 후 스크롤을 맨 아래로 이동
				}
			}

			// 채팅창 스크롤을 맨 아래로 이동시키는 함수
			function scrollToBottom() {
				var chatRoom = document.querySelector(".chatting-room");
				chatRoom.scrollTop = chatRoom.scrollHeight;
			}
			// 페이지 로드 시 실행되는 코드
			window.onload = function() {
				scrollToBottom();
			}
			
		</script>

	</div>
</body>


</html>