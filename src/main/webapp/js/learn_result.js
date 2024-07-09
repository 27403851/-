// learn_result.js

function startStudyCountdown(duration, studyDisplay, restDisplay, remainingBouts, currentBout, callback) {
    var studyTimer = duration, studyMinutes, studySeconds;

    var studyInterval = setInterval(function () {
        studyMinutes = parseInt(studyTimer / 60, 10);
        studySeconds = parseInt(studyTimer % 60, 10);

        studyMinutes = studyMinutes < 10 ? "0" + studyMinutes : studyMinutes;
        studySeconds = studySeconds < 10 ? "0" + studySeconds : studySeconds;

        studyDisplay.textContent = studyMinutes + ":" + studySeconds;

        // 在每一秒钟更新动画图片
        updateAnimationFrame(studyTimer, duration);

        if (--studyTimer < 0) {
            clearInterval(studyInterval); // 学习时间倒计时结束
            studyDisplay.style.display = 'none'; // 隐藏学习时间倒计时
            restDisplay.style.display = 'block'; // 显示休息时间倒计时
            startRestCountdown(1 * 5, restDisplay, remainingBouts, currentBout, callback); // 开始休息时间倒计时（1分钟）
        }
    }, 1000);
}

function startRestCountdown(duration, display, remainingBouts, currentBout, callback) {
    var restTimer = duration, restMinutes, restSeconds;

    var restInterval = setInterval(function () {
        restMinutes = parseInt(restTimer / 60, 10);
        restSeconds = parseInt(restTimer % 60, 10);

        restMinutes = restMinutes < 10 ? "0" + restMinutes : restMinutes;
        restSeconds = restSeconds < 10 ? "0" + restSeconds : restSeconds;

        display.textContent = restMinutes + ":" + restSeconds;

        // 在每一秒钟更新动画图片
        updateAnimationFrame(restTimer, duration);

        if (--restTimer < 0) {
            clearInterval(restInterval); // 休息时间倒计时结束
            if (remainingBouts > 1) {
                callback(remainingBouts - 1, currentBout + 1); // 递减回数并继续下一个回合
            } else {
                display.textContent = "--:--";
                window.location.href = "/JavaWeb/learn_finish"; // 倒计时结束，跳转到 learn_finish 页面
            }
        }
    }, 1000);
}

function updateAnimationFrame(timer, totalDuration) {
    var animationFrame = document.getElementById('animationFrame');
    if (animationFrame) {
        animationFrame.style.display = 'block'; // 确保图片显示
        var totalFrames = 10; // 假设我们有10张动画图片
        var currentFrame = Math.floor((totalDuration - timer) / totalDuration * totalFrames) + 1;
        currentFrame = Math.min(currentFrame, totalFrames); // 确保currentFrame不超过totalFrames
        animationFrame.src = "/JavaWeb/images/countdown_animation_" + currentFrame + ".png";
    }
}

function startCountdown(bouts, studyDuration) {
    var studyDisplay = document.querySelector('#studyCountdown');
    var restDisplay = document.querySelector('#restCountdown');
    var roundInfo = document.querySelector('#roundInfo');

    function nextBout(remainingBouts, currentBout) {
        roundInfo.textContent = "現在是第 " + currentBout + " 回合";
        studyDisplay.style.display = 'block';
        restDisplay.style.display = 'none';
        startStudyCountdown(studyDuration, studyDisplay, restDisplay, remainingBouts, currentBout, nextBout);
    }

    nextBout(bouts, 1);
}
