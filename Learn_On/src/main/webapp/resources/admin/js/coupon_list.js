$(document).ready(function() {
	$(".couponMemberForm").on('submit', function(event) {
		if (!$("#couponMemberCheckAll").is(":checked")) {
			alert("쿠폰을 발급할 회원을 선택해 주세요");
			event.preventDefault();
		} else {
			if (!confirm("쿠폰을 발급하시겠습니까?")) {
				event.preventDefault();
			}
		}
	});
});

function deleteCoupon() {
	const checkedValues = $('input[name="coupon_id"]:checked').map(function() {
		return $(this).val();
	}).get();
	
	if (checkedValues.length <= 0) {
		alert("삭제할 게시물을 선택하세요");
		return;
	}
	console.log("checkedValues : " + checkedValues);
	location.href = "AdmCouponDelete?coupon_ids=" + checkedValues;
}

function couponModify(coupon_id) {
	location.href = "AdmCouponModify?coupon_id=" + coupon_id;
}

function showMembers(index) {
    const couponIssueMemDiv = document.querySelector('.couponIssueMem');
    
    let coupon_id = $("#couponIdx_" + index).val();
    let coupon_name = $("#couponName_" + index).val();
    
    $(".couponIdHidden").val(coupon_id);
    $(".couponIssueIdx").val(coupon_id);
    $(".couponIssueName").val(coupon_name);
    
    $.ajax({
		type : "POST",
		url : "AdmShowCouponMembers",
		data : {
			coupon_id : coupon_id
		},
		dataType : "JSON"
	}).done(function(result) {
		//	새로운 멤버리스트 뿌릴때 먼저 지우기 작업
		$(".couponMemberList").remove();
		//	해당 쿠폰을 발급받을 수 있는 회원 리스트 뿌리기
		for (let member of result) {
			$(".couponIssueMem > table").append(
				'<tr class="couponMemberList">'
				+ '<th><input class="form-check-input couponMemberCheck" type="checkbox" id="gridCheck1" name="mem_ids" value="' + member.mem_id + '"></th>'
				+ '<td><input class="form-control couponMember" type="text" aria-label="default input example" value="' + member.mem_id + '"></td>'
				+ '<td><input class="form-control couponMember" type="text" aria-label="default input example" value="' + member.mem_name + '"></td>'
				+ '</tr>'
			);
		}
	})
    
    couponIssueMemDiv.style.display = 'block';

}

//	쿠폰 발급페이지 전체선택 체크박스 체크시 모든 회원 체크
$("#couponMemberCheckAll").on("change", function() {
	if($(this).prop("checked")){
		$(".couponMemberCheck").prop("checked", true);
	} else {
		$(".couponMemberCheck").prop("checked", false);
	}
});
















