


//<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
function search_address() {
	new daum.Postcode({
		oncomplete: function(data) {
			console.log(data);
			document.joinForm.postcode.value = data.zonecode;

			let address = data.address;
			if (data.buildingName != "") {
				address += " (" + data.buildingName + ")";
			}

			document.joinForm.address1.value = address;

			document.joinForm.address2.focus();

		}
	}).open();
}