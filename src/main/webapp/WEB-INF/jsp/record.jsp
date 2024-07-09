<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>

<html>
	<head>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/purecss@3.0.0/build/pure-min.css">
		<link rel="stylesheet" href="/JavaWeb/css/buttons.css">
		<link rel="stylesheet" href="/JavaWeb/css/record.css">
		<link href="images/pig.ico" rel="shortcut icon"/>
		<meta charset="UTF-8">
		<title>Record</title>
		<script src="/JavaWeb/js/record.js"></script>
	</head>
	<body style="padding: 15px">
	
	<!-- 新增項目 -->
	
		<header>
			<form class="pure-form" action="/JavaWeb/record" method="post">
				<fieldset>
					<h2>記帳</h2>
					類別: <input type="text" id="type" name="type" placeholder="請輸入類別" required /><p>
					金額: <input type="number" id="cost" name="cost" placeholder="請輸入金額" required /><p>
					日期: <input type="date" name="costDate" id="costDate" required /><p>
					備註: <br> 
					<textarea rows="5" cols="20" id="content" name="content" style="resize: none;" placeholder="請輸入備註"></textarea></p>
					
					<div>
						<button type="submit" class="pure-button pure-button-primary">新增</button>
						<button type="button" class="pure-button" onclick="clearForm()">清除</button>
					</div>
					
					<span>
						<a href="/JavaWeb/record/summary" class="button-test pure-button">統計資料</a>
					</span>
					
				</fieldset>
			</form>
		</header>
		
		<!-- 項目列表 -->
		
		<div>
			<%@ include file="record_content.jspf" %>
		</div>
		
		<!-- 返回首頁 -->
		<aside>			
			<a href="/JavaWeb/default.html" class="pure-button">
				<img src="images/home.png" width="60" height="60">
			</a>
		</aside>
		
	</body>
</html>