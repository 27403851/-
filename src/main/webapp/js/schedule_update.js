function clearForm() {
        document.getElementById("eventName").value = ""; // 清除活动名称输入框内容
        document.getElementById("starDate").value = ""; // 清除开始日期输入框内容
        document.getElementById("endDate").value = ""; // 清除结束日期输入框内容
        document.getElementById("eventType").selectedIndex = 0; // 将活动类型下拉框重置为第一个选项
        document.getElementById("description").value = ""; // 清除备注内容输入框内容
    }
    
function validateForm() {
        // 获取开始日期和结束日期的值
        var startDate = new Date(document.getElementById("starDate").value);
        var endDate = new Date(document.getElementById("endDate").value);

        // 比较开始日期和结束日期
        if (endDate < startDate) {
            alert("結束日期不能在開始日期之前，請重新選擇。");
            return false; // 阻止表单提交
        }
        return true; // 允许表单提交
    }