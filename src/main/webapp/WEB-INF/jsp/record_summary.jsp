<%@ page import="record.model.Record"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Collections"%>
<%@ page import="java.util.Comparator"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
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
    // 	获取从请求中传递过来的记录列表
    List<Record> recordList = (List<Record>) request.getAttribute("records");
    Map<String, Map<String, Integer>> monthlyContentCostMap = new HashMap<>();
    Map<String, Integer> monthlyTotalCostMap = new HashMap<>();
    int totalCost = 0;

    // 对记录进行按月分组和合并
    if (recordList != null) {
        for (Record rd : recordList) {
            String month = new SimpleDateFormat("yyyy-MM").format(rd.getCostDate());
            Map<String, Integer> contentCostMap = monthlyContentCostMap.getOrDefault(month, new HashMap<>());
            String content = rd.getType();
            int cost = rd.getCost();
            contentCostMap.put(content, contentCostMap.getOrDefault(content, 0) + cost);
            monthlyContentCostMap.put(month, contentCostMap);

            // 计算每个月的总成本
            int monthTotalCost = monthlyTotalCostMap.getOrDefault(month, 0);
            monthlyTotalCostMap.put(month, monthTotalCost + cost);
            totalCost += cost; // 更新总成本
        }
    }

    // 获取筛选出来的月份
    String selectedMonth = request.getParameter("selectedMonth");
    if (selectedMonth == null) {
        selectedMonth = "all";
    }
    
    // 对月份按照日期进行排序
    List<String> sortedMonths = new ArrayList<>(monthlyContentCostMap.keySet());
    Collections.sort(sortedMonths, new Comparator<String>() {
        public int compare(String o1, String o2) {
            return o1.compareTo(o2);
        }
    });
    
    // 分页相关配置
    int recordsPerPage = 10; // 每页显示记录数
    int totalRecords = 0; // 计算总记录数
    
    // 更新总记录数（考虑筛选月份）
    if ("all".equals(selectedMonth)) {
        for (Map.Entry<String, Map<String, Integer>> entry : monthlyContentCostMap.entrySet()) {
            totalRecords += entry.getValue().size();
        }
    } else {
        Map<String, Integer> contentCostMap = monthlyContentCostMap.get(selectedMonth);
        if (contentCostMap != null) {
            totalRecords = contentCostMap.size();
        }
    }
    
    // 计算总页数
    int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
    
    // 获取当前页码，默认为第一页
    int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
    
    // 计算记录列表的起始索引和结束索引
    int startIndex = (currentPage - 1) * recordsPerPage;
    int endIndex = Math.min(startIndex + recordsPerPage, totalRecords);
    
    // 从统计后的月份记录中提取当前页要显示的记录列表
    List<Record> currentPageRecords = new ArrayList<>();
    int idCounter = startIndex + 1; // ID 计数器
    int currentCount = 0; // 当前记录计数器

    if ("all".equals(selectedMonth)) {
        // 显示所有月份的记录
        for (String month : sortedMonths) {
            Map<String, Integer> contentCostMap = monthlyContentCostMap.get(month);
            for (Map.Entry<String, Integer> entry : contentCostMap.entrySet()) {
                if (currentCount >= startIndex && currentCount < endIndex) {
                    currentPageRecords.add(new Record(null, entry.getKey(), entry.getValue(), null, new SimpleDateFormat("yyyy-MM").parse(month), null));
                }
                currentCount++;
            }
        }
    } else {
        // 只显示选定月份的记录
        Map<String, Integer> contentCostMap = monthlyContentCostMap.get(selectedMonth);
        if (contentCostMap != null) {
            for (Map.Entry<String, Integer> entry : contentCostMap.entrySet()) {
                if (currentCount >= startIndex && currentCount < endIndex) {
                    currentPageRecords.add(new Record(null, entry.getKey(), entry.getValue(), null, new SimpleDateFormat("yyyy-MM").parse(selectedMonth), null));
                }
                currentCount++;
            }
        }
    }
    
 	// 设置 request 属性用于 chart.jsp
    request.setAttribute("records", currentPageRecords);
    request.setAttribute("selectedMonth", selectedMonth);
%>
    
<!DOCTYPE html>
<html lang="zh">
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/purecss@3.0.0/build/pure-min.css">
    <link rel="stylesheet" href="/JavaWeb/css/buttons.css">
    <link rel="stylesheet" href="/JavaWeb/css/record_summary.css">
    <link rel="stylesheet" href="/JavaWeb/css/chart.css">
    <link href="../images/pig.ico" rel="shortcut icon"/>
    <meta charset="UTF-8">
    <title>統計結果</title>    
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);
	  
   // 建立資料表格
      function drawChart() {
    	  
		// 从JSP中获取selectedMonth
		  var selectedMonth = '<%= selectedMonth %>';
		  var data = google.visualization.arrayToDataTable([
	            ['Type', 'Cost'],
	            <% 
	                if ("all".equals(selectedMonth)) {
	                    for (Map.Entry<String, Integer> entry : aggregatedRecords.entrySet()) {
	                        out.print("['" + entry.getKey() + "', " + entry.getValue() + "],");
	                    }
	                } else {
	                    Map<String, Integer> contentCostMap = monthlyContentCostMap.get(selectedMonth);
	                    if (contentCostMap != null) {
	                        for (Map.Entry<String, Integer> entry : contentCostMap.entrySet()) {
	                            out.print("['" + entry.getKey() + "', " + entry.getValue() + "],");
	                        }
	                    }
	                }
	            %>
	        ]);
		
		  // 建立視覺化圖形的大小及標題
	        var options = {
	            title: '金額與種類','width':600,'height':400
	        };

          var chart = new google.visualization.PieChart(document.getElementById('piechart'));

          chart.draw(data, options);
      }
    </script>
    
</head>
<body>
	<header class="pure-form">
        <h2>統計結果</h2>
        
        <!-- 下拉式選單(篩選式) -->
        <form action="" method="get">
            <label for="monthSelect">Select Month:</label>
            <select id="monthSelect" name="selectedMonth" onchange="this.form.submit()">
                <option value="all" <% if (selectedMonth == null || "all".equals(selectedMonth)) out.println("selected"); %>>All</option>
                <% for (String month : sortedMonths) { %>
                    <option value="<%= month %>" <% if (month.equals(selectedMonth)) out.println("selected"); %>><%= month %></option>
                <% } %>
            </select>
            <!--    <button type="submit" class="pure-button button-secondary">確認</button>    -->
        </form><br>
		
		<!-- 表格(選單對應表格) -->
          <table class="pure-table pure-table-bordered">
              <thead>
              <tr>
                  <th>Id</th>
                  <th>Content</th>
                  <th>Cost</th>
                  <th>Cost Month</th>
              </tr>
              </thead>
              <tbody>
              <% 
                  for (Record record : currentPageRecords) { 
              %>
                  <tr>
                      <td><%= idCounter++ %></td>
                      <td><%= record.getType() %></td>
                      <td><%= record.getCost() %></td>
                      <td><%= new SimpleDateFormat("yyyy-MM").format(record.getCostDate()) %></td>
                  </tr>
              <% } %>
              </tbody>
              <tfoot>
              <tr>
                  <td colspan="2" >Total Cost</td>
                  <td><%= selectedMonth != null && monthlyTotalCostMap.containsKey(selectedMonth) ? monthlyTotalCostMap.get(selectedMonth) : totalCost %></td>
                  <td></td>
              </tr>
              </tfoot>
          </table>
  
          <!-- 分頁按鈕、連結 -->
        
           <section>
           	<figure>
                <% if (currentPage > 1) { %>
                    <a href="?page=<%= currentPage - 1 %>&selectedMonth=<%= selectedMonth %>">前一頁</a>
                <% } %>
                
                <% for (int i = 1; i <= totalPages; i++) { %>
                    <% if (i == currentPage) { %>
                        <%= i %>
                    <% } else { %>
                        <a href="?page=<%= i %>&selectedMonth=<%= selectedMonth %>"><%= i %></a>
                    <% } %>
                <% } %>
                
                <% if (currentPage < totalPages) { %>
                    <a href="?page=<%= currentPage + 1 %>&selectedMonth=<%= selectedMonth %>">下一頁</a>
                <% } %>	 
           	</figure>
            <span>
           		<a href="/JavaWeb/record" class="pure-button">返回</a>
			</span>                         
    	</section>
	</header>
	
	<footer>
		<h2>圓餅圖</h2>
	
		<!-- 圓餅圖 -->
		<div id="piechart" style="width: 400px; height: 600px;"></div>
	</footer>
				
	</body>
</html>