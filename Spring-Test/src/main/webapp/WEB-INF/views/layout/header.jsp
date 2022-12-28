<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

</head>
<body>
<nav class="navbar navbar-expand-lg bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="/member/">EZEN</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <c:if test="${ses.id == null}">
      		<li class="nav-item">
         		<a class="nav-link active" aria-current="page" href="/member/signup">회원가입</a>
       		</li>
	        <li class="nav-item">
	          <a class="nav-link" href="/member/login">로그인</a>
	        </li>
        </c:if>
        <c:if test="${ses.id != null}">
	        <li class="nav-item">
	          <a class="nav-link" href="/member/logout">로그아웃</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="/board/register">글쓰기</a>
	        </li>
        </c:if>
          <li class="nav-item">
          <a class="nav-link" href="/board/list">게시판</a>
        </li>
 		<c:if test="${ses.id != null}">
	       
	        <li class="nav-item">
	          <a class="nav-link" >${ses.id} welcome!</a>
	        </li>
        </c:if>
        </ul>
    </div>
  </div>
</nav>