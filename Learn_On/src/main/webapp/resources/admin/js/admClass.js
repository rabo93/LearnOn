
// 클래스 등록시 커리큘럼 추가 제거
function addRow() {
	var dynamicTable = document.getElementById('dynamic_table');
	var newRow = dynamicTable.insertRow();
	var cell1 = newRow.insertCell();
	var cell2 = newRow.insertCell();
	var cell3 = newRow.insertCell();
	  
	cell1.innerHTML = '<input type="checkbox" name="checkboxObj"/>';
	cell2.innerHTML = '<input type="text" class="form-control" id="floatingInput" placeholder="커리큘럼 제목">';
	cell3.innerHTML = '<input type="file" class="file form-control" id="inputGroupFile02" placeholder="커리큘럼 영상">';
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
	let classId = $(elem).parent().parent().attr("id");
	location.href="admClassListModify?class_id=" + classId;
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
	  
	cell1.innerHTML = '<th><input class="form-check-input" type="checkbox" id="gridCheck1" name="mainCateRowCheck"></th>';
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
				+ checkboxArray[i].parentElement.parentElement.getElementsByClassName("form-control")[0].value;
//				console.log(checkboxArray[i].parentElement.parentElement.getElementsByClassName("form-control")[0].value); 
			} else {
				return;	
			}
		}
	}
}

function addSubCateRow() {
	var subCateTable = document.getElementById('subCateTable');
	var newRow = subCateTable.insertRow();
	var cell1 = newRow.insertCell();
	var cell2 = newRow.insertCell();
	var cell3 = newRow.insertCell();
	var cell4 = newRow.insertCell();
	var cell5 = newRow.insertCell();
	var cell6 = newRow.insertCell();
	  
	cell1.innerHTML = '<td><input class="form-check-input" type="checkbox" id="gridCheck1" name="subCateRowCheck"></td>';
	cell2.innerHTML = '<td><input name="codetype_subcate" class="form-control" type="text" placeholder="타입"></td>';
	cell3.innerHTML = '<td><input name="codetype_id_subcate" class="form-control" type="text" placeholder="아이디"></td>';
	cell4.innerHTML = '<td><input name="name_subcate" class="form-control" type="text" placeholder="이름"></td>';
	cell5.innerHTML = '<td><input name="description_subcate" class="form-control" type="text" placeholder="설명"></td>';
	cell6.innerHTML = '<td><input name="order_subcate" class="form-control" type="text" placeholder="오더"></td>';
}

function deleteSubCateRow() {
	var checkboxArray = document.getElementsByName('subCateRowCheck');
	for (var i = 0; i < checkboxArray.length; i++) {
		if (checkboxArray[i].checked) {
			if (confirm('삭제하시겠습니까?')) {
				location.href="subCateDelete?CODETYPE_ID="
				+ checkboxArray[i].parentElement.parentElement.getElementsByClassName("form-control")[1].value;
			} else {
				return;	
			}
		}
	}
}