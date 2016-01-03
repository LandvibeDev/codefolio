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
    <!-- 좌측 상단 -->
  <div  style=" height:15%;width:100% ;float:left;">
    <div style="background-color: #3498db;height:100%;width:20% ;float:left; " >
      
		
 		<a href="#this"  id="Cf">
 		<span style="color:#ffffff; " ><button  style=" WIDTH: 100%; HEIGHT: 100%; padding:0%;margin:0%; font-size: 50pt; background-color:#3498db;border:0;float:left;"   type="button"><em>CodeFOLIO</em></button></span>
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
				comSubmit.setUrl("<c:url value='/board/test.do' />");
				comSubmit.submit();
			}

		</script>		
</div>
    <!-- 상단 중간 -->
<div style="background-color :#34e8fb;width:50%;height:100%;float:left;padding-top:3%;" >
<h1><center><span class="glyphicon glyphicon-education" aria-hidden="true"></span> 코드 포스팅 </center></h1>
</div>
    <!-- 우측 상단 -->
<div class="dropdown" style="background-color :#34e8fb; height:100%;width:30% ;float:left;" >	
   	<ul class="nav nav-tabs" style="padding-top : 13% ;">
  <li><a href="#"><span style="color:#9b59b6 " ><strong></strong>홈</span></a></li>
  <li role="presentation" class="dropdown">
    <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
      <span style="color:#9b59b6 " ><strong>계정 관리</strong></span> <span class="caret"></span>
    </a>
    <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
    <li><a href="#">비밀번호 변경</a></li>
    <li><a href="#">회원 탈퇴</a></li>
    <li><a href="#">로그아웃</a></li>
    <li role="separator" class="divider"></li>
    <li><a href="#">고객 센터</a></li>
  </ul>
  </li>
  <li><a href="#"><span style="color:#9b59b6 " ><strong>메시지</strong></span></a></li>
  <li><a href="#"><span style="color:#9b59b6 " ><strong>알림</strong></span></a></li>
</ul>	
</div><!-- /.row -->
</div>
    
    
<!--중간 좌측  메뉴 -->
<div  style=" width:100%;height:85%;float:left;" >
<div style="height:100%;width:20%;float:left;">

<a href="http://localhost:8080/codefolio/front/test_2.do" target="_self"><button type="button"  class="btn btn-default" style="width:100%; "><span style="color:#000000;"><strong>소스 저장소 </strong></span></button></a>
<a href="http://localhost:8080/codefolio/front/blog.do" ><button type="button"  class="btn btn-default" style="width:100%; "><span style="color:#000000;"><strong>코드 포스팅 </strong></span></button></a>
<a href=""><button type="button"  class="btn btn-default" style="width:100%; "><span style="color:#000000;"><strong>개인 포트폴리오 관리</strong></span></button></a>
<a href=""><button type="button"  class="btn btn-default" style="width:100%; "><span style="color:#000000;"><strong>팀 프로젝트 내역 </strong></span></button></a>
 
  <h3><center><span class="glyphicon glyphicon-sort" aria-hidden="true"><strong> 모든 글보기</strong></span></center></h3>
  
  <div class="btn-group-vertical" id="sidebar" role="group" aria-label="..." style="float:left;">
  <button type="button"   class="btn btn-default" ><strong><span class="glyphicon glyphicon-folder-open" aria-hidden="true" style="color:#f1c40f;"><span class="glyphicon glyphicon-menu-right" aria-hidden="true" style="color:#bdc3c7"></span><span  style="color:#000000">  1</span></span></strong></button>
	 <button type="button"   class="btn btn-default" ><strong><span class="glyphicon glyphicon-folder-open" aria-hidden="true" style="color:#f1c40f;"><span class="glyphicon glyphicon-menu-right" aria-hidden="true" style="color:#bdc3c7"></span><span  style="color:#000000">  2</span></span></strong></button>
  <button type="button"   class="btn btn-default" ><strong><span class="glyphicon glyphicon-folder-open" aria-hidden="true" style="color:#f1c40f;"><span class="glyphicon glyphicon-menu-right" aria-hidden="true" style="color:#bdc3c7"></span><span  style="color:#000000">  3</span></span></strong></button>
 
 </div>
 </div>
  

   <!-- 중간 중앙 게시판 자리 -->
<div style=" height:100%;float:left;width:80%;outline:solid;overflow:auto;">
<jsp:include page="/board/openBoardList.do" flush="false"/>
</div>

</div>


		
 
 	
    
    
    

</body>
</html>