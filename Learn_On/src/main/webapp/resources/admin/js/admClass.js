
// 클래스 등록시 커리큘럼 추가 제거
function addRow() {
	var dynamicTable = document.getElementById('dynamic_table');
	var newRow = dynamicTable.insertRow();
	var cell1 = newRow.insertCell();
	var cell2 = newRow.insertCell();
	var cell3 = newRow.insertCell();
	var cell4 = newRow.insertCell();
	  
	cell1.innerHTML = '<input type="checkbox" name="checkboxObj"/>';
	cell2.innerHTML = '<input type="text" name="cur_title" class="form-control" id="cur_title" placeholder="커리큘럼 제목">';
	cell3.innerHTML = '<input type="number" name="cur_runtime" class="form-control" id="cur_runtime" placeholder="커리큘럼 영상길이">';
	cell4.innerHTML = '<input type="file" name="cur_video_get" class="file form-control" accept="video/*" id="cur_video" placeholder="커리큘럼 영상">';
	
}

function deleteRow() {
	var table = document.getElementById('dynamic_table');
	var checkboxArray = document.getElementsByName('checkboxObj');
	for (var i = checkboxArray.length-1; i>=0; i--) {
		var check = checkboxArray[i].checked;
	   
		if (check) {
			table.deleteRow(i);
		}
	}
}

// 클래스 수정 클래스 id값 가져오기
function modifyClass(elem) {
	console.log("elem : " + elem);
	location.href="AdmClassListModify?class_id=" + elem;
}

// 클래스 삭제 클래스 id값 가져오기
function deleteClass(elem) {
	if (confirm("정말 삭제하시겠습니까?")) {
		location.href="AdmClassListDelete?class_id=" + elem;
	}
}

// 카테고리 수정
function addMainCateRow() {
	var mainCateTable = document.getElementById('mainCateTable');
	var newRow = mainCateTable.insertRow();
	var cell1 = newRow.insertCell();
	var cell2 = newRow.insertCell();
	var cell3 = newRow.insertCell();
	var cell4 = newRow.insertCell();
	var cell5 = newRow.insertCell();
	  
	cell1.innerHTML = '<th><input class="form-check-input" type="checkbox" name="mainCateRowCheck"></th>';
	cell2.innerHTML = '<td><input class="form-control" name="codeid_maincate" type="text" placeholder="아이디"></td>';
	cell3.innerHTML = '<td><input class="form-control" name="codetype_maincate" type="text" placeholder="타입"></td>';
	cell4.innerHTML = '<td><input class="form-control" name="codename_maincate" type="text" placeholder="이름"></td>';
	cell5.innerHTML = '<td><input class="form-control" name="description_maincate" type="text" placeholder="설명"></td>';
}

function deleteMainCateRow() {
	var checkboxArray = document.getElementsByName('mainCateRowCheck');
	for (var i = 0; i < checkboxArray.length; i++) {
		if (checkboxArray[i].checked) {
			if (confirm('삭제하시겠습니까?')) {
				location.href="mainCateDelete?CODEID="
				+ checkboxArray[i].parentElement.parentElement.getElementsByClassName("form-control")[1].value;
			} else {
				return;	
			}
		}
	}
}

function deleteSubCateRow() {
	var checkboxArray = document.getElementsByName('subCateRowCheck');
	for (var i = 0; i < checkboxArray.length; i++) {
		if (checkboxArray[i].checked) {
			if (confirm('삭제하시겠습니까?')) {
				location.href="subCateDelete?old_codetype_subcate="
				+ checkboxArray[i].parentElement.parentElement.getElementsByClassName("form-control")[0].value;
			} else {
				return;	
			}
		}
	}
}

function searchInstructor() {
	var child;
	child = window.open("", "_blank", "height:300, width:300");
}

// 소분류 불러오기
function selectMainCate() {
	let mainCateId = document.querySelector("select[name=class_maincate]").value;
	
	$.ajax({
		type: "GET",
		url: "SelectCategory",
		data: {
			codeid_maincate : mainCateId
		},
		dataType : "json"
	}).done(function(data){
		$("#floatingSelect2").empty();
		for(let item of data) {
			$("#floatingSelect2").append(
				`<option value="${item.NAME_SUBCATE}" ${item.SELECTED}>${item.NAME_SUBCATE}</option>`
			);
		}
	}).fail(function(){
		console.log("에러");
	});
		
}

// 소분류 실행
window.onload=function () {
	let mainCateId = document.querySelector("select[name=class_maincate]").value;
	let classId = window.location.search;
	
	$.ajax({
		type: "GET",
		url: "SelectCategory",
		data: {
			codeid_maincate : mainCateId,
			class_id : Number(classId.substring(10))
		},
		dataType : "json"
	}).done(function(data){
		$("#floatingSelect2").empty();
		for(let item of data) {
			$("#floatingSelect2").append(
				`<option value="${item.NAME_SUBCATE}" ${item.SELECTED}>${item.NAME_SUBCATE}</option>`
			);
		}
	}).fail(function(){
		console.log("에러");
	});
		
};

