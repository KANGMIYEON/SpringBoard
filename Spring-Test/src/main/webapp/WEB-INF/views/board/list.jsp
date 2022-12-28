<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<!-- CSS only -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<!-- JavaScript Bundle with Popper -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
	crossorigin="anonymous"></script>
<style type="text/css">
.nonemit{
   text-decoration: none;
   color : black;
}
.nonemit:hover{
   color : black;
}
h1 {
	text-align: center;
}

.container {
	text-align: center;
	display: flex;
	justify-content: center;
}

.reg {
	margin-left: 5px;
}
</style>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<h1><a class="nonemit" href="/board/list">게시판</a></h1>
	<!-- search -->
	<div class="col-sm-12 col-md-6 container">
		<form action="/board/list" method="get">
			<div class="input-group mb-3">
				<!-- 값을 별도 저장 -->
				<c:set value="${pgh.pgvo.type }" var="typed" />
				<select class="form-select" name="type">
					<option ${typed == null ? 'selected':'' }>Choose...</option>
					<option value="t" ${typed eq 't' ? 'selected':'' }>Title</option>
					<option value="c" ${typed eq 'c' ? 'selected':'' }>Content</option>
					<option value="w" ${typed eq 'w' ? 'selected':'' }>Writer</option>
				</select> <input class="form-control" type="text" name="keyword"
					placeholder="Search" value="${pgh.pgvo.keyword }"> <input
					type="hidden" name="pageNo" value="1"> <input type="hidden"
					name="qty" value="${pgh.pgvo.qty }">
				<button type="submit" class="btn btn-success position-relative">
					Search <span
						class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
						${pgh.totalCount } <span class="visually-hidden">unread
							messages</span>
					</span>
				</button>
			</div>
		</form>
	</div>
	
	<div class="container">
		<table class="table">
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">작성일</th>
					<th scope="col">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="bvo">
					<tr>
						<td scope="row">${bvo.bno}</td>
						<td><a href="/board/detail?bno=${bvo.bno}">${bvo.title}</a></td>
						<td>${bvo.writer}</td>
						<td>${bvo.registerDate}</td>
						<td>${bvo.read_count}</td>
					</tr>
				</c:forEach>

			</tbody>
		</table>
	</div>

	<!-- paging line -->
	<nav aria-label="Page navigation example">
		<div class="container">
			<ul class="pagination">
				<c:if test="${pgh.prev}">
					<li class="page-item"><a class="page-link"
						href="/board/list?pageNo=${pgh.startPage - 1}&qty=${pgh.pgvo.qty}&type=${pgh.pgvo.type}&keyword=${pgh.pgvo.keyword}">Previous</a></li>
				</c:if>
				<c:forEach begin="${pgh.startPage}" end="${pgh.endPage}" var="i">
					<li class="page-item"><a class="page-link"
						href="/board/list?pageNo=${i}&qty=${pgh.pgvo.qty}&type=${pgh.pgvo.type}&keyword=${pgh.pgvo.keyword}">${i}</a></li>
				</c:forEach>
				<c:if test="${pgh.next}">
					<li class="page-item"><a class="page-link"
						href="/board/list?pageNo=${pgh.endPage + 1}&qty=${pgh.pgvo.qty}&type=${pgh.pgvo.type}&keyword=${pgh.pgvo.keyword}">Next</a></li>
				</c:if>
			</ul>
		</div>
	</nav>

	<div class="container">
		<a href="/member/"><button type="submit"
				class="btn btn-outline-dark">메인으로 이동</button></a> <a
			href="/board/register"><button type="submit"
				class="btn btn-outline-dark reg">글작성</button></a>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>

</body>
</html>