if (performance.navigation.type === 1) {
			location.href= "AdmNotice";
		}
	    
function showNotice(index) {
    const detailRows = document.querySelectorAll('.AdmNoticeDetail');
    detailRows.forEach(function(row) {
        row.style.display = 'none';
    });

    const selectedSubject = document.querySelectorAll('.AdmNoticeDetail')[index];
    if (selectedSubject) {
        selectedSubject.style.display = 'table-row';
    }
}

function noticeModify(notice_idx) {
	console.log("notice_idx : " + notice_idx);
	location.href = "AdminNoticeModify?notice_idx=" + notice_idx;
}


function deleteBoard() {
	const checkedValues = $('input[name="notice_idx"]:checked').map(function() {
		return $(this).val();
	}).get();
	
	if (checkedValues.length <= 0) {
		alert("삭제할 게시물을 선택하세요");
		return;
	}
	
	if (confirm('삭제하시겠습니까?')) {
		console.log("checkedValues : " + checkedValues);
		location.href = "AdminNoticeDelete?notice_idxs=" + checkedValues;
	}
	
}