<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
<script src="<%=cp%>/resources/bootstrap/js/bootstrap.js"></script>
</head>
<body>
<%@ include file="/WEB-INF/include/include-body.jspf" %>


	<form id="frm" enctype="multipart/form-data">
	
	<div class="row" style="padding:15px 15px 15px 15px;">
		<div class="col-md-1"></div>
  		<div class="col-md-10">
  			<div class="dropdown">
  			<button class="btn btn-default btn-lg dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">
    				<font color="#808080">주제</font>
    			<span style="color:808080" class="caret"></span>
  			</button>
  			
  			<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
  				<c:forEach var="topic" items="${topicList }">
            		<li role="presentation">
            			<input type="hidden" id="TOPIC_IDX" value="${topic.TOPIC_IDX }">
            			<a role="menuitem" tabindex="${topic.TOPIC_IDX }">${topic.NAME }</a>
            		</li>
        		</c:forEach>
  			</ul>
			</div>
  		</div>
	</div>
	
	<div class="row" style="padding:15px 15px 15px 15px;">
		<div class="col-md-1"></div>
  		<div class="col-md-10">
  			<div class="form-group">
    			<label for="TITLE">제목 </label>
    			<input type='text' class="form-control" id="TITLE" name="TITLE" placeholder="제목을 입력하세요" style="height:40px;">
    		</div>
  		</div>
	</div>
	<div class="row" style="padding:5px 15px 15px 15px;">
		<div class="col-md-1"></div>
  		<div class="col-md-10">
  			<div class="form-group">
    			<label for="CONTENTS">내용 </label>
    			<textarea id="CONTENTS" name="CONTENTS"></textarea>
  			</div>
  		</div>
	</div>
	<div class="row" style="padding:5px 15px 15px 15px;">
		<div class="col-md-1"></div>
  		<div class="col-md-10">
  			<a href="#this" class="btn" id="write"><span style="color:#000000">작성하기</span></a>
			<a href="#this" class="btn" id="list"><span style="color:#000000">목록으로</span></a>
  		</div>
	</div>
	
	</form>
	
	
	<script type="text/javascript">
	
	
	 var ckeditor_config = {
			 	
	            resize_enabled : true, // 에디터 크기를 조절가능
	            enterMode : CKEDITOR.ENTER_BR , // 엔터키를 <br> 로 적용함.
	            shiftEnterMode : CKEDITOR.ENTER_P ,  // 쉬프트 +  엔터를 <p> 로 적용함.
	            toolbarCanCollapse : true ,
	            height:'400',
	            removePlugins : "elementspath",
	           	filebrowserUploadUrl: "http://localhost:9090/codefolio/board/insertFile.do" , // 파일 업로드를 처리 할 경로 설정.
	           	/*  filebrowserBrowseUrl : '/ckfinder/ckfinder.html',
	            filebrowserImageBrowseUrl : '/ckfinder/ckfinder.html?Type=Images',
	            filebrowserFlashBrowseUrl : '/ckfinder/ckfinder.html?Type=Flash',
	            filebrowserUploadUrl : '/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Files',
	            filebrowserImageUploadUrl : '/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Images',
	            filebrowserFlashUploadUrl : '/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Flash', */
	            
	            // 에디터에 사용할 기능들 정의
	            toolbar :[ 
	            	['Source','-','Save','NewPage','Preview','-','Templates'],
	            	['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print', 'SpellChecker', 'Scayt'],
	            	['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
	            	['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField'],
	            	['BidiLtr', 'BidiRtl'],
	            	'/',
	            	['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
	            	['NumberedList','BulletedList','-','Outdent','Indent','Blockquote','CreateDiv'],
	            	['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
	            	['Link','Unlink','Anchor'],
	            	['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],
	            	'/',
	            	['Styles','Format','Font','FontSize'],
	            	['TextColor','BGColor'],
	            	['Maximize', 'ShowBlocks','-','About']
	            ]
	            	
	            	

	          };

	 CKEDITOR.replace( "CONTENTS" , ckeditor_config );
	
	 	
	 
	  $(document).ready(function() {
			$("#list").on("click", function(e) { //목록으로 버튼
				e.preventDefault();
				fn_openBoardList();
			});

			$("#write").on("click", function(e) { //작성하기 버튼
				e.preventDefault();
				fn_insertBoard();
			});
			$(".dropdown-menu li a").click(function(){ // 버튼 이름 변경 
		 		
		 		$("#dropdownMenu1").html('<font color="#808080">'+$(this).text()+'</font> <span style="color:808080" class="caret"></span>');
		 		topic_idx = $(this).parent().find("#TOPIC_IDX").val();
			}); 

			
		});

		function fn_openBoardList() { //목록 버튼
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/front/blog.do' />");
			comSubmit.submit();

		}

		function fn_insertBoard() { //작성 버튼 
			var comSubmit = new ComSubmit('frm');
			comSubmit.setUrl("<c:url value='/board/insertBoard.do' />");
			if(typeof topic_idx === 'undefined'){
				topic_idx = 0;
			}
			comSubmit.addParam("TOPIC_IDX",topic_idx);
			comSubmit.submit();
		}
		
		
	</script>
</body>
</html>