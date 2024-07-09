<%@page import="schedule.model.Schedule"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	Schedule schedule = (Schedule)request.getAttribute("schedule");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<html>
	<head>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/purecss@3.0.0/build/pure-min.css">
		<link rel="stylesheet" href="/JavaWeb/css/buttons.css">
		<link rel="stylesheet" href="/JavaWeb/css/schedule_update.css">
		<link href="../images/calendar.ico" rel="shortcut icon"/>
		<script src="/JavaWeb/js/schedule_update.js"></script>
		<meta charset="UTF-8">
		<title>Schedule Update</title>
	</head>
	<body style="padding: 15px">
		<!-- 修改內容 -->
		<form class="pure-form" action="/JavaWeb/schedule/update" method="post" onsubmit="return validateForm()">
			<fieldset>
				<legend>內容更新</legend>
					<section>						       
						活動名稱: <input type="text" id="eventName" name="eventName" value="<%=schedule.getEventName() %>" required="required"/><p>
						開始日期: <input type="date" id="starDate" name="starDate" value="<%=schedule.getStarDate() != null ? new SimpleDateFormat("yyyy-MM-dd").format(schedule.getStarDate()) : "" %>" required="required"/><p>
						结束日期: <input type="date" id="endDate" name="endDate" value="<%=schedule.getEndDate() != null ? new SimpleDateFormat("yyyy-MM-dd").format(schedule.getEndDate()) : "" %>" ><p>
						標籤顏色: <select id="eventType" name="eventType" required>
								    <option value="1" <%= schedule.getEventType().equals("1") ? "selected" : "" %>>紅色</option>
								    <option value="2" <%= schedule.getEventType().equals("2") ? "selected" : "" %>>綠色</option>
								    <option value="3" <%= schedule.getEventType().equals("3") ? "selected" : "" %>>黃色</option>
								    <option value="4" <%= schedule.getEventType().equals("4") ? "selected" : "" %>>藍色</option>
								</select> <p>
						備註內容:	<textarea rows="5" cols="20" id="description" name="description" style="resize: none;" placeholder="請輸入備註"></textarea></p>
						<!-- 隱藏項目:序號 -->
								<input type="hidden" id="id" name="id" value="<%=schedule.getId() %>" /><p>
					</section>
					
					<div>
						<button type="submit" class="pure-button pure-button-primary">修改內容</button>
						<a href="/JavaWeb/schedule" type="button" class="pure-button" onclick="cancelUpdate()">取消</a>
					</div>
					
			</fieldset>
		</form>
		
		
	</body>
</html>