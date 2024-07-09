
/*document.addEventListener('DOMContentLoaded', function() {
    var eventTypeSelect = document.getElementById('type');
    var eventContentSelect = document.getElementById('content');
    var eventTimeSelect = document.getElementById('time');
    var eventFrequencySelect = document.getElementById('bout');

    // 保存内容选择的 HTML 内容
    var eventContentOptions = eventContentSelect.innerHTML;
    
    // 項目類別選擇框變化時的事件處理函式
    function eventTypeChangeHandler() {
        var eventType = eventTypeSelect.value;

        // 清空項目內容選擇框
        eventContentSelect.innerHTML = eventContentOptions;
        eventTimeSelect.innerHTML = '';
        eventFrequencySelect.innerHTML = '';

        // 根據選擇的項目類別動態生成選項
        if (eventType === '學科') {
            eventContentSelect.innerHTML = `
                ${eventContentOptions}
                <option value="國文">國文</option>
                <option value="英文">英文</option>
                <option value="數學">數學</option>
            `;
        } else if (eventType === '術科') {
            eventContentSelect.innerHTML = `
                ${eventContentOptions}
                <option value="音樂">音樂</option>
                <option value="體育">體育</option>
                <option value="美術">美術</option>
            `;
        }

        // 啟用項目內容選擇框
        eventContentSelect.disabled = eventType === '';
    }

    // 項目內容選擇框變化時的事件處理函式
    function eventContentChangeHandler() {
        var eventContent = eventContentSelect.value;

        // 清空時間選擇框
        eventTimeSelect.innerHTML = '';
        eventFrequencySelect.innerHTML = '';

        // 根據選擇的項目內容動態生成時間選項
        if (eventContent !== '') {
            eventTimeSelect.innerHTML = `
                <option value="">請選擇</option>
                <option value="25分鐘">25分鐘</option>
                <option value="40分鐘">40分鐘</option>
                <option value="55分鐘">55分鐘</option>
                <option value="1分鐘">1分鐘</option>
            `;
            eventFrequencySelect.innerHTML = `
                <option value="">請選擇</option>
                <option value="1" data-text="1回">1回</option>
                <option value="2" data-text="2回">2回</option>
                <option value="3" data-text="3回">3回</option>
                <option value="4" data-text="4回">4回</option>
            `;
        }

        // 啟用時間和次數選擇框
        eventTimeSelect.disabled = eventContent === '';
        eventFrequencySelect.disabled = eventContent === '';
    }

    // 註冊項目類別和項目內容選擇框變化事件
    eventTypeSelect.addEventListener('change', eventTypeChangeHandler);
    eventContentSelect.addEventListener('change', eventContentChangeHandler);

    // 初次加載時執行一次事件處理函式
    eventTypeChangeHandler();

});

*/
