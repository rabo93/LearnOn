$("#addForm").on("submit", function() {
	let class_title = $("#class_title").val();
	let class_intro = $("#class_intro").val();
	let class_contents = $("#class_contents").val();
	let teacher = $("#teacher").val();
	let cur_title = $("#cur_title").val();
	let cur_runtime = $("#cur_runtime").val();
	let classPrice = $("#classPrice").val();
	
	if(class_title == "") {
		alert("제목을 입력해주세요");
		$("#class_title").focus();
		return false; // submit 동작 취소
	} else if(class_intro == "") {
		alert("소개를 입력해주세요");
		$("#class_intro").focus();
		return false; // submit 동작 취소
	} else if(class_contents == "") {
		alert("상세내용을 입력해주세요");
		$("#class_contents").focus();
		return false;
	} else if(teacher == "") {
		alert("강사를 입력해주세요")
		$("#teacher").focus();
		return false;
	} else if(cur_title == "") {
		alert("영상 길이를 입력해주세요")
		$("#cur_title").focus();
		return false;
	} else if(cur_runtime == "") {
		alert("영상 길이를 입력해주세요")
		$("#cur_runtime").focus();
		return false;
	} else if(cur_runtime == "") {
		alert("영상 길이를 입력해주세요")
		$("#cur_runtime").focus();
		return false;
	} else if(classPrice == "") {
		alert("가격을 입력해주세요")
		$("#classPrice").focus();
		return false;
	}
	
})