<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/purecss@3.0.0/build/pure-min.css">
	<link rel="stylesheet" href="/JavaWeb/css/buttons.css">
	<link rel="stylesheet" href="/JavaWeb/css/learn_finish.css">
    <meta charset="UTF-8">
    <link href="images/clock.ico" rel="shortcut icon"/>
    <title>待辦清單</title>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>已完成所有的回合</h2>
            <a href="/JavaWeb/learn"><button class="pure-botton pure-button-primary">返回主頁</button></a>
            <hr>
        </div>
        
        <div class="task-list">
            <p>今日待辦事項</p>
        
            <div id="tasksContainer">
                <%-- 读取 localStorage 中的数据并显示 --%>
                <script>
                    window.onload = function() {
                        var formData = JSON.parse(localStorage.getItem('formData'));
                        if (formData && formData['tasks']) {
                            var tasks = formData['tasks'];
                            tasks.forEach(function(task, index) {
                                var div = document.createElement('div');
                                div.classList.add('task-item');

                                // 创建复选框和文本节点
                                var checkbox = document.createElement('input');
                                checkbox.type = 'checkbox';
                                checkbox.value = index; // 使用索引作为复选框的值
                                checkbox.id = 'task_' + index;
                                checkbox.checked = formData['completionState'] && formData['completionState'][checkbox.id]; // 恢复选中状态
                                checkbox.onclick = function() {
                                    saveCompletion(this.id, this.checked);
                                };

                                var label = document.createElement('label');
                                label.setAttribute('for', checkbox.id);
                                label.textContent = task;

                                div.appendChild(checkbox);
                                div.appendChild(label);
                                document.getElementById('tasksContainer').appendChild(div);
                            });
                        }
                    };
                    
                    function saveCompletion(id, isChecked) {
                        var formData = JSON.parse(localStorage.getItem('formData')) || {};
                        formData['completionState'] = formData['completionState'] || {};
                        formData['completionState'][id] = isChecked;
                        localStorage.setItem('formData', JSON.stringify(formData));
                    }

                </script>
            </div>
        </div>
    </div>
</body>
</html>
