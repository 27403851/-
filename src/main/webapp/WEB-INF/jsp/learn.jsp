<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/purecss@3.0.0/build/pure-min.css">
    <link rel="stylesheet" href="/JavaWeb/css/buttons.css">
    <link rel="stylesheet" href="/JavaWeb/css/learn.css">
    <link href="images/clock.ico" rel="shortcut icon"/>
    <meta charset="UTF-8">
    <title>動態表單</title>

    <script>
        // 加載頁面時檢查並填充表單數據
        window.onload = function() {
            loadFormData(); // 加載表單數據
        };

        // 添加输入框
        function addInput() {
            var form = document.getElementById('work');
            var inputContainers = form.querySelectorAll('.input-container');

            // 检查当前已存在的输入框数量
            if (inputContainers.length < 6) {
                var inputContainer = document.createElement('div'); // 创建一个容器元素
                inputContainer.classList.add('input-container'); // 添加样式类名

                // 创建文本节点并添加到容器中
                var label = document.createTextNode('項目:');
                inputContainer.appendChild(label);

                // 创建输入框并设置属性
                var input = document.createElement('input');
                input.type = 'text';
                input.name = 'tasks'; // 设置输入框的名称
                input.required = true; // 设置为必填
                inputContainer.appendChild(input); // 将输入框添加到容器中

                form.insertBefore(inputContainer, form.querySelector('button[type="button"]')); // 将容器添加到按钮之前
            }

            // 如果已经有六个输入框，则禁用新增按钮
            if (inputContainers.length === 5) {
                var addButton = form.querySelector('button[type="button"]');
                addButton.disabled = true;
            }
        }

        // 将输入框的值添加到第二个表单的下拉列表中
        function addToList() {
            var form = document.getElementById('work');
            var inputs = form.querySelectorAll('input[name="tasks"]');
            var selectContent = document.getElementById('content');

            inputs.forEach(function(input) {
                if (input.value.trim() !== '') {
                    var option = document.createElement('option');
                    option.value = input.value;
                    option.textContent = input.value;
                    selectContent.appendChild(option);
                }
            });
            // 设置form1的输入框为只读并应用样式
            setInputsReadOnly();
        }

        // 设置form1的输入框为只读并应用样式
        function setInputsReadOnly() {
            var form = document.getElementById('work');
            var inputs = form.querySelectorAll('input[name="tasks"]');
            inputs.forEach(function(input) {
                input.readOnly = true;
            });
        }

        // 重置表单内容
        function resetForm() {
            var form = document.getElementById('work');
            var inputs = form.querySelectorAll('input[name="tasks"]');
            inputs.forEach(function(input) {
                input.value = ''; // 清空输入框的值
                input.readOnly = false; // 恢复输入框为可编辑状态
            });

            var selectContent = document.getElementById('content');
            selectContent.innerHTML = ''; // 清空select内容
            var defaultOption = document.createElement('option');
            defaultOption.value = '';
            defaultOption.textContent = '選擇或添加';
            selectContent.appendChild(defaultOption); // 添加初始选项

            selectContent.selectedIndex = 0; // 将下拉列表重置为初始选项
        }

        // 保存表单数据到 localStorage
        function saveFormData() {
            var form = document.getElementById('work');
            var formData = {};
            formData['tasks'] = [];

            // Collect input values
            var inputs = form.querySelectorAll('input[name="tasks"]');
            inputs.forEach(function(input) {
                formData['tasks'].push(input.value);
            });

            // Save to localStorage
            localStorage.setItem('formData', JSON.stringify(formData));
        }

        // 加載表單數據
        function loadFormData() {
            var formData = JSON.parse(localStorage.getItem('formData'));
            if (formData && formData['tasks']) {
                var form = document.getElementById('work');
                var inputs = form.querySelectorAll('input[name="tasks"]');
                formData['tasks'].forEach(function(value, index) {
                    if (index < inputs.length) {
                        inputs[index].value = value;
                    } else {
                        // Add new input container if more inputs than existing
                        addInput();
                        inputs = form.querySelectorAll('input[name="tasks"]');
                        inputs[index].value = value;
                    }
                });
                // Update select options in form 2
                updateForm2Select(formData['tasks']);
            }
        }

        // 更新第二个表单的下拉列表
        function updateForm2Select(tasks) {
            var selectContent = document.getElementById('content');
            tasks.forEach(function(task) {
                var option = document.createElement('option');
                option.value = task;
                option.textContent = task;
                selectContent.appendChild(option);
            });
        }

        // 清除表单数据
        function clearFormData() {
            localStorage.removeItem('formData');
        }
    </script>
</head>

<body>
<section id="form1">
    <h2>學習清單</h2>
    <hr>
    <form action="#" id="work" name="work">
        <div class="input-container">
            項目:<input type="text" name="tasks" required> <!-- 第一个输入框 -->
        </div>
        <button type="button" id="buttonset" onclick="addInput()" class="pure-button pure-button-primary">新增</button> <!-- 新增输入框按钮 -->
        <button type="button" id="buttonset" onclick="addToList(); saveFormData();" class="pure-button pure-button-primary">確認</button> <!-- 确认按钮 -->
        <button type="button" id="buttonset" onclick="resetForm(); clearFormData();" class="pure-button">重置</button> <!-- 重置按钮 -->
    </form>
</section>

<section id="form2">
    <form class="pure-form" action="/JavaWeb/learn" method="post" id="learnForm">
        <h2>選擇計時器</h2>
        <hr>
        <label>使用日期:</label>
        <input id="today" name="today" type="date" required readonly>
        <p>
            <script>
                // 取得今天的日期
                var today = new Date();
                // 格式化日期为 yyyy-MM-dd
                var formattedDate = today.toISOString().split('T')[0];
                // 设置输入框的值为当前日期
                document.getElementById('today').value = formattedDate;
            </script>

        <label for="eventContent">項目內容:</label>
        <select id="content" name="content" required>
            <!-- 初始选项 -->
            <option value="">選擇或添加</option>
        </select>
        <p>

        <label>選擇時間:</label>
        <select id="time" name="time" required>
            <option value="">專注時間</option>
            <option value="25分鐘">25分鐘</option>
            <option value="40分鐘">40分鐘</option>
            <option value="55分鐘">55分鐘</option>
            <option value="5秒鐘">5秒鐘</option>
        </select>
        <p>

        <label>選擇次數:</label>
        <select id="bout" name="bout" required>
            <option value="">專注次數</option>
            <option value="1" data-text="1回">1</option>
            <option value="2" data-text="2回">2</option>
            <option value="3" data-text="3回">3</option>
            <option value="4" data-text="4回">4</option>
        </select>
        <p>

        <input type="hidden" id="totalDuration" name="totalDuration" value="">

        <div>
            <button type="submit" class="pure-button pure-button-primary">開始</button>
            <button type="button" class="pure-button" onclick="clearForm()">清除</button>
        </div>

        <!-- 返回首頁 -->
        <aside>
            <a href="/JavaWeb/default.html" class="pure-button">
                <img src="images/home.png" width="60" height="60">
            </a>
        </aside>
    </form>
</section>

</body>
</html>
