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
<div id="menu_bar" style="height:100%;width:15%;float:left; ">
<div class="btn-group-vertical" role="group" aria-label="..." style="height:100%;width:95%;">
  <button type="button" class="btn ">SPRING</button>
  <button type="button" class="btn ">JAVASCRIPT</button>

  <div class="btn-group" role="group">
    <button type="button" class="btn " data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
      Dropdown
      <span class="caret"></span>
    </button>
    <ul class="dropdown-menu" style="width:100%;">
      <li><a href="#">Dropdown link</a></li>
      <li><a href="#">Dropdown link</a></li>
    </ul>
  </div>
</div>
</div>

<!-- 스크롤이 300이상시 빈공간을 채워준다.(row 3 - col 1-1) -->
<div id="menu_bar_after" style="float:left; ">
</div>

<!-- 공백  (row 3 - col 2)-->
<div style=" height:100%;float:left;width:5%;"></div>


<!-- 소스 저장소 내용 (row 3 - col 3)   -->
<div style=" height:100%;float:left;width:70%;overflow:auto;">


${fileList}


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



</body>
</html>