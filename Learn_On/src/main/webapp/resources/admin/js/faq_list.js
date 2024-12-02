if (performance.navigation.type === 1) {
			location.href= "AdmFaq";
}
    
function showFaq(index) {
    const detailRows = document.querySelectorAll('.AdmfaqDetail');
    detailRows.forEach(function(row) {
        row.style.display = 'none';
    });

    const selectedSubject = document.querySelectorAll('.AdmfaqDetail')[index];
    if (selectedSubject) {
        selectedSubject.style.display = 'table-row';
    }
}

function faqModify(faq_idx) {
	console.log("faq_idx : " + faq_idx);
	location.href = "AdminFaqModify?faq_idx=" + faq_idx;
}

function deleteBoard() {
	const checkedValues = $('input[name="faq_idx"]:checked').map(function() {
		return $(this).val();
	}).get();
	
	if (checkedValues.length <= 0) {
		alert("삭제할 게시물을 선택하세요");
		return;
	}
	
	console.log("checkedValues : " + checkedValues);
	location.href = "AdminFaqDelete?faq_idxs=" + checkedValues;
	
}