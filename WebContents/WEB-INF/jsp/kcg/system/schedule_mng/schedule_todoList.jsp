<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp"
	flush="false" />

<link rel="stylesheet"
	href="/static_resources/system/css/schedule_todoList.css">

<!-- TOAST UI Calendar 관련 CSS -->
<link rel="stylesheet"
	href="https://uicdn.toast.com/calendar/latest/toastui-calendar.min.css" />

<!-- TOAST UI DatePicker 관련 CSS -->
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />

<!-- TOAST UI TimePicker 관련 CSS -->
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.css" />
	
	 <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;700&display=swap" rel="stylesheet">
	

<!-- 의존성 스크립트 -->
<script
	src="https://uicdn.toast.com/tui.code-snippet/v1.5.2/tui-code-snippet.min.js"></script>
<script
	src="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.min.js"></script>
<script
	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.min.js"></script>

<!-- TOAST UI Calendar 스크립트 -->
<script
	src="https://uicdn.toast.com/calendar/latest/toastui-calendar.min.js"></script>
	
	

<title>스케줄 관리</title>

<style type="text/css">

/* 전체 페이지 레이아웃 */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* 캘린더 및 Todo 리스트 컨테이너 */
.calendar-container {
    display: flex;
    justify-content: space-between;
    padding: 20px;
}

#calendar {
    height: 800px;
    width: 65%;
    border: 1px solid #e5e5e5;
}

#todo-list {
    width: 30%;
    margin-left: 2%;
    border: 1px solid #e5e5e5;
    padding: 10px;
    background-color: #f6f6f6;
    border-radius: 5px;
}

#todo-list h3 {
    margin: 0 0 10px;
    font-size: 1.5em;
}

#today-date {
    font-size: 1.2em;
    font-weight: bold;
    margin-bottom: 10px;
}

#todo-items {
    list-style-type: none;
    padding: 0;
    margin: 0;
}

.todo-item {
    display: flex;
    align-items: center;
    padding: 10px;
    border-bottom: 1px solid #ddd;
    cursor: pointer;
    position: relative;
}

.todo-item:last-child {
    border-bottom: none;
}

.todo-icon {
    margin-right: 10px;
}

.todo-time {
    margin-right: 10px;
    font-weight: bold;
}

.todo-content {
    flex: 1;
}

.todo-title-container {
    display: flex;
    justify-content: space-between;
    margin-bottom: 5px;
}

.todo-title {
    font-weight: bold;
}

.todo-type {
    display: flex;
    align-items: center;
}

.todo-type-dot {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    margin-right: 5px;
}

.todo-complete {
    position: absolute;
    right: 10px;
    top: 10px;
    background-color: #009688;
    color: white;
    border: none;
    padding: 5px 10px;
    border-radius: 5px;
    cursor: pointer;
}

/* 완료된 일정 스타일 */
.todo-completed {
    background-color: #e0f2f1;
    text-decoration: line-through;
}

/* 모달 윈도우 스타일 */
.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
    background-color: #fff;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
    max-width: 600px;
    border-radius: 5px;
}

.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.close {
    color: #aaa;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
}

.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
}

.modal-body p {
    margin: 10px 0;
}

.modal-body i {
    margin-right: 5px;
}

/* 버튼 활성화 스타일 */
button.active {
    color: white;
}

 * {
            font-family: 'Noto Sans', sans-serif !important; 
        }

	.calendar-button {
    background-color: rgb(108, 122, 137); /* 배경 색상 */
    color: #ffffff; /* 글자 색상 */
    border: none; /* 테두리 없애기 */
    border-radius: 4px; /* 모서리 둥글게 만들기 */
    padding: 4px 8px; /* 여백 추가 */
    font-size: 14px; /* 글자 크기 */
    font-weight: bold; /* 글자 굵게 */
    cursor: pointer; /* 마우스 커서가 버튼 위에 올 때 손가락 모양으로 변경 */
    transition: background-color 0.3s, box-shadow 0.3s; /* 배경 색상 및 그림자 부드러운 전환 효과 */
    outline: none; /* 포커스 시 외곽선 없애기 */
    margin: 0 2px;
}

/* 버튼 호버 상태 */
.calendar-button:hover {
    background-color: #003366; /* 호버 시 배경 색상 변경 */
}

/* 버튼 클릭 상태 */
.calendar-button:active {
    background-color: #001533; /* 클릭 시 배경 색상 변경 */
    box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.3); /* 클릭 시 안쪽 그림자 추가 */
}

/* 버튼 포커스 상태 */
.calendar-button:focus {
    box-shadow: 0 0 0 2px rgba(0, 0, 255, 0.5); /* 포커스 시 외곽선 추가 */
}

.render-range{
 color: #212121;
}

.toastui-calendar-popup-button.toastui-calendar-popup-confirm {
    background-color: #ff9900;
    border: none;
    border-radius: 40px;
    color: #fff;
    float: right;
    font-size: 12px;
    font-weight: 700;
    height: 36px;
    width: 96px;
}

.kc-main-content{
	background-color: rgb(255, 192, 97);
    padding: 10px;
    margin: 30px;
    border-radius: 8px;
}




</style>

</head>
<body class="page-body kc-body" data-url="http://neon.dev">
	<div class="page-container main-content kc-container">
		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp"
			flush="false" />
		<div class="whole">
			<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp"
				flush="false" />
			<ol class="breadcrumb bc-3 breadinfo">
				<li><a href="#none" onclick="cf_movePage('/system')"><i
						class="fa fa-home"></i>Home</a></li>
				<li class="active"><strong>스케줄 관리</strong></li>
			</ol>
			<div class="kc-main-content">

				<h2 class="kc-consult-list-title" style="padding: 0px 20px; color: #ffffff; ">스케줄 관리</h2>

				<div id="menu"> <!-- 스케줄 아이콘 변경 -->
				    <div id="menu-navi" style="display: flex; align-items: center; padding: 6px 20px;">
				        <button type="button" class="calendar-button move-day" data-action="move-prev" style="padding: 4px 16px;">&lt;</button>
				        <button type="button" class="calendar-button move-today" data-action="move-today">오늘</button>
						<button type="button" class="calendar-button move-day" data-action="move-next" style="padding: 4px 16px;">&gt;</button>
				         <span id="renderRange" class="render-range" style="margin: 10px; margin-left: auto; font-size: 18px; color: #ffffff;">2024년 8월</span>
				    </div>
				    <div id="view-modes" style="display: flex; padding: 0 20px;">
				        <button type="button" class="calendar-button" data-view-mode="month">Month</button>
				        <button type="button" class="calendar-button" data-view-mode="week">Week</button>
				        <button type="button" class="calendar-button" data-view-mode="day">Day</button>
				    </div>
				</div>


				<div class="calendar-container">
					<div id="calendar" style="height: 800px; width: 80%;"></div>
					<div id="todo-list" style="width: 30%; margin-left: 2%; padding: 10px;">
						<h3>오늘의 할 일</h3>
						<h4 id="today-date"></h4>
						<ul id="todo-items"></ul>
					</div>
				</div>
				
				
				<script>
            document.addEventListener('DOMContentLoaded', function() {
                let allEvents = [];
                const Calendar = tui.Calendar;
                const container = document.getElementById('calendar');
                const calendarColors = {
                    'personal': {
                        backgroundColor: '#FF9F1C',
                        borderColor: '#FF9F1C'
                    },
                    'team': {
                        backgroundColor: '#2EC4B6',
                        borderColor: '#2EC4B6'
                    },
                    'company': {
                        backgroundColor: '#E71D36',
                        borderColor: '#E71D36'
                    }
                };
                const options = {
                    defaultView: 'month',
                    useFormPopup: true,
                    useDetailPopup: true,
                    calendars: [
                        {
                            id: 'personal',
                            name: '개인',
                            backgroundColor: '#FF9F1C'
                        },
                        {
                            id: 'team',
                            name: '팀',
                            backgroundColor: '#2EC4B6'
                        },
                        {
                            id: 'company',
                            name: '전체',
                            backgroundColor: '#E71D36'
                        }
                    ],
                    month: {
                        dayNames: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
                        startDayOfWeek: 0,
                        narrowWeekend: true
                    },
                    week: {
                        dayNames: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
                        startDayOfWeek: 0,
                        narrowWeekend: true
                    },
                    theme: {
                        common: {
                            border: '1px solid #e5e5e5',
                            backgroundColor: 'white',
                            holiday: { color: '#f54f3d' },
                            saturday: { color: '#135de6' },
                            dayName: { color: '#333' },
                            today: { color: '#009688' },
                            gridSelection: {
                                backgroundColor: 'rgba(19, 93, 230, 0.1)',
                                border: '1px solid #135de6'
                            }
                        }
                    },
                    template: {
                        popupIsAllday: function() {
                            return '종일';
                        },
                        popupStateFree: function() {
                            return '여유';
                        },
                        popupStateBusy: function() {
                            return '바쁨';
                        },
                        titlePlaceholder: function() {
                            return '제목';
                        },
                        locationPlaceholder: function() {
                            return '위치';
                        },
                        startDatePlaceholder: function() {
                            return '시작 날짜';
                        },
                        endDatePlaceholder: function() {
                            return '종료 날짜';
                        },
                        popupSave: function() {
                            return '저장';
                        },
                        popupUpdate: function() {
                            return '수정';
                        },
                        popupDetailDate: function(schedule) {
                            console.log('popupDetailDate called with:', schedule);
                            
                            const formatDate = function(dateObj) {
                                if (!(dateObj instanceof Date)) {
                                    dateObj = new Date(dateObj);
                                }
                                const year = dateObj.getFullYear();
                                const month = (dateObj.getMonth() + 1).toString().padStart(2, '0');
                                const day = dateObj.getDate().toString().padStart(2, '0');
                                const hours = dateObj.getHours().toString().padStart(2, '0');
                                const minutes = dateObj.getMinutes().toString().padStart(2, '0');
                                return year + '.' + month + '.' + day + ' ' + hours + ':' + minutes;
                            };

                            let start, end;
                            try {
                                if (schedule.isAllDay) {
                                    start = schedule.start instanceof Date ? schedule.start : new Date(schedule.start);
                                    end = schedule.end instanceof Date ? schedule.end : new Date(schedule.end);
                                    // 종일 일정의 경우 end date에서 하루를 빼줍니다.
                                    end.setDate(end.getDate() - 1);
                                    const result = formatDate(start).split(' ')[0] + ' - ' + formatDate(end).split(' ')[0] + ' (종일)';
                                    console.log('popupDetailDate returning:', result);
                                    return result;
                                } else {
                                    start = schedule.start instanceof Date ? schedule.start : new Date(schedule.start);
                                    end = schedule.end instanceof Date ? schedule.end : new Date(schedule.end);
                                    const result = formatDate(start) + ' - ' + formatDate(end);
                                    console.log('popupDetailDate returning:', result);
                                    return result;
                                }
                            } catch (error) {
                                console.error('Error in popupDetailDate:', error);
                                return 'Error processing date';
                            }
                        },
                        
                        popupDetailLocation: function(schedule) {
                            return '위치 : ' + (schedule.location || '지정되지 않음');
                        },
                        popupDetailUser: function(schedule) {
                            return '참석자 : ' + (schedule.attendees && schedule.attendees.length > 0 ? schedule.attendees.join(', ') : 
                                   (schedule.evt_atnd_lst || '없음'));
                        },
                        popupDetailState: function(schedule) {
                            return '상태 : ' + (schedule.state || '지정되지 않음');
                        },
                        popupDetailRepeat: function(schedule) {
                            return '반복 : ' + (schedule.recurrenceRule || '없음');
                        },
                        popupDetailBody: function(schedule) {
                            return '내용 : ' + (schedule.body || '설명 없음');
                        },
                        popupEdit: function() {
                            return 'Edit';
                        },
                        popupDelete: function() {
                            return 'Delete';
                        },                        
                    },
                    tzid: 'Asia/Seoul',
                };

                const calendar = new Calendar(container, options);
                
                // 캘린더 초기화 직후 현재 날짜 설정
                const now = new Date();
                calendar.setDate(now);
                calendar.setCalendarColor('personal', calendarColors.personal);
                calendar.setCalendarColor('team', calendarColors.team);
                calendar.setCalendarColor('company', calendarColors.company);
                updateRenderRangeText();
                
                function parseDate(dateInput) {
                    console.log('Parsing date input:', dateInput);

                    if (!dateInput) return new Date();
                    
                    if (dateInput instanceof Date) return dateInput;
                    
                    if (typeof dateInput === 'number') return new Date(dateInput);
                    
                    if (typeof dateInput === 'string') {
                        if (dateInput.includes('T')) {
                            return new Date(dateInput);
                        }
                        
                        const parts = dateInput.split(/[- :]/);
                        if (parts.length >= 6) {
                            return new Date(parts[0], parts[1] - 1, parts[2], parts[3], parts[4], parts[5]);
                        }
                        
                        if (parts.length >= 3) {
                            return new Date(parts[0], parts[1] - 1, parts[2]);
                        }
                    }
                    
                    console.error('Invalid date input:', dateInput);
                    return new Date();
                }

                function setViewMode(viewMode) {
                    calendar.changeView(viewMode);
                    updateRenderRangeText();
                }

                function updateRenderRangeText() {
                    const renderRange = document.getElementById('renderRange');
                    const viewName = calendar.getViewName();
                    const html = [];
                    let start, end;

                    if (viewName === 'month') {
                        start = calendar.getDate().toDate();
                        end = new Date(start.getFullYear(), start.getMonth() + 1, 0);
                    } else {
                        start = calendar.getDateRangeStart().toDate();
                        end = calendar.getDateRangeEnd().toDate();
                    }

                    if (viewName === 'day') {
                        html.push(start.toLocaleDateString('ko-KR', { year: 'numeric', month: 'long', day: 'numeric' }));
                    } else if (viewName === 'month') {
                        html.push(start.toLocaleDateString('ko-KR', { year: 'numeric', month: 'long' }));
                    } else {
                        html.push(start.toLocaleDateString('ko-KR', { year: 'numeric', month: 'long', day: 'numeric' }));
                        html.push(' - ');
                        html.push(end.toLocaleDateString('ko-KR', { year: 'numeric', month: 'long', day: 'numeric' }));
                    }
                    renderRange.innerHTML = html.join('');
                }

                function setActiveButton(viewMode) {
                    document.querySelectorAll('[data-view-mode]').forEach(button => {
                        button.classList.remove('active');
                        if (button.dataset.viewMode === viewMode) {
                            button.classList.add('active');
                        }
                    });
                }

                document.querySelector('#menu-navi').addEventListener('click', function(e) {
                    const action = e.target.closest('[data-action]').dataset.action;
                    switch (action) {
                        case 'move-prev':
                            calendar.prev();
                            break;
                        case 'move-next':
                            calendar.next();
                            break;
                        case 'move-today':
                            calendar.today();
                            break;
                        default:
                            return;
                    }
                    updateRenderRangeText();
                });

                document.querySelectorAll('[data-view-mode]').forEach(button => {
                    button.addEventListener('click', function(e) {
                        const viewMode = e.target.closest('[data-view-mode]').dataset.viewMode;
                        setViewMode(viewMode);
                        setActiveButton(viewMode);
                    });
                });

                // 초기 활성 버튼 설정
                setActiveButton('month');
                updateRenderRangeText();

                function updateTodoList() {
                    const todoList = document.getElementById('todo-items');
                    const todayDateElement = document.getElementById('today-date');

                    // 오늘 날짜 표시
                    const today = new Date();
                    today.setHours(0, 0, 0, 0); // 시간을 00:00:00으로 설정
                    todayDateElement.textContent = today.toLocaleDateString('ko-KR', { 
                        year: 'numeric', 
                        month: 'long', 
                        day: 'numeric', 
                        weekday: 'long' 
                    });

                    // Todo 리스트 초기화
                    todoList.innerHTML = '';

                    // 오늘의 이벤트 필터링 및 정렬
                    const todayEvents = allEvents.filter(event => {
                        const eventStart = new Date(event.start);
                        const eventEnd = new Date(event.end);
                        
                        // 종일 일정인 경우 end date에서 하루를 빼줍니다.
                        if (event.isAllDay) {
                            eventEnd.setDate(eventEnd.getDate() - 1);
                        }
                        
                        eventStart.setHours(0, 0, 0, 0);
                        eventEnd.setHours(23, 59, 59, 999);
                        
                        // 당일 일정이거나 오늘 날짜가 이벤트 기간에 포함되는 경우
                        return (eventStart <= today && today <= eventEnd) ||
                               (eventStart.getTime() === today.getTime());
                    }).sort((a, b) => {
                        if (a.isAllDay && !b.isAllDay) return -1;
                        if (!a.isAllDay && b.isAllDay) return 1;
                        if (a.isAllDay && b.isAllDay) return 0;
                        return new Date(a.start).getTime() - new Date(b.start).getTime();
                    });

                    // 오늘 일정이 없을 경우 메시지 표시
                    if (todayEvents.length === 0) {
                        const li = document.createElement('li');
                        li.textContent = '오늘 일정이 없습니다.';
                        todoList.appendChild(li);
                    } else {
                        // 오늘의 이벤트를 Todo 리스트에 추가
                        todayEvents.forEach(event => {
                            const eventStart = new Date(event.start);
                            let startTime = event.isAllDay ? '종일' : eventStart.toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit' });
                            
                            const title = event.title || '제목 없음';
                            const location = event.location || '';
                            
                            const li = document.createElement('li');
                            
                            li.className = 'todo-item';  // 클래스 추가
                            li.onclick = function() {
                                showEventDetails(event, this);
                            };
                            
                            const iconSpan = document.createElement('span');
                            iconSpan.className = 'todo-icon';
                            iconSpan.innerHTML = '<i class="fas fa-calendar-check"></i>';
                            li.appendChild(iconSpan);
                            
                            const timeSpan = document.createElement('span');
                            timeSpan.className = 'todo-time';
                            timeSpan.textContent = startTime;
                            li.appendChild(timeSpan);
                            
                            const contentDiv = document.createElement('div');
                            contentDiv.className = 'todo-content';
                            
                            const titleContainer = document.createElement('div');
                            titleContainer.className = 'todo-title-container';
                            
                            const titleSpan = document.createElement('span');
                            titleSpan.className = 'todo-title';
                            titleSpan.textContent = title;
                            titleContainer.appendChild(titleSpan);
                            
                            // 스케줄 유형 표시
                            const typeDiv = document.createElement('div');
                            typeDiv.className = 'todo-type';
                            
                            const typeDot = document.createElement('span');
                            typeDot.className = 'todo-type-dot';
                            typeDot.style.backgroundColor = calendarColors[event.calendarId].backgroundColor;
                            typeDiv.appendChild(typeDot);
                            
                            const typeText = document.createElement('span');
                            typeText.className = 'todo-type-text';
                            typeText.textContent = event.calendarId === 'personal' ? '개인' : 
                                                   event.calendarId === 'team' ? '팀' : '전체';
                            typeDiv.appendChild(typeText);
                            
                            titleContainer.appendChild(typeDiv);
                            contentDiv.appendChild(titleContainer);
                            
                            if (location) {
                                const locationSpan = document.createElement('span');
                                locationSpan.className = 'todo-location';
                                locationSpan.textContent = location;
                                contentDiv.appendChild(locationSpan);
                            }
                            
                            li.appendChild(contentDiv);
                            
                            // 완료 버튼 추가
                            const completeButton = document.createElement('button');
                            completeButton.className = 'todo-complete';
                            completeButton.textContent = '완료';
                            completeButton.onclick = function(e) {
                                e.stopPropagation();  // 이벤트 전파 중단
                                li.classList.toggle('todo-completed');
                                if (li.classList.contains('todo-completed')) {
                                    completeButton.textContent = '취소';
                                } else {
                                    completeButton.textContent = '완료';
                                }
                            };
                            li.appendChild(completeButton);

                            todoList.appendChild(li);
                        });
                    }
                }

                cf_ajax('/schedule/events', {}, function(data) {
                    console.log('Raw event data:', data.events);
                    allEvents = data.events.map(event => ({
                        id: event.evt_sn,
                        calendarId: event.calendar_id,
                        title: event.evt_title,
                        start: new Date(event.evt_bgng_dt),
                        end: new Date(event.evt_end_dt),
                        isAllDay: event.is_all_day === 'Y',
                        category: event.is_all_day === 'Y' ? 'allday' : 'time',
                        isVisible: true,
                        isReadOnly: event.calendar_id !== 'personal',
                        location: event.evt_location,
                        attendees: event.evt_atnd_lst ? event.evt_atnd_lst.split(',') : []
                    }));
                    
                    console.log('Processed events:', allEvents);
                    calendar.createEvents(allEvents);
                    calendar.render();
                    updateRenderRangeText();
                    updateTodoList();  // 여기에서 updateTodoList 호출
                });

                calendar.on('beforeCreateEvent', function(eventData) {
                    console.log('Creating event:', eventData);
                    const calendarId = eventData.calendarId || 'personal';
                    const colors = calendarColors[calendarId] || calendarColors['personal'];
                    const params = {
                        calendarId: calendarId,
                        title: eventData.title,
                        start: eventData.start.toDate().toISOString(),  // ISO 문자열로 변환
                        end: eventData.end.toDate().toISOString(),      // ISO 문자열로 변환
                        isAllday: eventData.isAllday,
                        category: eventData.category,
                        location: eventData.location,
                        attendees: eventData.attendees ? eventData.attendees.join(',') : '',
                        state: eventData.state,
                        backgroundColor: colors.backgroundColor,
                        borderColor: colors.borderColor
                    };
                    cf_ajax('/schedule/event', params, function(createdEvent) {
                        console.log('Event created:', createdEvent);
                        const newEvent = {
                            id: createdEvent.EVT_SN,
                            calendarId: createdEvent.CALENDAR_ID,
                            title: createdEvent.EVT_TITLE,
                            body: createdEvent.EVT_CN,
                            start: new Date(createdEvent.EVT_BGNG_DT),
                            end: new Date(createdEvent.EVT_END_DT),
                            isAllday: createdEvent.IS_ALL_DAY === 'Y',
                            category: createdEvent.IS_ALL_DAY === 'Y' ? 'allday' : 'time',
                            location: createdEvent.EVT_LOCATION || '',
                            attendees: createdEvent.EVT_ATND_LST ? createdEvent.EVT_ATND_LST.split(',') : [],
                            state: createdEvent.EVT_STCD,
                            backgroundColor: colors.backgroundColor,
                            borderColor: colors.borderColor
                        };
                        allEvents.push(newEvent);
                        calendar.createEvents([newEvent]);
                        updateTodoList();  // 여기에서 updateTodoList 호출
                    });
                });

                calendar.on('beforeUpdateEvent', function(eventData) {
                    console.log('Updating event:', eventData);
                    if (eventData.event.calendarId !== 'personal') {
                        alert('개인 일정만 수정할 수 있습니다.');
                        return;
                    }
                    const calendarId = eventData.event.calendarId || 'personal';
                    const colors = calendarColors[calendarId] || calendarColors['personal'];
                    const params = {
                        EVT_SN: eventData.event.id,
                        CALENDAR_ID: calendarId,
                        EVT_TITLE: eventData.changes.title || eventData.event.title,
                        EVT_BGNG_DT: (eventData.changes.start || eventData.event.start).toDate().toISOString(),
                        EVT_END_DT: (eventData.changes.end || eventData.event.end).toDate().toISOString(),
                        IS_ALL_DAY: (eventData.changes.isAllday !== undefined ? eventData.changes.isAllday : eventData.event.isAllday) ? 'Y' : 'N',
                        EVT_CATEGORY: eventData.changes.category || eventData.event.category,
                        EVT_LOCATION: eventData.changes.location || eventData.event.location,
                        EVT_ATND_LST: (eventData.changes.attendees || eventData.event.attendees || []).join(','),
                        EVT_STCD: eventData.changes.state || eventData.event.state
                    };
                    cf_ajax('/schedule/event/update', params, function(updatedEvent) {
                        console.log('Event updated:', updatedEvent);
                        const updatedEventIndex = allEvents.findIndex(e => e.id === updatedEvent.EVT_SN);
                        if (updatedEventIndex !== -1) {
                            allEvents[updatedEventIndex] = {
                                id: updatedEvent.EVT_SN,
                                calendarId: updatedEvent.CALENDAR_ID,
                                title: updatedEvent.EVT_TITLE,
                                body: updatedEvent.EVT_CN,
                                start: new Date(updatedEvent.EVT_BGNG_DT),
                                end: new Date(updatedEvent.EVT_END_DT),
                                isAllday: updatedEvent.IS_ALL_DAY === 'Y',
                                category: updatedEvent.IS_ALL_DAY === 'Y' ? 'allday' : 'time',
                                location: updatedEvent.EVT_LOCATION,
                                attendees: updatedEvent.EVT_ATND_LST ? updatedEvent.EVT_ATND_LST.split(',') : [],
                                state: updatedEvent.EVT_STCD,
                                isReadOnly: false,
                                backgroundColor: colors.backgroundColor,
                                borderColor: colors.borderColor
                            };
                        }
                        calendar.updateEvent(eventData.event.id, calendarId, allEvents[updatedEventIndex]);
                        updateTodoList();  // 여기에서 updateTodoList 호출
                    });
                });

                calendar.on('beforeDeleteEvent', function(eventData) {
                    console.log('Deleting event:', eventData);
                    if (eventData.calendarId !== 'personal') {
                        alert('개인 일정만 삭제할 수 있습니다.');
                        return;
                    }
                    cf_ajax('/schedule/event/delete', {EVT_SN: eventData.id}, function(response) {
                        console.log('Event deleted:', response);
                        if (response.status === 'OK') {
                            allEvents = allEvents.filter(e => e.id !== eventData.id);
                            calendar.deleteEvent(eventData.id, eventData.calendarId);
                            updateTodoList();  // 여기에서 updateTodoList 호출
                        } else {
                            alert('이벤트 삭제에 실패했습니다.');
                        }
                    });
                });
                
                calendar.on('clickEvent', function(eventObj) {
                    console.log('Clicked event (full object):', JSON.stringify(eventObj, null, 2));
                    console.log('Event start:', new Date(eventObj.event.start.d ? eventObj.event.start.d.d : eventObj.event.start));
                    console.log('Event end:', new Date(eventObj.event.end.d ? eventObj.event.end.d.d : eventObj.event.end));
                });
                
                function showEventDetails(event) {
                    var modal = document.getElementById('eventDetailsModal');
                    var span = modal.querySelector('.close');
                    var title = document.getElementById('eventTitle');
                    var type = document.getElementById('eventType');
                    var start = document.getElementById('eventStart');
                    var end = document.getElementById('eventEnd');
                    var location = document.getElementById('eventLocation');
                    var attendees = document.getElementById('eventAttendees');

                    title.textContent = event.title;

                    var eventTypeText = event.calendarId === 'personal' ? '개인' : 
                                        event.calendarId === 'team' ? '팀' : '전체';
                    type.textContent = eventTypeText;
                    type.className = event.calendarId;

                    var formatDate = function(date) {
                        return new Date(date).toLocaleString('ko-KR', {
                            year: 'numeric',
                            month: 'long',
                            day: 'numeric',
                            hour: '2-digit',
                            minute: '2-digit',
                            hour12: true
                        });
                    };

                    start.textContent = formatDate(event.start);
                    end.textContent = formatDate(event.end);
                    location.textContent = event.location || '없음';
                    attendees.textContent = event.attendees && event.attendees.length > 0 ? event.attendees.join(', ') : '없음';

                    modal.style.display = 'block';

                    span.onclick = function() {
                        modal.style.display = 'none';
                    }

                    window.onclick = function(event) {
                        if (event.target == modal) {
                            modal.style.display = 'none';
                        }
                    }
                }

            });
            </script>
			</div>
		</div>

		<div id="eventDetailsModal" class="modal">
			<div class="modal-content">
				<div class="modal-header">
					<span class="close">&times;</span>
					<h2 id="eventTitle"></h2>
				</div>
				<div class="modal-body">
					<p>
						<span id="eventType"></span>
					</p>
					<p>
						<i class="far fa-clock"></i> <strong>시작</strong> <span
							id="eventStart"></span>
					</p>
					<p>
						<i class="far fa-clock"></i> <strong>종료</strong> <span
							id="eventEnd"></span>
					</p>
					<p>
						<i class="fas fa-map-marker-alt"></i> <strong>위치</strong> <span
							id="eventLocation"></span>
					</p>
					<p>
						<i class="fas fa-users"></i> <strong>참석자</strong> <span
							id="eventAttendees"></span>
					</p>
				</div>
			</div>
		</div>
	</div>
</body>
</html>