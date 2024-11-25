if (performance.navigation.type === 1) {
			location.href= "AdmPayListCoupon";
		}
    	
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