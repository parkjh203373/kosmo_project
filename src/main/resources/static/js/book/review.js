const create = document.getElementById("create")
const review_list = document.getElementById("review_list")
const review_add = document.getElementById("review_add")
const review_contents = document.getElementById("review_contents")
const review_update = document.getElementById("review_update")
const review_del = document.getElementById("review_del")
const update_save = document.getElementById("update_save");
const contents_update = document.getElementById("contents_update")
const rating_update = document.getElementById("rating_update")

create.addEventListener("click", ()=>{
	let pn = create.getAttribute("data-pn")
	
	let p = new URLSearchParams()
	p.append('bookNum', pn)
	
	fetch("/wishlist/create", {
		method:"POST",
		body:p
	})
	.then(r => r.text())
	.then(r => {
		if(r.trim()>0) {
			let flag = confirm("찜 목록으로 이동하시겠습니까?")
			if(flag) {
				location.href = "/wishlist/list"
			}
		} else {
			alert("로그인이 필요한 서비스입니다.");
			location.href = "/member/login";
		}
	})
})

review_add.addEventListener("click", ()=>{
	let contents = review_contents.value
	let bookNum = create.getAttribute("data-pn")
	let rating = document.getElementById("review_rating").value
	
	if(contents.trim()=="") {
		alert("댓글 내용을 입력해주세요.")
		return
	}
	
	let p = new URLSearchParams()
	p.append('bookNum', bookNum)
	p.append('reviewContents', contents)
	p.append('reviewRating', rating)
	
	fetch("../review/add", {
		method: "POST",
		headers: {
		        "Content-Type": "application/x-www-form-urlencoded"
		    },		
		body: p
	})
	.then(d => d.text())
	.then(d => {
		if(d.trim()>0) {
			alert("댓글이 등록되었습니다.")
			review_contents.value = ""
			getList()
		} else {
			alert("로그인이 필요한 서비스입니다.");
			location.href = "../member/login";
		}
	})
})

review_list.addEventListener("click", (e)=>{
	if(e.target.classList.contains("review_del")){
		if(!confirm("해당 댓글을 삭제하시겠습니까?")) return
		
		let reviewNum = e.target.getAttribute("data-num")
		let p = new URLSearchParams()
		p.append("reviewNum", reviewNum)
		
		fetch("../review/delete", {
			method: "POST",
			headers: {
			        "Content-Type": "application/x-www-form-urlencoded"
			    },			
			body: p
		})
		.then(r => r.text())
		.then(r => {
			if(r.trim()>0) {
				alert("삭제되었습니다.")
				getList()
			} else {
				alert("본인만 삭제 가능하거나 로그인이 필요합니다.")
			}
		})
	}
	
	if(e.target.classList.contains("review_update")) {
		const reviewNum = e.target.getAttribute("data-num")
		const oldRating = e.target.getAttribute("data-rating")
		const oldContents = e.target.getAttribute("data-contents")
		
		contents_update.value = oldContents
		rating_update.value = oldRating
		
		update_save.setAttribute("data-num", reviewNum)
	}
})

update_save.addEventListener("click", () => {
	const reviewNum = update_save.getAttribute("data-num")
	const newContents = contents_update.value
	const newRating = rating_update.value
	
	if(newContents.trim() == "") {
		alert("댓글 내용을 입력해주세요.")
		return
	}
	
	let p = new URLSearchParams()
	p.append('reviewNum', reviewNum)
	p.append('reviewContents', newContents)
	p.append('reviewRating', newRating)
	
	fetch("../review/update", {
		method: "POST",
		headers: {
		        "Content-Type": "application/x-www-form-urlencoded"
		    },
		body: p
	})
	.then(r => r.text())
	.then(r => {
		if(r.trim()>0) {
			alert("댓글 수정이 완료되었습니다.")
			$('#review_modal').modal('hide')
			getList()
		} else {
			alert("권한이 없거나 오류가 발생했습니다.")
		}
	})
})

function getList() {
	let bookNum = create.getAttribute("data-pn")
	
	fetch("../review/list?bookNum=" + bookNum)
	.then(d => d.text())
	.then(d => {
		review_list.innerHTML = d
	})
}

getList()