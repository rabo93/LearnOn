// Modal
function showModal(course_id) {
  document.querySelector("#course_id").value = course_id;
  const modal = document.querySelector(".modal");
  modal.classList.add('show-modal');
  
}

function hideModal() {
  const modal = document.querySelector(".modal");
  modal.classList.remove('show-modal'); 
}
