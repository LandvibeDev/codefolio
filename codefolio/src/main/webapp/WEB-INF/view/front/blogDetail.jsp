<%@ page contentType="text/html;charset=UTF-8" language="java"%>


<html>
<head>
<!-- include 부분 -->
<%@ include file="/WEB-INF/include/include-header.jspf" %>
<%@ include file="/WEB-INF/include/include-body.jspf" %>
<%@ include file="/WEB-INF/include/include-Topbase.jspf" %>
   
</head>
<body >

    
<!-- 세번째 층에 대한 내용 -->
<div  style=" width:100%;height:1500px;border:none;" >


<!-- 세번째 층의 왼쪽 메뉴목록 -->
<!-- 밑의 script 참고 -->
<!-- 스크롤 이동에 대한 menu_bar에 스타일을 지정 -->

<div id="menu_bar" style="height:100%;width:15%;float:left;">

		<div class="btn-group-vertical" role="group" aria-label="..." >
				<p style="margin:0px; padding:0px;"/>
				<button class="btn" name='topicBtn' style="height:30pt;width:217pt;">모든글보기</button>
			<c:forEach var="topic" items="${topicList }">
				<p style="margin:0px; padding:0px"/>
				<input type='hidden' id='IDX' value="${topic.TOPIC_IDX }">
				<button class="btn" name='topicBtn' style="height:30pt;width:217pt;" >${topic.NAME }</button>
	    	</c:forEach>
		</div>
	</div>

<div id="menu_bar_after" style="float:left; ">
</div>




<!--세번째 층의 게시판 목록 리스트에 대한 jsp 호출   -->
<div style=" height:100%;float:left;width:80%;overflow:auto;">
<jsp:include page="/board/openBoardDetail.do" flush="false"/>
</div>

</div>


<!-- 부가적인 꼬리말에 대한 층 -->
<footer style="height:50px;width:100%;float:left;background-color: #B26B69;">

</footer>



<!-- script -->

<!-- 첫번째 "codeFOLIO" 버튼에 대한 script -->
<script type="text/javascript">
	$(document).ready(function(){
		$("#Cf").on("click", function(e){ 
			e.preventDefault();
			fn_backHome();
		});
		
		$("button[name='topicBtn']").on("click", function(e){ 
			e.preventDefault();
			fn_boardChange($(this));
		});
		
		
		
	});
	
	function fn_backHome(){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/front/Main.do' />");
		comSubmit.submit();
	}
	
	function fn_boardChange(obj){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/front/blog.do' />");
		comSubmit.addParam("TOPIC_IDX", obj.parent().find("#IDX").val());
		comSubmit.submit();
	}
	
	
	
	
</script>		
 <!-- 네번째 층의 왼쪽  메뉴 스크롤시 상단 고정에 대한 스크립트 -->
 <script> 
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