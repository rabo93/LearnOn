// Modal
function showUpdateModal(id) {
	const modal = document.querySelector("#updateReview");
	let stars = modal.querySelectorAll('.course-rating .star-icon');
	modal.classList.add('show-modal');
	
	$.ajax({
		type : "GET",
		url: "MyReviewUpdateForm",
		data : {
			class_id : id
		},
		dataType : "json"
	}).done(function(data){
//		console.log("리뷰 내용(data) : " + JSON.stringify(data));
		modal.querySelector("#course_id").value = data.class_id;
		for (let i = 0; i < data.review_score; i++) {
	        stars[i].classList.add('filled');
	    }
		modal.querySelector(".rev-con").value = data.review_content;
	}).fail(function(){
		console.log("에러");
	});
	
}

function showDeleteModal(id) {
	const modal = document.querySelector("#deleteReview");
	modal.querySelector("#course_id").value = id;
	modal.classList.add('show-modal');
}


function hideModal(elem) {
	document.querySelector('#' + elem).classList.remove('show-modal'); 
}
