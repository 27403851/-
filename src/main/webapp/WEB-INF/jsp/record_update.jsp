<%@page import="record.model.Record"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	Record record = (Record)request.getAttribute("record");
%>
<html>
	<head>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/purecss@3.0.0/build/pure-min.css">
		<link rel="stylesheet" href="/JavaWeb/css/buttons.css">
		<link rel="stylesheet" href="/JavaWeb/css/record_update.css">
		<link href="../images/pig.ico" rel="shortcut icon"/>
		<meta charset="UTF-8">
		<title>Record Update</title>
		<script src="/JavaWeb/js/record_update.js"></script>
	</head>
	<body style="padding: 15px">
		<!-- 修改留言 -->
		<form class="pure-form" action="/JavaWeb/record/update" method="post">
			<fieldset>
				<legend>內容更新</legend>
					<section>
						序號: <input type="text" id="id" name="id" value="<%=record.getId() %>" readonly /><p>
						種類: <input type="text" id="type" name="type" value="<%=record.getType() %>" /><p>
						金額: <input type="text" id="cost" name="cost" value="<%=record.getCost() %>" /><p>
						收支日期: <input type="date" id="costDate" name="costDate" value="<%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(record.getCostDate()) %>"><p>
						備註: <textarea rows="5" cols="20" id="content" name="content"><%=record.getContent() %></textarea><p>
					</section>
					
					<div>
						<button type="submit" class="pure-button pure-button-primary">修改內容</button>
						<button type="button" class="pure-button" onclick="cancelUpdate()">取消</button>
					</div>
					
			</fieldset>
		</form>
		
		
	</body>
</html>