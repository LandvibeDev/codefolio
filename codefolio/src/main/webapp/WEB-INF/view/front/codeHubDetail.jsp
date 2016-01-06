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
<div class="btn-group-vertical" role="group" aria-label="..." style="height:100%;width:95%;"></div>
</div>

<!-- 스크롤이 300이상시 빈공간을 채워준다.(row 3 - col 1-1) -->
<div id="menu_bar_after" style="float:left; ">
</div>

<!-- 공백  (row 3 - col 2)-->
<div style=" height:100%;float:left;width:5%;"></div>


<!-- 소스 저장소 내용 (row 3 - col 3)   -->
<div id="title" style="display:none;">${title}</div>
<div id="filepathTemp" style="display:none;">${filepath}</div>
<div style=" height:100%;float:left;width:70%;overflow:auto;">

<h2 align="center"><span class="glyphicon glyphicon-th-list" aria-hidden="true"></span> ${title}  </h2> <!-- bootstrap 기호 추가 -->
<c:set var="currentPath" value= "${filepath}" />
 <c:set var="currentPathLength" value="${fn:length(currentPath)}"/>
<table class="board_list">
		<colgroup>
			<col width="100%"/>
		</colgroup>
		<thead>
			<tr>
				<th scope="col">${currentPath}</th>
			</tr>
		</thead>
		<tbody>
		<tr>
							<td class="title">
								<a href='#this' name='back'>  ... </a>
							</td>
						</tr>
		  <c:set var="temp" value="0"/>
			<c:set var="init" value="0"/>
			<c:choose>
				<c:when test="${fn:length(list) > 0}">
					<c:forEach items="${list}" var="row"  varStatus="status">
					
					<c:set var="originalPath" value="${row}"/>    
					<c:set var="originalPathLength" value="${fn:length(originalPath)}"/>     
					<c:set var="length" value= "${fn:indexOf(originalPath, \"/\")}"/>
					<c:set var="partialPath" value= "${fn:substring(originalPath, currentPathLength, originalPathLength)}"/>
					<c:set var="test" value= "${fn:contains(partialPath,\"/\" )}"/>
					
					<c:if test = "${fn:startsWith(originalPath, currentPath)}" >    <!-- 현재 경로 해당 -->
					<c:if test = "${fn:contains(partialPath,\"/\" )}" >                  <!-- 디렉토리의 경우 경로 해당 -->
					<c:set var="directoryLength" value="${fn:indexOf(partialPath, \"/\")}"/>      
					<c:set var="directory" value= "${fn:substring(partialPath, 0,directoryLength)}"/>
					 
					<c:if test = "${(directory ne temp)||(temp eq init)}" >        <!-- 디렉토리의 경우 경로 해당 -->
					<tr>
							<td class="title">
							<span class="glyphicon glyphicon-folder-open" aria-hidden="true"></span>
							
							<input type='hidden' id='DIR' value="${directory}">
								<a href='#this' name='directory'> &nbsp ${directory} </a>
								<c:set var="temp" value="${directory}"/>
								<c:set var="init" value="1"/>
							</td>
						</tr>
					</c:if>
					</c:if>
					</c:if>
			    	 <c:if test = "${fn:startsWith(originalPath, currentPath)}" > 
					<c:if test = "${not fn:contains(partialPath,\"/\" )}" > 
						<tr>
							<td class="title">
							 	<span class="glyphicon glyphicon-file" aria-hidden="true"></span>
							<input type='hidden' id='IDX' value="${row}">
								<a href='#this' name='title'>&nbsp${partialPath}</a>
								
							</td>
						</tr>
					</c:if>
					</c:if>
					<c:set var="tempNum" value="${status.index}"/>
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

<!-- 소스 저장소의 파일 업로드에 대한 script  (row 3 - col 3) -->
<script type="text/javascript">

		$(document).ready(function(){
				
			$("a[name='title']").on("click", function(e){ //제목 
				e.preventDefault();
				fn_openBoardDetail($(this));
			});
		});
		
		$(document).ready(function(){
			
			$("a[name='directory']").on("click", function(e){ //제목 
				e.preventDefault();
				fn_openDirectory($(this));
			});
		});
		

	
		
		
		function fn_openBoardDetail(obj){
			var comSubmit = new ComSubmit();
			var TITLE = $('#title').html();
			comSubmit.setUrl("<c:url value='/front/codeHubViewer.do' />");
			comSubmit.addParam("IDX", obj.parent().find("#IDX").val());
			comSubmit.addParam("TITLE", TITLE);
			
			comSubmit.submit();
		}
		
		function fn_openDirectory(obj){
			var comSubmit = new ComSubmit();
			var TITLE = $('#title').html();
			var PATH = $('#filepathTemp').html();
			comSubmit.setUrl("<c:url value='/front/codeHubBrowser.do' />");
			comSubmit.addParam("FILEPATH",PATH+ obj.parent().find("#DIR").val());
			comSubmit.addParam("IDX", TITLE);
			comSubmit.addParam("TITLE", TITLE);
			
			comSubmit.submit();
			
		}
		
	
		
	</script>	
</body>
</html>