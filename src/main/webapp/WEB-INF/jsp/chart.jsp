
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="record.model.Record"%>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// Map to hold aggregated records from the database
	Map<String, Integer> aggregatedRecords = new HashMap<>();

    // 設定 MySQL 建立連接
    String url = "jdbc:mysql://localhost:3306/web?serverTimezone=Asia/Taipei";
    String username = "root";
    String password = "12345678";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection(url, username, password);
        String sql = "SELECT type, cost FROM record";
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet resultSet = statement.executeQuery();

        while (resultSet.next()) {
            String type = resultSet.getString("type");
            String costStr = resultSet.getString("cost");
            Integer cost = Integer.parseInt(costStr);  // Convert cost from String to Integer
            
         // type 項目是否已存在，若存在將合併 cost 值，若不存在將建立新的 type
            if (aggregatedRecords.containsKey(type)) {
                aggregatedRecords.put(type, aggregatedRecords.get(type) + cost);
            } else {
                aggregatedRecords.put(type, cost);
            }
        }

        resultSet.close();
        statement.close();
        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>



<%
    // 獲取當前年份和月份
    Calendar calendar = Calendar.getInstance();
    int currentYear = calendar.get(Calendar.YEAR);
    int currentMonth = calendar.get(Calendar.MONTH) + 1;

    // 生成月份選項
    List<String> months = new ArrayList<>();
    SimpleDateFormat monthFormat = new SimpleDateFormat("MMMM yyyy");
    for (int i = 1; i <= 12; i++) {
        calendar.set(currentYear, i - 1, 1);
        months.add(monthFormat.format(calendar.getTime()));
    }
%>


<html>
	<head>
	  	<link rel="stylesheet" href="/JavaWeb/css/chart.css">
	    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	    <script type="text/javascript">
		    google.charts.load('current', {'packages':['corechart']});
	        google.charts.setOnLoadCallback(drawChart);
	
            function drawChart() {
                var data = google.visualization.arrayToDataTable([
                    ['Type', 'Cost'],
                    <%
                        for (Map.Entry<String, Integer> entry : aggregatedRecords.entrySet()) {
                            out.print("['" + entry.getKey() + "', " + entry.getValue() + "],");
                        }
                    %>
                ]);

                var options = {
                    title: 'Cost by Type'
                };

                var chart = new google.visualization.PieChart(document.getElementById('piechart'));

                chart.draw(data, options);
            }
		</script>
	</head>
	<body>
	
		<!-- 下拉菜單篩選器 -->
		    <form action="chart.jsp" method="GET">
		        <label for="month">Select Month:</label>
		        <select name="month" id="month">
		            <%
		                for (String month : months) {
		                    out.println("<option value=\"" + month + "\">" + month + "</option>");
		                }
		            %>
		        </select>
		        <input type="submit" value="Filter">
		    </form>
		    
		<!-- 產生圓餅圖 -->
    		<div id="piechart" style="width: 500px; height: 600px;"></div>
    	
	</body>
</html>
