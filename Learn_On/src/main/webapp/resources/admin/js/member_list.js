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