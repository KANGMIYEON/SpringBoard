<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
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
* { padding: 0; margin: 0; }

html, body {
  height: 100%;
  background: #ffffff;
}

#container {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  height: 90%;
}

#loginBox {
  width: 300px;
  text-align: center;
  background-color: #ffffff;
}
.input-form-box {
  border: 0px solid #ff0000;
  display: flex;
  margin-bottom: 5px;
}
.input-form-box > span {
  display: block;
  text-align: left;
  padding-top: 5px;
  min-width: 65px;
}
.button-login-box {
  margin: 10px 0;
}
#loginBoxTitle {
  color:#000000;
  font-weight: bold;
  font-size: 32px;
  text-transform: uppercase;
  padding: 5px;
  margin-bottom: 20px;
  background: linear-gradient(to right, #270a09, #8ca6ce);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
#inputBox {
  margin: 10px;
}

#inputBox button {
  padding: 3px 5px;
}
</style>
</head>
<body>
<jsp:include page="../layout/header.jsp"></jsp:include>
   <body class="text-center">  
    <!--  html 전체 영역을 지정하는 container -->
    <div id="container">
      <!--  login 폼 영역을 : loginBox -->
      <div id="loginBox">
      <form action="/member/login" id="form" method="post">
        <!-- 로그인 페이지 타이틀 -->
        <div id="loginBoxTitle">Login</div>
        <!-- 아이디, 비번, 버튼 박스 -->
        <div id="inputBox">
          <div class="input-form-box"><span>아이디 </span><input type="text" name="id" class="form-control"></div>
          <div class="input-form-box"><span>비밀번호 </span><input type="password" name="pw" class="form-control"></div>
          <div class="button-login-box" >
            <button type="submit" class="btn btn-outline-dark btn-xs" style="width:100%">login</button>
          </div>
        </div>
        </form>
      </div>    
    </div>   
   <jsp:include page="../layout/footer.jsp"></jsp:include>
   
   <script type="text/javascript">
   const msg = '<c:out value="${msg}"/>';
   console.log(msg);
   if(msg==="0"){
	   alert("로그인 실패");
   }
   </script>
</body>
</html>