<%@ page contentType="text/html;charset=UTF-8" language="java"%>


<html>
<head>
<!-- include 부분 -->
<%@ include file="/WEB-INF/include/include-header.jspf" %>
<%@ include file="/WEB-INF/include/include-body.jspf" %>
<%@ include file="/WEB-INF/include/include-Topbase.jspf" %>
   
</head>
<body >

<!-- side menu와 게시판에 대한 내용 (row 3)-->
<div  style=" width:100%;height:1500px;border:none;" >


<!-- side menu (row 3 - col 1)-->
<!-- 밑의 script 참고 -->
<!-- 스크롤 이동에 대한 menu_bar에 스타일을 지정 -->
<!--side menu 버튼에 해당하는 게시판 내용  -->
<div id="menu_bar" style="height:100%;width:15%;float:left;">
		<form id='frmTopic' class="form-inline">
  			<div class="form-group">
    			<input type="text" class="form-control" id="NAME" name="NAME" placeholder="카테고리 추가" style="height:30pt;width:175pt;">
  				<button type="button" class="btn btn-primary" id="addTopic" style="height:30pt;width:35pt;">
  					<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
  				</button>
  			</div>
 		</form>
 		
	
		<div class="btn-group-vertical" role="group" aria-label="..." >
				<p style="margin:0px; padding:0px;"/>
				<button class="btn btn-primary" name='topicBtn' style="height:30pt;width:217pt;">모든글보기</button>
			<c:forEach var="topic" items="${topicList }">
				<p style="margin:0px; padding:0px"/>
				<input type='hidden' id='IDX' value="${topic.TOPIC_IDX }">
				<button class="btn btn-primary" name='topicBtn' style="height:30pt;width:217pt;" >${topic.NAME }</button>
	    	</c:forEach>
		</div>
	</div>

<!-- 스크롤이 300이상시 빈공간을 채워준다.(row 3 - col 1-1) -->
<div id="menu_bar_after" style="float:left; ">
</div>

<!-- 게시판 (row 3 - col 2)-->
<div style=" height:100%;float:left;width:70%;overflow:auto;">
	<jsp:include page="/board/openBoardList.do" flush="false">
		<jsp:param name="TOPIC_IDX" value="${TOPIC_IDX }" />
	</jsp:include>
</div>

<!-- 공백 (row 3 - col 3)-->
<div style=" height:100%;float:left;width:15%;overflow:auto;">
</div>

</div>


<!-- 부가적인 이용약관에 대한 내용 (row 4)-->
<footer style="height:50px;width:100%;float:left;background-color: #B26B69;">

</footer>


<!-- script -->

<!-- 로고 버튼에 대한 script(fn-backHome), 카테고리 추가 버튼에 대한 script(fn-boardChange)-->
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
		$("#addTopic").on("click", function(e){ 
			e.preventDefault();
			fn_addTopic();
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
	function fn_addTopic(){
		var comSubmit = new ComSubmit('frmTopic');
		comSubmit.setUrl("<c:url value='/front/insertTopic.do' />");
		comSubmit.submit();
	}
	
	
	
</script>		

<!-- 스크롤이 300이상시 빈공간을 채워주는 side menu에 대한 내용(row 3 - col 1-1) -->
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