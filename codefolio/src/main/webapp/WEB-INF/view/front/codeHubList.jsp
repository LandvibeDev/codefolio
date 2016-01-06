<%@ page contentType="text/html;charset=UTF-8" language="java"%>


<% String cp = request.getContextPath(); %>

<%--ContextPath 선언 --%>
<html>
<head>

	
<%@ include file="/WEB-INF/include/include-header.jspf" %>
<%@ include file="/WEB-INF/include/include-body.jspf" %>
<%@ include file="/WEB-INF/include/include-Topbase.jspf" %>
 
   

	 <!-- bootstrap -->
   <link href="<%=cp%>/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
   <script src="<%=cp%>/resources/bootstrap/js/bootstrap.min.js"></script>
    <script src="<%=cp%>/resources/bootstrap/js/bootstrap.js"></script>
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






    


    
<!-- 세번째 층에 대한 내용 -->
<div  style=" width:100%;height:1500px;border:none;" >


<!-- 세번째 층의 왼쪽 메뉴목록 -->
<!-- 밑의 script 참고 -->
<!-- 스크롤 이동에 대한 menu_bar에 스타일을 지정 -->
<div id="menu_bar" style="height:100%;width:15%;float:left;">
   <form id="frm" name="frm" enctype="multipart/form-data" style="height:100%;width:100%;float:left;"> <!-- 첨부파일  -->
   
      
       <!-- 파일 업로드 -->
        <br/>
        <div align="center" style="height:15pt;width:100%;float:left;"><strong>프로젝트 설명</strong></div>
        <input type= "text" name = "comment" id = "comment" style="height:50pt;width:100%;float:left;">
        <input type="file" name="file" style="height:20pt;width:100%;float:left;"> <!-- 첨부파일  -->
        <div style="height:3pt;width:100%;float:left;"></div>
      	<a href="#this" class="btn btn-primary" id="write" style="height:30pt;width:100%;float:left;">커밋!!</a>
 		<div style="height:30pt;width:100%;float:left;"></div>
 		
 		
 		<!-- 나라별 언어선택 -->
 		<div class="dropdown" style="height:30pt;width:100%;float:left;">
  		<button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="height:100%;width:100%;float:left;">
  		 나라별 언어
   		 <span class="caret"></span>
 	 	</button>
 		 <ul class="dropdown-menu" aria-labelledby="dropdownMenu1" style="width:100%;float:left;" >
   		<li><a href="#">한국어</a></li>
    	<li><a href="#">스패인어</a></li>
    	<li><a href="#">중국어</a></li>
   		<li><a href="#">몽골어</a></li>
  		</ul>
		</div>
 

   </form>
</div>

<div id="menu_bar_after" style="float:left; ">
</div>

<!-- 메뉴와 게시판 사이의 빈 공간 -->
<div style=" height:100%;float:left;width:5%;"></div>

<!-- 소스 저장소 내용   -->
<div style=" height:100%;float:left;width:65%;overflow:auto;">
<h2 align="center"><span class="glyphicon glyphicon-th-list" aria-hidden="true"></span> Code Hub </h2> <!-- bootstrap 기호 추가 -->
   <table class="board_list">
      <colgroup>
         <col width="10%"/>
         <col width="*"/>
         <col width="15%"/>
         <col width="20%"/>
      </colgroup>
      <thead>
         <tr>
            <th scope="col">번호</th>
            <th scope="col">프로젝트명</th>
            <th scope="col">언어</th>
            <th scope="col">시작일</th>
         </tr>
      </thead>
      <tbody>
         <c:choose>
            <c:when test="${fn:length(list) > 0}">
               <c:forEach items="${list}" var="row">
                  <tr>
                     <td>${row.PRJ_IDX }</td>
                     <td class="title">
                     <input type='hidden' id='IDX' value="${row.TITLE }">
                        <a href='#this' name='title'>${row.TITLE }</a>
                     </td>
                     <td>${row.LANG }</td>
                     <td>${row.DATE }</td>
                     
                  </tr>
                  
               </c:forEach>
            </c:when>
            <c:otherwise>
               <tr>
                  <td colspan="4">조회된 결과가 없습니다.</td>
               </tr>
            </c:otherwise>
         </c:choose>
      </tbody>
   </table>


</div>
</div>

<!-- 부가적인 꼬리말에 대한 층 -->
<footer style="height:50px;width:100%;float:left;background-color: #B26B69;">

</footer>


<!-- script -->

<!-- 첫번째 "codeFOLIO" 버튼에 대한 script -->
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

 <!-- 네번째 층의 왼쪽  메뉴 스크롤시 상단 고정에 대한 스크립트 -->
 <script type="text/javascript"> 
 function menuScroll() { 
     var menu_bar = document.getElementById('menu_bar');
     var menu_bar_after = document.getElementById('menu_bar_after');
    
     
     
     if($(window).scrollTop() > 300 ) 	// 300이상 일때 부터 상단에 고정
  	{
  	menu_bar.style.position = 'fixed';
  	menu_bar.style.top=0;
  	menu_bar_after.style.position='';
  	menu_bar_after.style.height='100%';
  	menu_bar_after.style.width='15%';
  	
  	}
   else 
  	 {
  	 menu_bar.style.position = ''; //300 이하일때는 기존의 자리로 이동.
  	 menu_bar_after.style.height='';
   	 menu_bar_after.style.width='';
  	 
  	 }

}

$(window).scroll(menuScroll);
</script>

<script type="text/javascript">
      $(document).ready(function(){
            
         $("a[name='title']").on("click", function(e){ //제목 
            e.preventDefault();
            fn_openBoardDetail($(this));
         });
         
         
         $(document).ready(function(){
            
            
            $("#write").on("click", function(e){ //작성하기 버튼
               e.preventDefault();
               fn_insertBoard1();
            });
         });
      /*   $("button[name='topicBtn']").on("click", function(e){ 
            e.preventDefault();
            fn_boardChange($(this));
         });*/
      });
   
      
      
      function fn_openBoardDetail(obj){
         var comSubmit = new ComSubmit();
         comSubmit.setUrl("<c:url value='/front/codeHubDetail.do' />");
         comSubmit.addParam("IDX", obj.parent().find("#IDX").val());
         comSubmit.submit();
      }
   /*   function fn_boardChange(obj){
         var comSubmit = new ComSubmit();
         comSubmit.setUrl("<c:url value='/front/codeHubDetail.do' />");
         comSubmit.addParam("IDX", obj.parent().find("#IDX").val());
         comSubmit.submit();
      }*/
      
      function fn_insertBoard1(){
         var comSubmit = new ComSubmit("frm");
         comSubmit.setUrl("<c:url value='/front/codeHubResult.do' />");
         comSubmit.submit();
      }
      
   </script>   



</body>
</html>