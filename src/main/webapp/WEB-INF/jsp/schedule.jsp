<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/purecss@3.0.0/build/pure-min.css">
		<link rel="stylesheet" href="/JavaWeb/css/buttons.css">
		<link rel="stylesheet" href="/JavaWeb/css/schedule.css">
		<link href="images/calendar.ico" rel="shortcut icon"/>
		<meta charset="UTF-8">
		<title>行程表</title>
		<script src="/JavaWeb/js/schedule.js"></script>
	</head>
	<body style="padding: 15px">
		<!-- 新增項目 -->
		<header>
			<form class="pure-form" action="/JavaWeb/schedule" method="post" onsubmit="return validateForm()" >
				<fieldset>
					<h2>行程表</h2>
					活動名稱: <input type="text" id="eventName" name="eventName" placeholder="請輸入活動名稱" required /><p>
					開始日期: <input type="date" name="starDate" id="starDate" required /><p>
					結束日期: <input type="date" name="endDate" id="endDate" /><p>
					標籤顏色: <select id="eventType" name="eventType" required> 
								<option value="1">紅色</option> 
								<option value="2">綠色</option> 
								<option value="3">黃色</option> 
								<option value="4">藍色</option>
							</select> <p>
					備註內容: <br> 
					<textarea rows="5" cols="20" id="description" name="description" style="resize: none;" placeholder="請輸入備註"></textarea></p>
					
					<div>
						<a href="./schedule/calendar" type="button" class="button-test pure-button">行事曆</a>
						<button type="submit" class="pure-button pure-button-primary">新增</button>
						<button type="button" class="pure-button" onclick="clearForm()">清除</button>
					</div>
        			
					<script>
						function clearForm() {
					        document.getElementById("eventName").value = ""; // 清除活动名称输入框内容
					        document.getElementById("starDate").value = ""; // 清除开始日期输入框内容
					        document.getElementById("endDate").value = ""; // 清除结束日期输入框内容
					        document.getElementById("eventType").selectedIndex = 0; // 将活动类型下拉框重置为第一个选项
					        document.getElementById("description").value = ""; // 清除备注内容输入框内容
					    }
					</script>
					
				</fieldset>
			</form>
		</header>
		
		<footer>
			<div>
				<%@ include file="schedule_content.jsp" %>
			</div>
		</footer>
		
		<!-- 返回首頁 -->
		<aside>			
			<a href="/JavaWeb/default.html" class="pure-button">
				<img src="images/home.png" width="60" height="60">
			</a>
		</aside>
		
		
				
	</body>
</html>