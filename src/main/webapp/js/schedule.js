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