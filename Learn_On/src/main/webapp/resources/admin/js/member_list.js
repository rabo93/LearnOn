$(function(){
	$('.gradeChange').on("change", function() {
		let index = this.id.split('_')[1];
		let mem_grade = this.value;
		let mem_id = $('#memId_' + index).val();
		
		$.ajax ({
			type : "POST",
			url : "AdmChangeMemGrade",
			data : {
				mem_id : mem_id,
				mem_grade: mem_grade
			},
			dataType: "json",
		}).done(function(result){
//			result = JSON.parse(result);
			alert(result.mem_id + '회원의 등급이 ' + result.mem_grade + '(으)로 변경되었습니다.');
			window.location.reload();
		})
	});
})

$(function(){
	$('.status').on("change", function() {
		let index = this.id.split('_')[1];
		let mem_status = this.selectedIndex + 1;
		let mem_id = $('#memId_' + index).val();
		
		$.ajax ({
			type : "POST",
			url : "AdmChangeMemStatus",
			data : {
				mem_id : mem_id,
				mem_status: mem_status
			},
			dataType: "json",
		}).done(function(result){
//			result = JSON.parse(result);
			alert(result.mem_id + '회원의 상태가 ' + result.mem_status + '로 변경되었습니다.');
			window.location.reload();
		})
	});
})

function memberModify(mem_id) {
	console.log("mem_id : " + mem_id);
	location.href = "AdmMemberModify?mem_id=" + mem_id;
}

function showFile(index) {
    const detailRows = document.querySelectorAll('.AdmMemberDetail');
    detailRows.forEach(function(row) {
        row.style.display = 'none';
    });

    const selectedSubject = document.querySelectorAll('.AdmMemberDetail')[index];
    if (selectedSubject) {
        selectedSubject.style.display = 'table-row';
    }
}

function deleteMember() {
	const checkedValues = $('input[name="mem_id"]:checked').map(function() {
		return $(this).val();
	}).get();
	
	if (checkedValues.length <= 0) {
		alert("삭제할 회원을 선택하세요");
		return;
	}
	
	if(confirm("회원을 삭제하시겠습니까?")) {
		location.href = "AdminMemberDelete?mem_ids=" + checkedValues;
	}
}

function changeMemGrade(mem_id) {
	console.log("mem_id : " + mem_id);
	location.href = "AdmMemGradeChange?mem_id=" + mem_id;
}





