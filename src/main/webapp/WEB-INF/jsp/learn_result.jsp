<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>倒數計時</title>
    <link rel="stylesheet" type="text/css" href="/JavaWeb/css/learn_result.css">
    <link href="images/clock.ico" rel="shortcut icon"/>
    <script src="/JavaWeb/js/learn_result.js"></script>
</head>
<body>
<h2>倒數計時</h2>

<!-- 回合信息 -->
<div id="roundInfo"></div>
<br>

<!-- 学习时间倒计时 -->
<div class="countdown-container">
    <div class="countdown-item" id="studyCountdown">
        <span id="hours"></span>:<span id="minutes"></span>
    </div>
</div>
<br>

<!-- 休息时间倒计时 -->
<div class="countdown-container">
    <div class="countdown-item" id="restCountdown" style="display:none;"></div>
</div>

<!-- 图片动画 -->
<!--  
<img id="animationFrame" class="animation-frame" src="/JavaWeb/images/countdown_animation_1.png">
-->

<!-- 返回按钮 -->
<a href="/JavaWeb/learn" id="backButton" >返回</a>

<script>
    window.onload = function () {
        // 从后端获取总学习时长和回数
        var studyDuration = <%= request.getAttribute("studyDuration") %>;
        var bouts = <%= request.getAttribute("bouts") %>;

        // 检查studyDuration和bouts是否有效
        if (isNaN(studyDuration) || studyDuration <= 0) {
            studyDuration = 0;
        }
        if (isNaN(bouts) || bouts <= 0) {
            bouts = 1;
        }

        // 开始倒计时
        startCountdown(bouts, studyDuration);
    };
</script>
</body>
</html>
