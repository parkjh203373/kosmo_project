const btn = document.getElementById("btn")
const bookTitle = document.getElementById("bookTitle")
const author = document.getElementById("bookAuthor")
const publisher = document.getElementById("bookPublisher")
const date = document.getElementById("bookDate")
const contents = document.getElementById("bookContents")
const status = document.getElementById("bookStatus")
const frm = document.getElementById("frm")

btn.addEventListener("click", function(){
	if(bookTitle.value==""){
		alert("제목을 입력해주세요")
		bookTitle.focus()
		return
	}
	
	if(author.value == ""){
	    alert("저자를 입력해주세요");
	    author.focus();
	    return;
	}
	
	if(publisher.value == ""){
		alert("저자를 입력해주세요");
		publisher.focus();
		return;
	}
	
	if(date.value==""){
		alert("카테고리를 입력해주세요")
		date.focus()
		return
	}	

	if(contents.value==""){
		alert("도서 소개를 입력해주세요")
		contents.focus()
		return
	}
		
	
	if(status.value==""){
		alert("도서 대출 상태를 입력해주세요")
		status.focus()
		return
	}
	
	const check = confirm("해당 도서 정보를 수정하시겠습니까?");

	if(check) {
	    frm.submit();
	} else {
	    console.log("수정 취소됨");
	}

})