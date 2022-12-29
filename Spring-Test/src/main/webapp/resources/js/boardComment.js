async function postCommentToServer(cmtData){
    try {
        const url = '/comment/post'
        // 데이터에 대한 설정
        const config = {
            method : 'post',
            headers : {
                'content-type' : 'application/json; charset=utf-8'
            },
            body : JSON.stringify(cmtData)
        };
        const resp = await fetch(url, config);
        const result = await resp.text(); // 결과 : 잘 됐으면 0 , 안 됐으면 1
        return result;
    } catch (error) {
        console.log(error);
    }
}

document.getElementById('cmtPostBtn').addEventListener('click',()=>{
    const cmtText = document.getElementById('cmtText').value;
    console.log(cmtText);
    if(cmtText == null || cmtText == ''){
        alert("댓글을 입력해주세요.");
        cmtText.focus(); // cmtText로 커서를 둘 수 있게 만들기
        return false;
    } else {
        let cmtData = {
            bno : bnoVal,
            writer : document.getElementById('cmtWriter').innerText, // span 태그라서 value가 아닌 innerText
            content : cmtText
        };
        console.log(cmtData);
        postCommentToServer(cmtData).then(result =>{
            if(result > 0){
                alert("댓글 등록 성공");
            }
            // 화면에 출력
            getCommentList(cmtData.bno);
        });
    }

});

async function spreadCommentFromServer(bno){
    console.log(bno);
    try {
        const resp = await fetch('/comment/'+bno); // rest 방식 , bno 하나만 가져가지만
        const result = await resp.json(); // 리스트로 전부 쭈르륵 가져와야 하니까 json
        return result;
    } catch (error) {
        console.log(error);
    }
}

function getCommentList(bno){
    spreadCommentFromServer(bno).then(result =>{ // bno 주고 result 받아옴
        console.log(result);
        const ul = document.getElementById('cmtListArea');
        ul.innerHTML = ""; // 기존에 있던 내용 지워주기
        if(result.length > 0){ // 값이 있다면 ~
            for(let cvo of result){
                let li = `<li data-cno="${cvo.cno}" class="list-group-item d-flex justify-content-between align-items-start">`;
                    li += `<div class="ms-2 me-auto"><div class="fw-bold">${cvo.writer}</div>`;
                    li += `<input type="text" class="form-control" id="cmtTextMod" value="${cvo.content}"></div>`;
                    li += `<span class="badge bg-dark rounded-pill">${cvo.mod_at}</span>`;
                    li += `<button class="btn btn-outline-warning mod" type="button">%</button>`;
                    li += `<button class="btn btn-outline-danger del" type="button">X</button>`;
                    li += `</li>`;
                ul.innerHTML += li;
            }
        } else {
            let li = `<li class="list-group-item d-flex justify-content-between align-items-start">Comment List Empty</li>`;
            ul.innerHTML += li;
        }

    })
}

async function editCommentToServer(cmtDataMod){
    try {
        const url = '/comment/'+cmtDataMod.cno;
        const config = {
            method : 'put', // 데이터수정 : put
            headers : {
                'content-type' : 'application/json; charset=utf-8'
            },
            body : JSON.stringify(cmtDataMod)
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }

}

async function removeCommentAtServer(cno){
    try {
        const url = '/comment/'+cno;
        const config = {
            method : 'delete'
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

document.addEventListener('click', (e)=>{
    if(e.target.classList.contains('mod')){
        // 수정 값 처리
        let li = e.target.closest('li'); // 가장 가까운 li 하나를 찾아라! => 내가 누른 수정버튼의 li
        let cnoVal = li.dataset.cno; // li 의 cno dataset을 찾아라! => 내가 누른 수정버튼의 cno
        let textContent = li.querySelector('#cmtTextMod').value;

        let cmtDataMod = {
            cno : cnoVal,
            content : textContent
        };
        console.log(cmtDataMod);
        editCommentToServer(cmtDataMod).then(result => {
            if(result > 0){
                alert("댓글 수정 성공");
            }
            getCommentList(bnoVal);
        });
    } else if(e.target.classList.contains('del')){
        // 삭제 값 처리
        let li = e.target.closest('li');
        let cnoVal = li.dataset.cno;
        
        console.log(cnoVal);
        removeCommentAtServer(cnoVal).then(result =>{
            if(result > 0){
                alert("댓글 삭제 성공");
            }
            getCommentList(bnoVal);
        });
    }

})
