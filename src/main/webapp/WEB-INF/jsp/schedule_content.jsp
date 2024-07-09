<%@ page import="java.util.List"%>
<%@ page import="schedule.model.Schedule"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Collections"%>
<%@ page import="java.util.Comparator"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    List<Schedule> schedules = (List<Schedule>)request.getAttribute("schedules");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    // 根据 StartDate 进行排序，按月份和日期的顺序排列
    Collections.sort(schedules, new Comparator<Schedule>() {
        public int compare(Schedule r1, Schedule r2) {
            int monthComparison = Integer.compare(r1.getStarDate().getMonth(), r2.getStarDate().getMonth());
            if (monthComparison != 0) {
                return monthComparison;
            } else {
                return Integer.compare(r1.getStarDate().getDate(), r2.getStarDate().getDate());
            }
        }
    });

    // 分頁相關設定
    int pageSize = 10;
    int totalSchedules = schedules.size();
    int totalPages = (int) Math.ceil((double) totalSchedules / pageSize);
    int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
    int startScheduleIndex = (currentPage - 1) * pageSize;
    int endScheduleIndex = Math.min(startScheduleIndex + pageSize, totalSchedules);

    List<Schedule> currentPageSchedules = schedules.subList(startScheduleIndex, endScheduleIndex);

    // 自動遞補的 ID 變數
    int autoIncrementId = startScheduleIndex + 1;
%>

<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/purecss@3.0.0/build/pure-min.css">
        <link rel="stylesheet" href="/JavaWeb/css/buttons.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">		
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <meta charset="UTF-8">
        <title>事件表</title>
    </head>
    <body>
    	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
		
		<script>
        function confirmDelete(deleteUrl) {
            Swal.fire({
                title: '確定要刪除這條記錄嗎？',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: '是的，刪除它！',
                cancelButtonText: '取消'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = deleteUrl;
                }
            });
            return false;
        }
    	</script>
        
        <h2>事件表</h2>
        <table class="pure-table pure-table-bordered">
            <thead>
                <tr>
                    <th>編號</th>
                    <th>事件名稱</th>
                    <th>開始日期</th>
                    <th>結束日期</th>
                    <th>內容備註</th>
                    <th>更新</th>
                    <th>刪除</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    for (Schedule schedule : currentPageSchedules) { 
                %>
                <tr>
                    <td><%= autoIncrementId++ %></td>
                    <td><%= schedule.getEventName() %></td>
                    <td><%= sdf.format(schedule.getStarDate()) %></td>
                    <td><%= schedule.getEndDate() !=null ? sdf.format(schedule.getEndDate()) : sdf.format(schedule.getStarDate()) %></td>
                    <td class="note"><%= schedule.getDescription() %></td>
                    <td><a href="/JavaWeb/schedule/update?updateId=<%= schedule.getId() %>" class="button-primary pure-button">更新</a></td>
                    <td><a href="javascript:void(0);" class="button-error pure-button" onclick="return confirmDelete('/JavaWeb/schedule?deleteId=<%= schedule.getId() %>');">刪除</a></td>
                </tr>
                <% } %>                               
            </tbody>
        </table>
        
        <!-- 分頁按鈕、連結 -->
        <section>
            <ul class="pagination justify-content-center">
		                <% if (currentPage > 1) { %>
		                    <li class="page-item">
		                        <a class="page-link" href="?page=<%= currentPage - 1 %>" aria-label="Previous">
		                            <span aria-hidden="true">&laquo; 前一頁</span>
		                        </a>
		                    </li>
		                <% } %>
		                
		                <% 
		                    int startPage = Math.max(1, currentPage - 1);
		                    int endPage = Math.min(totalPages, currentPage + 1);
		                %>
		                
		                <% if (startPage > 1) { %>
		                    <li class="page-item">
		                        <a class="page-link" href="?page=1">1</a>
		                    </li>
		                    <% if (startPage > 2) { %>
		                        <li class="page-item disabled"><span class="page-link">...</span></li>
		                    <% } %>
		                <% } %>
		                
		                <% for (int i = startPage; i <= endPage; i++) { %>
		                    <li class="page-item <%= i == currentPage ? "active" : "" %>">
		                        <a class="page-link" href="?page=<%= i %>"><%= i %></a>
		                    </li>
		                <% } %>
		                
		                <% if (endPage < totalPages) { %>
		                    <% if (endPage < totalPages - 1) { %>
		                        <li class="page-item disabled"><span class="page-link">...</span></li>
		                    <% } %>
		                    <li class="page-item">
		                        <a class="page-link" href="?page=<%= totalPages %>"><%= totalPages %></a>
		                    </li>
		                <% } %>
		                
		                <% if (currentPage < totalPages) { %>
		                    <li class="page-item">
		                        <a class="page-link" href="?page=<%= currentPage + 1 %>" aria-label="Next">
		                            <span aria-hidden="true">下一頁 &raquo;</span>
		                        </a>
		                    </li>
		                <% } %>      
		                
		                <form method="get" class="form-inline" id="page">
		                	<label>　前往第<input type="text" size="1" name="page" onkeyup="return keynum1(this,value)">頁</label>
		            	</form>          
		            </ul>
        </section>
        
    </body>
</html>
