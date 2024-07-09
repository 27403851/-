<%@ page import="schedule.dao.*" %>
<%@ page import="schedule.model.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 创建 ScheduleDao 实例
    ScheduleDao scheduleDao = new ScheduleMySQL();
    
    // 调用 ScheduleDao 的方法获取所有日程数据
    List<Schedule> calendarSchedules = scheduleDao.findAll();
    
    // 转换日程数据为 JSON 格式
    StringBuilder json = new StringBuilder();
    json.append("[");
    for (Schedule schedule : calendarSchedules) {
        json.append("{");
        json.append("\"id\": \"" + schedule.getId() + "\",");
        json.append("\"title\": \"" + schedule.getEventName() + "\",");
        json.append("\"start\": \"" + schedule.getStarDate() + "\",");
        json.append("\"end\": \"" + schedule.getEndDate() + "\",");
        json.append("\"description\": \"" + schedule.getDescription() + "\",");
        
        
        // 根据事件类型设置颜色
        if (schedule.getEventType().equals("1")) {
            json.append("\"color\": \"rgb(255, 162, 205)\","); // 设置为红色
        } else if (schedule.getEventType().equals("2")) {
            json.append("\"color\": \"rgb(150, 240, 160)\","); // 设置为绿色
        } else if (schedule.getEventType().equals("3")) {
            json.append("\"color\": \"rgb(238, 222, 130)\","); // 设置为黃色
        } else if (schedule.getEventType().equals("4")) {
            json.append("\"color\": \"rgb(130, 173, 238)\","); // 设置为藍色
        } else {
            json.append("\"color\": \"(220, 250, 180)\","); // 原始設置
        }
        
        // 可以根据需要添加其他属性
        json.append("},");
    }
    if (!calendarSchedules.isEmpty()) {
        json.deleteCharAt(json.length() - 1); // 移除最后一个逗号
    }
    json.append("]");
%>

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/JavaWeb/css/schedule_fullcalendar.css">
	<link rel="stylesheet" href="/JavaWeb/css/buttons.css">
	<link href="../images/calendar.ico" rel="shortcut icon"/>
	<script src="/JavaWeb/js/schedule_fullcalendar.js"></script>
    <style>
	    html {
			background-image: url(https://image-cdn-flare.qdm.cloud/q591070f643292/image/data/2021/11/05/984e1229607bf04fede13d5e81377def.jpg);
			background-size: 100%;
			background-repeat: no-repeat;
				
		}
		
		body {
		    width: 54%;
		    margin-left: auto;
		    margin-right: auto;
			margin-top: 3px;
			margin-bottom: 1px;
			background: white; /* 内容背景颜色 */
			padding: 40px; /* 增加内边距 */
			box-shadow: 0 0 20px rgba(0, 0, 0, 0.1); /* 添加阴影使内容更突出 */
			border-radius: 8px; /* 圆角 */
		}
    </style>
</head>
<body>

    <!-- 返回按钮 -->
    <a href="/JavaWeb/schedule" id="backButton" >返回</a>
    
    <!-- Calendar position -->
    <div id="calendar"></div>   

    <script>
      document.addEventListener("DOMContentLoaded", function() {
        const calendarEl = document.getElementById("calendar")
        const calendar = new FullCalendar.Calendar(calendarEl, {
	        dayMaxEventRows: true, // 设置为 true 以确保每个日期格子中的事件行数相同
	        initialView: "dayGridMonth",
	        headerToolbar: {
	            left: "prev,next today",
	            center: "title",
	            right: "dayGridMonth",
          	},
        	buttonText: {
	            today: "Today",
	            month: "Month",
          	},
          
	        // 滑鼠經過時間槽觸發事件(因自行設定標籤顏色，目前暫無作用)。
	        eventMouseEnter: function(info) {
            	// 添加悬停时的样式或其他操作
            	info.el.classList.add('hovered');
        	},
        	eventMouseLeave: function(info) {
	            // 移除悬停时的样式或其他操作
	            info.el.classList.remove('hovered');
          	},
          
          
	        events: <%= json %>, // 将 JSON 数据直接嵌入到 JavaScript 中
	        eventDisplay: 'block',
	        
	  		// 觸及時間槽觸發事件
	        eventClick: function(info) {
	            console.log(info.event)
	
	        	// 獲取備註內容，如果備註沒內容則顯示 "none"
		  		var description = info.event.extendedProps.description || "none";
	            var eventId = info.event.id; // 獲取事件ID    
	            
	             // 顯示SweetAlert2彈出框
		         Swal.fire({
		         	icon: info.event.allDay ? "success" : "info",
		           	title: info.event.title,
		         	text: description,
		         	confirmButtonText: "OK",
		         	// 添加自定義按鈕
		         	showCancelButton: true,
		         	cancelButtonText: "修改",
	            }).then((result) => {
	                // 處理點擊自定義按鈕的事件
	                if (result.isConfirmed) {
	                    // 在這裡處理確認按鈕的點擊事件，如果有的話
	                } else if (result.dismiss === Swal.DismissReason.cancel) {
	                    // 在這裡處理取消按鈕的點擊事件
	                    window.location.href = "/JavaWeb/schedule/update?updateId=" + info.event.id;
	                }
	            });
	        }
	    });
	    calendar.render()
	    })
      
    </script>
        
	<!-- sweetAlert2 origin code-->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.all.min.js"></script>
    <!-- fullcalendar origin code-->
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
    

    
</body>
</html>
