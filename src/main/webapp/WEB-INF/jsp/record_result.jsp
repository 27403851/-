<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	Boolean state = (Boolean)request.getAttribute("state");
%>
<html>
	<head>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/purecss@3.0.0/build/pure-min.css">
		<link rel="stylesheet" href="/JavaWeb/css/buttons.css">
		<link rel="stylesheet" href="/JavaWeb/css/record_result.css">
		<link href="images/pig.ico" rel="shortcut icon"/>
		<meta charset="UTF-8">
		<title>Record result</title>
	</head>
	<body style="padding: 15px">
		
		<div class="pure-form">
			<fieldset>
				<legend>系統提示</legend>
					<section>
						<h3><%=state?"新增成功":"新增失敗" %></h3>
						<a href="/JavaWeb/record" class="pure-button pure-button-primary" >返回</a>	
					</section>			
			</fieldset>
		</div>
		
	</body>
</html>