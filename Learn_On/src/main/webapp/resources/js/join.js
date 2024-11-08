//****************생년월일****************
$(document).ready(function() {
		for (let i = 2000; i > 1980; i--) {
			$('#year').append('<option value="' + i + '">' + i + '</option>');
		}
		for (let i = 1; i < 13; i++) {
			$('#month').append('<option value="' + i + '">' + i + '</option>');
		}
		for (let i = 0; i < 32; i++){
			$('#day').append('<option value ="' + i + '">' + i + '</option>');
		}
	}
	);

// 이메일 구현중...
$(document).ready(function() {
	$("#emailDmain").change(function() {
		$("#email2").val(("#emailDmain").val());
	});
});


// *************유효성 검사**************
// ************* 검사**************
// ************* 검사**************

let checkName = false;
let checkId = false;
let checkPasswd1 = false;
let checkPasswd2 = false;
let checkNic = false;
let checkGender = false;
let checkAddr = false;
let checkMail = false;
let checkCode = false;

// ************* 이름 null 검사**************
function checkNameLength(){
	let name = $("#MEM_NAME").val();
	if(name == "" ){
		$("#checkName").text("이름을 입력해주세요.");	
		$("#checkName").css("color","red");	
		checkName=false;	
	}
}

// ************* 아이디 길이검사**************
function checkIdLength (){
	let id = $("#MEM_ID").val();
	if(id.length >= 4 && id.length <= 8){
		$("#checkId").text("사용가능한 아이디입니다.");
		$("#checkId").css("color","green");
		checkId = true;
	}else if(id == ""){
		$("#checkId").text("아이디를 입력해주세요");
		$("#checkId").css("color","red");
		checkId = false;
	}else {
		$("#checkId").text("4~8 글자만 사용 가능합니다");
		$("#checkId").css("color","red");
		checkId = false;
	}
}

// ************* 비밀번호 길이검사**************

function checkPasswdLength1(){
	let passwd = $("#MEM_PASSWD1").val();
	if(passwd.length >= 4 && passwd.length <= 8){
		$("#checkPasswd1").text("사용가능한 비밀번호 입니다");
		$("#checkPasswd1").css("color","green");
		checkPasswd1 = true;
	}else if(passwd == "") {
		$("#checkPasswd1").text("비밀번호를 입력해주세요.");
		$("#checkPasswd1").css("color","red");
		checkPasswd1 = false;
	}else {
		$("#checkPasswd1").text("4-8자리 이하 영문 대문자,숫자,특수문자 중 2종류 포함 해주세요");
		$("#checkPasswd1").css("color","red");
		checkPasswd1 = false;
	}
}
// ************* 비밀번호 검사**************

function checkPasswdResult(){
	let passwd1 = $("#MEM_PASSWD1").val();
	let passwd2 = $("#MEM_PASSWD2").val();
	if(passwd1 == passwd2){
		$("#checkPasswd2").text("비밀번호가 일치합니다.");
		$("#checkPasswd2").css("color","green");
	}else {
		$("#checkPasswd2").text("비밀번호가 일치하지 않습니다.");
		$("#checkPasswd2").css("color","red");
		
	}
}