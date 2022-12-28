<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

</head>
<body>
<jsp:include page="../layout/header.jsp"></jsp:include>
<h1>Board Register Page</h1>
	
	<form action="/board/register" method="post" enctype="multipart/form-data">
		<div class="mb-3">
			<label for="formGroupExampleInput" class="form-label">Title</label> <input
				type="text" class="form-control" id="formGroupExampleInput"
				name="title" placeholder="제목을 입력해주세요.">
		</div>
		<div class="mb-3">
			<label for="formGroupExampleInput2" class="form-label">Writer</label>
			<input type="text" class="form-control" id="formGroupExampleInput2"
				name="writer" readonly value="${ses.id}">
		</div>
		<div class="mb-3">
			<label for="formGroupExampleInput" class="form-label">Content</label>
			<textarea type="text" class="form-control" id="formGroupExampleInput"
				name="content" placeholder="내용을 입력해주세요."></textarea>
		</div>
		
		<!-- 파일 업로드 -->
		<div class="col-12 d-grid">
  			<input class="form-control" type="file" style="display: none;"
  				 id="files" name="files" multiple> <!-- multiple : 파일 여러개 업로드 가능 -->
  			<button type="button" id="trigger" class="btn btn-outline-primary btn-block d-block">Files Upload</button>
		</div>
		<!-- 첨부한 파일의 목록 -->	
		<div class="col-12" id="fileZone">

		</div>
		
		
		<button type="submit" class="btn btn-outline-dark" id="regBtn">등록</button>
	</form>
	
	<!-- js 연결 -->
	<script src="/resources/js/boardRegister.js"></script>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
</html>