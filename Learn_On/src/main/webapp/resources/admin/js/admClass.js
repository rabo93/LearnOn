
var count = 1;
function addRow() {
	var dynamicTable = document.getElementById('dynamic_table');
	var newRow = dynamicTable.insertRow();
	var cell1 = newRow.insertCell();
	var cell2 = newRow.insertCell();
	var cell3 = newRow.insertCell();
	  
	cell1.innerHTML = '<input type="checkbox" name="checkboxObj"/>';
	cell2.innerHTML = '<input type="text" class="form-control" id="floatingInput" placeholder="커리큘럼 제목">';
	cell3.innerHTML = '<input type="file" class="file form-control" id="inputGroupFile02" placeholder="커리큘럼 영상">';
	count++;
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

function modifyClass(elem) {
	let classId = $(elem).parent().parent().attr("id");
	location.href="admClassListModify?class_id=" + classId;
}