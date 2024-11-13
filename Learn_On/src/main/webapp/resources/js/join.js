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
	$("#emaildmain").change(function() {
		$("#mem_email2").val($("#emaildmain").val());
	});
});




// *************유효성 검사**************
// ************* 검사**************

let checkName = false;
let checkPasswd1 = false;
let checkPasswd2 = false;
let checkNic = false;
let checkNumber = false;
let checkAddr = false;
let checkMail = false;
let checkCode = false;
let checkIdResult = false;

// ************* 이름 null 검사**************
function checkNameLength(){
	let name = $("#mem_name").val();
	if(name == "" ){
		$("#checkName").text("이름을 입력해주세요.");	
		$("#checkName").css("color","red");	
		checkName=false;	
	}
}

// ************* 아이디 중복체크/길이검사**************
function checkId(){
	let id = $("#mem_id").val();
	let regex = /^[\d\w][\d\w_]{4,8}$/;
	if(regex.exec(id)){
		$.ajax({
			type : "get" ,
		   	 url : "MemberCheckId" ,
		   	data : {
			MEM_ID:id
		} ,
			success : function(result){
				
				if(result.trim() == "false"){
					$("#checkIdResult").text("사용가능한 아이디 입니다.").css("color","GREEN");
					checkIdResult = true;
				}else{
					$("#checkIdResult").text("이미 있는 아이디 입니다.").css("color","RED");
					checkIdResult = false;
				}
			} ,
			error : function(){
				alert("일시적인 서비스 장애로\n아이디 중복검사 불가")
			}
		});
	}else{
		$("#checkIdResult").text("4~8글자만 사용가능");
		$("#checkIdResult").css("color", "red");
		checkIdResult = false;
	}
}

//function checkIdLength (){
//	let id = $("#MEM_ID").val();
//	if(id.length >= 4 && id.length <= 8){
//		$("#checkId").text("사용가능한 아이디입니다.");
//		$("#checkId").css("color","green");
//		checkId = true;
//	}else if(id == ""){
//		$("#checkId").text("아이디를 입력해주세요");
//		$("#checkId").css("color","red");
//		checkId = false;
//	}else {
//		$("#checkId").text("4~8 글자만 사용 가능합니다");
//		$("#checkId").css("color","red");
//		checkId = false;
//	}
//}

// ************* 비밀번호 길이검사**************

function checkPasswdLength1(){
	let passwd = $("#mem_passwd1").val();
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
	let passwd1 = $("#mem_passwd1").val();
	let passwd2 = $("#mem_passwd2").val();
	if(passwd1 == ""){
		$("#checkPasswd2").text("비밀번호를 입력해주세요.");
		$("#checkPasswd2").css("color","red");
	}else if(passwd1 == passwd2){
		$("#checkPasswd2").text("비밀번호가 일치합니다.");
		$("#checkPasswd2").css("color","green");
	}else {
		$("#checkPasswd2").text("비밀번호가 일치하지 않습니다.");
		$("#checkPasswd2").css("color","red");
		
	}
}
// *************연락처 null검사**************
function numberCk(){
	let number = $("#mem_number").val();
	if(number == ""){
		$("#checkNumber").text("핸드폰 번호를 입력해주세요");
		$("#checkNumber").css("color","red");
	}
	
}
// *************이용약관 체크**************
$(document).ready(function() {
$("#terms_all").click(function() {
		// 전체선택을 제외한 나머지 체크박스에 대한 반복 수행
		$("input[name=terms]").each(function(index, item) {
			// 전체선택 체크박스 체크상태값을 각 체크박스 체크상태값으로 설정
			$(item).prop("checked", $("#terms_all").prop("checked"));
		});
		
	});
});
//
//	document.querySelector("#terms_all").onclick = function() {
//	    let isChecked = document.querySelector("#terms_all").checked;
//	    let termsCheckboxes = document.querySelectorAll("input[name='terms']");
//	    
//	    for (let checkbox of termsCheckboxes) {
//	console.log("join.js 파일이 로드되었습니다.");
//	        checkbox.checked = isChecked;
//	    }
//	};