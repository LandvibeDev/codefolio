<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
</head>
<body>
	<table class="board_view">
		<colgroup>
			<col width="15%"/>
			<col width="35%"/>
			<col width="15%"/>
			<col width="35%"/>
		</colgroup>
		<caption>게시글 상세</caption>
		<tbody>
			<tr>
				<th scope="row">글 번호</th>
				<td>${map.BOARD_IDX }</td>
				<th scope="row">조회수</th>
				<td>${map.COUNT }</td>
			</tr>
			<tr>
				<th scope="row">작성자</th>
				<td>${map.NAME }</td>
				<th scope="row">작성시간</th>
				<td>${map.DATE }</td>
			</tr>
			<tr>
				<th scope="row">사진</th>
				<c:set var="img_url" value="${map.IMAGE_URL }" />
					<c:if test="${img_url eq ''}">
						<c:set var="img_url" value="http://dev.naver.com/dbimage.php?id=3955"/>
    				</c:if>
				<td colspan="3"><img src = "${img_url }" width="300" height="200"></td>
			</tr>
			<tr>
				<th scope="row">제목</th>
				<td colspan="3">${map.TITLE }</td>
			</tr>
			<tr>
				<td colspan="4">${map.CONTENTS }</td>
			</tr>
			 <tr>
                <th scope="row">첨부파일</th>
                <td colspan="3">
                    <c:forEach var="row" items="${list }">
                        <input type="hidden" id="IDX" value="${row.BOARD_IDX }">
                        <a href="#this" name="file">${row.ORIGINAL_FILE_NAME }</a> 
                        (${row.FILE_SIZE }kb)
                    </c:forEach>
                </td>
            </tr>
		</tbody>
	</table>
	
	<a href="#this" class="btn" id="list">목록으로</a>
	<a href="#this" class="btn" id="update">수정하기</a>
	
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
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