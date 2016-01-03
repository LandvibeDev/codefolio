<%@ page contentType="text/html;charset=UTF-8" language="java"%>


<% String cp = request.getContextPath(); %>

<%--ContextPath 선언 --%>
<html>
<head>

	
<%@ include file="/WEB-INF/include/include-header.jspf" %>
<%@ include file="/WEB-INF/include/include-body.jspf" %>

 
   

	 <!-- bootstrap -->
   <link href="<%=cp%>/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
   <script src="<%=cp%>/resources/bootstrap/js/bootstrap.min.js"></script>
   
	 <!-- CSS-->
    <link rel="stylesheet" href="../css/timeline.css?v1">
   
    <!--FONT-->
    <link rel="stylesheet" href="../css/fonts/font.default.css?v1">
    
     <!-- Style-->
       <style>
      html, body {
      	height:100%;
      	width:100%;
      	padding: 0px;
      	margin: 0px;
      	text-align: left;
      
      }
      
       
     
    
      
    </style> 
    
    
    </head>
    <body >



<div style="height:12%;width:100% ; float:left; ">
  <!-- 좌측 상단  -->	
  
<div style="background-color :#75A3A3; height:100%;width:30%;float:left ;" >

	
<button type="button" class="btn btn-default btn-lg " style="float:left ;background-color :#75A3A3;" ><span class="glyphicon glyphicon-home" aria-hidden="true" style="color:#000000" ></span></button>

</div>
		<!-- 상단 중간 -->
	


  <div style="background-color: #75A3A3; height:100%;width:40% ;float:left; " >
		
 		<a href="#this"  id="Cf">
 		<span style="color:#ffffff; " ><button  style=" WIDTH: 100%; HEIGHT: 100%; padding:0%;margin:0%; font-size: 40pt; background-color:#75A3A3;border:0;float:left;"   type="button"><em>CodeFOLIO</em></button></span>
		 </a>
		 
		<script type="text/javascript">



		$(document).ready(function(){
			$("#Cf").on("click", function(e){ //목록으로 버튼
				e.preventDefault();
				fn_backHome();
			});
		});
			function fn_backHome(){
				var comSubmit = new ComSubmit();
				comSubmit.setUrl("<c:url value='/front/Main.do' />");
				comSubmit.submit();
			}

		</script>		
	</div>



	<!-- 상단 우측 -->
 <div class="dropdown" style="background-color :#75A3A3; height:100%;width:30% ;float:left;" >
      	
   	<ul class="nav nav-tabs">
  <li><a href="#"><span style="color:#000000 " ><strong></strong>홈</span></a></li>
  <li role="presentation" class="dropdown">
    <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
      <span style="color:#000000 " ><strong>계정 관리</strong></span> <span class="caret"></span>
    </a>
    <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
    <li><a href="#">비밀번호 변경</a></li>
    <li><a href="#">회원 탈퇴</a></li>
    <li><a href="#">로그아웃</a></li>
    <li role="separator" class="divider"></li>
    <li><a href="#">고객 센터</a></li>
  </ul>
  
    
  </li>
  <li><a href="#"><span style="color:#000000 " ><strong>메시지</strong></span></a></li>
  <li><a href="#"><span style="color:#000000 " ><strong>알림</strong></span></a></li>
</ul>
 		
</div><!-- /.row -->
</div>



<!-- 메뉴 바 -->
<div  style="width:100%;height:50pt;float:left;background-color :#75A3A3;">
<div style="height:100%;width:35%;float:left;">
<form class="navbar-search pull-left" >
  <input type="text" class="search-query" placeholder="검색" style="background-color :#FFFFFF; height:30pt;width:200pt ">
	<button type="submit" class="btn btn-default-center" style="height:30pt;width:60pt">Submit</button>
</form>
</div>

<div style="height:100%;width:40%;float:left;">
	<ul class="nav nav-pills">

  <li role="presentation" ><a href="/codefolio/front/codeHub.do">소스 저장소</a></li>
  <li role="presentation" ><a href="/codefolio/front/blog.do">코드 포스팅</a></li>
  <li role="presentation" ><a href="">개인 포트폴리오 관리</a></li>
  <li role="presentation" class="disabled"><a href="">팀 프로젝트 내역</a></li>


</ul>
</div>
<div style="height:100%;width:25%;float:left;"></div>

</div>



<!--중간(설명들어갈 곳) -->
<div  style=" width:100%;height:20%;float:left;background-color :#CFD4C5;align:center;" >
<h1>설명</h1>
</div>
    

    
    
    
<!-- 중간 좌측  메뉴 -->
<div  style=" width:100%;height:64%;float:left;" >

<div style="height:100%;width:15%;float:left;">
<div class="btn-group-vertical" role="group" aria-label="..." style="height:100%;width:70%;">
  <button type="button" class="btn btn-default">1</button>
  <button type="button" class="btn btn-default">2</button>

  <div class="btn-group" role="group">
    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
      Dropdown
      <span class="caret"></span>
    </button>
    <ul class="dropdown-menu">
      <li><a href="#">Dropdown link</a></li>
      <li><a href="#">Dropdown link</a></li>
    </ul>
  </div>
</div>
</div>


   <!--하단 게시판 자리 -->
<div style=" height:100%;float:left;width:70%;overflow:auto;">
<jsp:include page="/board/openBoardList.do" flush="false"/>
</div>

<div style=" height:100%;float:left;width:15%;overflow:auto;">



</div>

</div>
		
 
 	
    
    

</body>
</html>