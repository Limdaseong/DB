var now = new Date(); // 현재 날짜와 시간
var firstDate = new Date("2019-12-25"); // 설정 날짜, 2019년 12월 25일 설정
//console.log(firstDate);
//console.log(now);
//console.log(firstDate.toLocaleString());
//console.log(now.toLocaleString());
var start = firstDate.getTime(); // 기념일의 밀리세컨드를 구함, 1000분의 1초
var end = now.getTime() // 오늘의 밀리세컨드를 구함.
var pass = end - start; // 오늘 - 기념일 -> 경과시간의 밀리세컨드
var passDay = Math.floor(pass/1000/60/60/24); // 경과시간의 일
document.querySelector('#passDay').innerHTML = passDay;

// 경과시간에 대한 확인
// console.log(pass + " ms"); // 밀리세컨드
// console.log(pass/1000 + " 초") // 초
// console.log(pass/1000/60 + " 분") // 분
// console.log(pass/1000/60/60 + " 시간") // 시간
// console.log(pass/1000/60/60/24 + " 일") // 시간
// console.log(Math.floor(pass/1000/60/60/24) + " 일") // 소수점 이하를 버림

calcDay(100);
calcDay(200);
calcDay(365);
calcDay(500);
calcDay(730);
calcDay(1000);

function calcDay(days) {
// 전달받은 일을 밀리세컨드로 바꿔야함. days(일)를 days(밀리세컨드)로 변경
var days2 = days*1000*60*60*24; // 일을 밀리세컨드로 변경
var passDay2 = start + days2; // 기념일에서 경과일(예, 100일)을 더한 밀리세컨드

// 밀리세컨드를 Date 객체로 다시 만들어주어야함. -> 년월일을 구하기 위해서
var someDate = new Date(passDay2);
// 확인
//console.log(someDate);
//console.log(someDate.toLocaleString());

// 년월일을 구함
var year = someDate.getFullYear();
var month = someDate.getMonth() + 1;
var day = someDate.getDate();
console.log(year + "년 " + month + "월 " + day + "일");

// 월을 2자리로 만듦
var month2 = "";
if(month < 10) {
    month2 = "0".concat(month);
} else { 
    month2 = month;
}

// 일을 2자리로 만듦
var day2 = "";
if(day < 10) {
    day2 = "0".concat(day);
} else {
    day2 = day;
}

document.querySelector("#date"+days).innerHTML = year + "년 " + month2 + "월 " + day2 + "일";
}
