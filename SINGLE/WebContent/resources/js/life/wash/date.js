/*=======================================================================
파일명		: date.js
내용		    : 날짜 함수 라이브러리
작성자		: 
최초작성일        : 
최종수정일        : 
========================================================================*/

var DAY_KOR_NAMES = new Array('일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일');

var date = new Date();
var sDate = date.getFullYear()+"-"+ (leadingZeros(date.getMonth() + 1),2) +"-"+ leadingZeros(date.getDate(),2);
var printFirst  =  date_add(sDate, 1) + " " + DAY_KOR_NAMES[getDayKorNames(1)]; 
var printSecond =  date_add(sDate, 2) + " " + DAY_KOR_NAMES[getDayKorNames(2)];
var printThird  =  date_add(sDate, 3) + " " + DAY_KOR_NAMES[getDayKorNames(3)];
var printFourth =  date_add(sDate, 4) + " " + DAY_KOR_NAMES[getDayKorNames(4)];
 

/*=======================================================================
함수명		: getDayKorNames
내용		: 오늘 요일로부터 arg를 더하는데 초과하는 요일을 맞게 계산해줌.
파라미터	: num
리턴값		: num
작성자		: 
최초작성일  : 
최종수정일  : 
========================================================================*/
function getDayKorNames(arg){
	var day = date.getDay()+arg;
	
	if(day>DAY_KOR_NAMES.length-1){
		day-=DAY_KOR_NAMES.length;
	}
	return day;
}


/*=======================================================================
함수명		: setTime
내용		: reserv_wash_select 페이지에서 날짜를 입력하면 매개변수를 받아 DB 입력가능값으로 리턴
파라미터	: num
리턴값		: OOOOOOOOOOOOOO (OOOO년 OO월 OO일 OO시 OO분 OO초 순으로 리턴)
작성자		: 
최초작성일  : 
최종수정일  : 
========================================================================*/

function setTime(arg){
	var time = "000000";
	var WASH_TIME = "";
	
	if(arg==1 || arg==5 || arg == 9 || arg == 13){
		time = "160000";
	}else if(arg==2 || arg==6 || arg == 10 || arg == 14){
		time = "180000";
	}else if(arg==3 || arg==7 || arg == 11 || arg == 15){
		time = "200000";
	}else if(arg==4 || arg==8 || arg == 12 || arg == 16){
		time = "220000";
	}
	
	if(arg == 1 || arg == 2 || arg == 3 || arg == 4){
		WASH_TIME = date_format(sDate,1) + time;
	}else if(arg == 5 || arg == 6 || arg == 7 || arg == 8){
		WASH_TIME = date_format(sDate,2) + time;
	}else if(arg == 9 || arg == 10 || arg == 11 || arg == 12){
		WASH_TIME = date_format(sDate,3) + time;
	}else if(arg == 13 || arg == 14 || arg == 15 || arg == 16){
		WASH_TIME = date_format(sDate,4) + time;
	}
	return WASH_TIME;
}




/*=======================================================================
함수명		: date_add
내용		: 날짜와 더할일수를 입력하면 월 일 형식으로 리턴
파라미터	: date, num
리턴값		: OO월 OO일
작성자		: 
최초작성일  : 
최종수정일  : 
========================================================================*/
function date_add(sDate, nDays) {

    var yy = parseInt(sDate.substr(0, 4), 10);

    var mm = parseInt(sDate.substr(5, 2), 10);

    var dd = parseInt(sDate.substr(7), 10);

    d = new Date(yy, mm, dd + nDays);

    yy = d.getFullYear();

    mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;

    dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;

    return  mm  + '월'  + dd + '일';

}

/*=======================================================================
함수명		: date_format
내용		: DB INSERT를 위하여 date_add 함수에서 출력형식만 변경
파라미터	: date, num
리턴값		: OOOOOOOO  (0000년00월00일순으로)
작성자		: 
최초작성일  : 
최종수정일  : 
========================================================================*/
function date_format(sDate, nDays) {

    var yy = parseInt(sDate.substr(0, 4), 10);

    var mm = parseInt(sDate.substr(5, 2), 10);

    var dd = parseInt(sDate.substr(7), 10);

    d = new Date(yy, mm, dd + nDays);

    yy = d.getFullYear();

    mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;

    dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;

 

    return  yy + mm  +  dd ; 

}



/*=======================================================================
함수명		: leadingZeros
내용		: 자리수에 0채우기
파라미터	: date, num
리턴값		: 2자리 숫자
작성자		: 
최초작성일  : 
최종수정일  : 
========================================================================*/
function leadingZeros(date, num) {
	 var zero = '';
	 date = date.toString();
	
	 if (date.length < num) {
	  for (i = 0; i < num - date.length; i++)
	   zero += '0';
	 }
	 return zero + date;
}
