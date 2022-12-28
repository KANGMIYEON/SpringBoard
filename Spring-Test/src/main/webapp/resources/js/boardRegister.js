// trigger 버튼 클릭하면 files 가 클릭 된 것처럼 보이게 하기 ~!
document.getElementById('trigger').addEventListener('click', ()=>{
    document.getElementById('files').click();
});

// 정규식 표현을 이용한 생성자 함수 만들기
// fileload 시 값을 규제 (형식제한)
// 실행파일 막기(금지) - 파일 확장자가 jpg,jpeg,gif,png 인파일만 업로드하실 수 있습니다.
// 이미지 파일 - 파일 업로드 시, 첨부파일 1개당 200MB 까지 가능합니다.
// \ 시작 ~ $ 끝
// 실행파일 막기 : 이 형식의 확장자는 들어올 수 없어!
const regExp = new RegExp("\.(exe|sh|bat|msi|dll|js)$");
const regExpImg = new RegExp("\.(jpg|jpeg|png|gif)$"); // 이미지 파일
const maxSize = 1024*1024*20; // 20MB 보다 큰지 체크

function fileSizeValidation(fileName, fileSize){
    if(regExp.test(fileName)){ //  실행파일(fileName)을 test 해서 있으면
        return 0;
    } else if(!regExpImg.test(fileName)){ // 이미지 파일이 아니면
        return 0;
    } else if(fileSize > maxSize){
        return 0;
    } else {
        return 1;
    }
}

document.addEventListener('change', (e) => {
    if(e.target.id == "files"){ // files 에 뭔가 변화가 일어났다면 => 파일을 첨부하는 중!
        document.getElementById('regBtn').disabled = false; // 첨부되지 말아야 하는 파일이 들어왔을 때 등록 버튼 비활성화
        // input type="file" element fileObject 객체로 리턴
        const fileObject = document.getElementById('files').files; // multiple => files
        console.log(fileObject);

        let div = document.getElementById('fileZone');
        div.innerHTML = ""; // div 비우기
        let ul = '<ul class="list-group list-group-flush">';
        let isOk = 1;
        for(let file of fileObject){
            let validResult = fileSizeValidation(file.name, file.size); // 0 or 1
            isOk *= validResult; // 하나라도 OK 안 되면 업로드 불가하게! (모든 첨부파일의 결과가 1이면 통과)
            ul += `<li class="list-group-item d-flex justify-content-between align-items-start">`;
            // 업로드 가능여부 표시
            ul += `${validResult ? '<div class="fw-bold">업로드 가능' : '<div class="fw-bold text-danger">업로드 불가'}</div>`;
            ul += `${file.name}`;
            ul += `<span class="badge bg-${validResult ? 'success' : 'danger'} rounded-pill">${file.size} Bytes</span></li>`;
        }
        ul += `</ul>`;
        div.innerHTML = ul;

        if(isOk == 0){
            document.getElementById('regBtn').disabled = true;
        }

    }
});

async function removeFileAtServer(uuid){
    try {
        const url = '/board/' + uuid;
        const config = {
            method : 'delete'
        };
        const resp = await fetch(url, config);
        const result = resp.regExpImg();
        return result;
    } catch (error) {
        console.log(error);
    }
}

document.addEventListener('click', (e)=>{
    if(e.target.classList.contains('file-x')){
        let li = e.target.closest('li');
        let uuidVal = li.dataset.uuid;

        console.log(uuidVal);
        removeFileAtServer(uuidVal).then(result =>{
            if(result > 0){
                alert("파일 삭제 성공");
            }

        });
    }
})