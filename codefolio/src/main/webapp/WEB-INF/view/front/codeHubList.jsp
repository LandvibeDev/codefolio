<%@ page contentType="text/html;charset=UTF-8" language="java"%>


<html>
<head>
<!-- include 부분 -->
<%@ include file="/WEB-INF/include/include-header.jspf" %>
<%@ include file="/WEB-INF/include/include-body.jspf" %>
<%@ include file="/WEB-INF/include/include-Topbase.jspf" %>
   
</head>
<body >

<!-- side menu와 소스 저장소에 대한 내용 (row 3)-->
<div  style=" width:100%;height:1500px;border:none;" >


<!-- side menu (row 3 - col 1)-->
<!-- 스크롤 이동에 대한 menu_bar에 스타일을 지정 -->
<!-- 밑의 script 참고 -->
<!--side menu 버튼에 해당하는 게시판 내용  -->
<div id="menu_bar" style="height:100%;width:15%;float:left;">
   <form id="frm" name="frm" enctype="multipart/form-data" style="height:100%;width:100%;float:left;"> <!-- 첨부파일  -->

       <!-- 파일 업로드 -->
        <br/>
        <div align="center" style="height:15pt;width:100%;float:left;"><strong>프로젝트 설명</strong></div>
        <input type= "text" name = "comment" id = "comment" style="height:50pt;width:100%;float:left;">
        <input type="file" name="file" style="height:20pt;width:100%;float:left;"> <!-- 첨부파일  -->
        <div style="height:3pt;width:100%;float:left;"></div>
      	<a href="#this" class="btn" id="write" style="height:30pt;width:100%;float:left;"><span style="color:#000000;"><strong>커밋!!</strong></span></a>
 		<div style="height:30pt;width:100%;float:left;"></div>

   </form>
</div>

<!-- 스크롤이 300이상시 빈공간을 채워준다.(row 3 - col 1-1) -->
<div id="menu_bar_after" style="float:left; ">
</div>

<!-- 공백  (row 3 - col 2)-->
<div style=" height:100%;float:left;width:5%;"></div>

<!-- 소스 저장소 내용 (row 3 - col 3)   -->
<div style=" height:100%;float:left;width:70%;overflow:auto; align:left;">
<h2 align="center"><span class="glyphicon glyphicon-th-list" aria-hidden="true"></span> Code Hub </h2> <!-- bootstrap 기호 추가 -->
   <table class="board_list" text-align="left">
      <colgroup>
         <col width="*"/>
         <col width="40%"/>
         <col width="20%"/>
      </colgroup>
      <thead>
         <tr>
            <th scope="col" text-align="left">Name</th>
            <th scope="col" text-align="left"> Comment</th>
            <th scope="col" text-align="left"> StartDate</th>
         </tr>
      </thead>
      <tbody>
         <c:choose>
            <c:when test="${fn:length(list) > 0}">
               <c:forEach items="${list}" var="row">
                  <tr >
                     <td class="title">
                     <input type='hidden' id='IDX' value="${row.TITLE }">
                        <a href='#this' name='title'>${row.TITLE }</a>
                     </td>
                     <td  > ${row.CONTENTS }</td>
                     <td > ${row.DATE }</td>
                     
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

<!-- 부가적인 이용약관에 대한 내용 (row 4)-->
<footer style="height:50px;width:100%;float:left;background-color: #B26B69;">

</footer>


<!-- script -->
<!-- 로고 버튼에 대한 script(fn-backHome), side menu 버튼에 대한 blog페이지 재호출-->
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

<!-- 스크롤이 300이상시 빈공간을 채워주는 side menu에 대한 내용(row 3 - col 1-1) -->
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

<!-- 소스 저장소에 대한 script  (row 3 - col 3) -->
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