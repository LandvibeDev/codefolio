<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/include/include-body.jspf" %>

	<div class="row" style="padding:15px 15px 15px 15px;">
		<div class="col-md-2">
			<c:set var="img_url" value="${map.IMAGE_URL }" />
				<c:if test="${img_url eq ''}">
					<c:set var="img_url" value="http://dev.naver.com/dbimage.php?id=3955"/>
    			</c:if>
			<img src = "${img_url }" width="200" height="150">
		</div>
  		<div class="col-md-10"><h1>${map.TITLE }</h1> </div>
	</div>
	<div class="row" style="padding:15px 15px 15px 15px;">
		<div class="col-md-8">${topic.NAME }</div>
  		<div class="col-md-4" style="text-align:right;">${map.DATE }</div>
	</div>
	<div class="row" style="padding:15px 15px 15px 15px;">
  		<div>
			<ul>
				<c:forEach var="row" items="${list }">
            		<li>
            			<input type="hidden" id="IDX" value="${row.FILE_IDX }">
                		<a href="#this" name="file">${row.ORIGINAL_FILE_NAME }</a> 
                    	(${row.FILE_SIZE }kb)
                    </li>
        		</c:forEach>
			</ul>
		</div>
	</div>
	<div class="row" style="border-top:1px dotted black; border-bottom:1px dotted black;padding:15px 15px 15px 30px;">
		<div class="col-md-1"></div>
		<div class="col-md-10">
	
		<p class="lead">${map.CONTENTS }</p>
	
		</div>
  		<div class="col-md-1"></div>
	</div>

	
	<div class="row" style="padding:15px 15px 15px 15px;">
		<div class="col-md-8">
			<a href="#this" class="btn" id="list"><span style="color:#000000">목록으로</span></a>
			<a href="#this" class="btn" id="update"><span style="color:#000000">수정하기</span></a>
			<a href="#this" class="btn" id="delete"><span style="color:#000000">삭제하기</span></a>
		</div>
	</div>
	
	<script type="text/javascript">
        $(document).ready(function(){
            $("#list").on("click", function(e){ //목록으로 버튼
                e.preventDefault();
                fn_openBoardList();
            });
             
            $("#update").on("click", function(e){ //수정하기 버튼
                e.preventDefault();
                fn_openBoardUpdate();
            });
            
            $("#delete").on("click", function(e){ //삭제하기 버튼 
                e.preventDefault();
                fn_boardDelete();
            });
             
            $("a[name='file']").on("click", function(e){ //파일 이름
                e.preventDefault();
                fn_downloadFile($(this));
            });
        });
         
        function fn_openBoardList(){
            var comSubmit = new ComSubmit();
            comSubmit.setUrl("<c:url value='/front/blog.do' />");
            comSubmit.submit();
        }
         
        function fn_openBoardUpdate(){
            var idx = "${map.BOARD_IDX}";
            var comSubmit = new ComSubmit();
            comSubmit.setUrl("<c:url value='/front/blogUpdate.do' />");
            comSubmit.addParam("IDX", "${map.BOARD_IDX}");
            comSubmit.addParam("TOPIC_IDX", "${map.TOPIC_IDX}");
            comSubmit.submit();
        }
        
        function fn_boardDelete(){
        	  var idx = "${map.BOARD_IDX}";
              var comSubmit = new ComSubmit();
              comSubmit.setUrl("<c:url value='/board/deleteBoard.do' />");
              comSubmit.addParam("IDX", idx);
              comSubmit.submit();
        }
         
        function fn_downloadFile(obj){
            var idx = obj.parent().find("#IDX").val();
            var comSubmit = new ComSubmit();
            comSubmit.setUrl("<c:url value='/board/downloadFile.do' />");
            comSubmit.addParam("IDX", idx);
            comSubmit.submit();
        }
    </script>
</body>
</html>