<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<style type="text/css">

h1{
text-align: center;
}
.container{
	display: flex;
	justify-content: center;
}
.btn-outline-danger{
	display: flex;
	justify-content: center;
}
</style>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	
	
	
	
	<h1>회원가입</h1>
	<div class="container">
		<form class="row g-3" action="/member/signup" method="post">
  			<div class="col-md-6">
	   			<label for="inputEmail4" class="form-label">ID</label>
	  			<input type="text" class="form-control"  name="id" placeholder="아이디">
 			</div>
	  <div class="col-md-6">
	    <label for="inputPassword4" class="form-label">Password</label>
	    <input type="password" class="form-control"  name="pw" placeholder="비밀번호">
	  </div>
	  <div class="col-12">
	    <label for="inputAddress2" class="form-label">Age</label>
	    <input type="text" class="form-control"  name="age" placeholder="나이">
	  </div>
	  <div class="col-12">
	    <label for="inputAddress2" class="form-label">Name</label>
	    <input type="text" class="form-control"  name="name" placeholder="이름">
	  </div>
	  <div class="col-12">
	    <label for="inputAddress2" class="form-label">Email</label>
	    <input type="text" class="form-control"  name="email" placeholder="이메일">
	  </div>
	  <div class="col-12">
	    <label for="inputAddress" class="form-label">Home</label>
	    <input type="text" class="form-control"  name="home" placeholder="인천 부평구 어쩌구">
	  </div>
	  <div class="col-12">
	    <div class="form-check">
	      <input class="form-check-input" type="checkbox" id="gridCheck">
	      <label class="form-check-label" for="gridCheck">
	        Check me out
	      </label>
	    </div>
	  </div>
	  <button type="submit" class="btn btn-outline-dark">Welcome</button>
		</form>
	</div>
	
	
	<jsp:include page="../layout/footer.jsp"></jsp:include>
	
	
	<script type="text/javascript">
	const msg = '<c:out value="${msg}"/>';
	if(msg==='0'){
		console.log(msg);
		alert("이미 가입된 회원입니다.");
	}
	</script>
</body>
</html>