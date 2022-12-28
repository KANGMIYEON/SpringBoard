<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Detail</title>
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</head>
<body onsubmit=getCommentList(${board.bno})>
<jsp:include page="../layout/header.jsp"></jsp:include>
<h1>Board Detail Page</h1>
	<table border="1" width="350px">
		<tr>
			<th>번호</th>
			<td>${board.bno}</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${board.title}</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${board.writer}</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${board.content}</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>${board.registerDate}</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${board.read_count}</td>
		</tr>
	</table>
	
	<!-- file 표현라인 -->
	<div class="form-group">
		<ul class="">
			<c:forEach items="${fList }" var="fvo">
				<!-- 파일이 여러개 일 때 반복적으로 li 추가 -->
				<li class="list-group-item d-flex justify-content-between align-items-start">
					<li>
						<c:choose>
							<c:when test="${fvo.file_type > 0}">
								<div>
									<!-- D:~fileUpload/2022/12/28/sky.jpg -->
									<img src="/upload/${fn:replace(fvo.save_dir,'\\','/')}/${fvo.uuid}_th_${fvo.file_name}"> <!-- 역슬래쉬에서 일반슬래쉬로 변경, 첨부파일 이름 붙여주기 -->
								</div>
							</c:when>
							<c:otherwise>
								<div>
									<!-- 파일모양 아이콘을 넣어서 일반 파일임을 표현하면 됨 -->
								</div>
							</c:otherwise>
						</c:choose>
						<!-- 파일이름, 등록일, 사이즈 -->
						<div class="ms-2 me-auto">
						<div class="fw-bold">${fvo.file_name }</div>
						${fvo.reg_at }
						</div>
						<span class="badge bg-secondary reounded-pill">${fvo.file_size} Byte</span>
					</li>
			
			</c:forEach>
		</ul>
	</div>
	
	<c:if test="${ses != null || ses.id == board.writer}">
		<a href="/board/modify?bno=${board.bno}"><button type="submit" class="btn btn-outline-dark">수정</button></a>
		<a href="/board/remove?bno=${board.bno}"><button type="submit" class="btn btn-outline-dark">삭제</button></a>
	</c:if>
	<a href="/board/list"><button type="submit" class="btn btn-outline-dark">리스트</button></a>
	
	<!-- comment line -->
	<div class="container">
		<div class="input-group my-3">
			<span class="input-group-text" id="cmtWriter">${board.writer}</span>
			<input type="text" class="form-control" id="cmtText" placeholder="Test Add Comment ">
			<button class="btn btn-success" id="cmtPostBtn" type="button">Post</button>
		</div>
		<ul class="list-group list-group-flush" id="cmtListArea">
		  <li class="list-group-item d-flex justify-content-between align-items-start">
		    <div class="ms-2 me-auto">
		      <div class="fw-bold">Writer</div>
		      Content for Comment
		    </div>
		    <span class="badge bg-dark rounded-pill">modAt</span>
		  </li>
		</ul>
	</div>
	
	

	<script type="text/javascript">
		const bnoVal = '<c:out value="${board.bno}" />';
		console.log(bnoVal);
	</script>
	<script type="text/javascript" src="/resources/js/boardComment.js?ver=1"></script>
	<!-- body에 onsubmit으로 넣거나 스크립트로 넣어줌 -->
	<script type="text/javascript">
		getCommentList(bnoVal);
	</script>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
</html>