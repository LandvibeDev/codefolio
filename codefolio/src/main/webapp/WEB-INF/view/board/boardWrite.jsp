<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
</head>
<body>
 	<form id="frm" name="frm" enctype="multipart/form-data"> <!-- 첨부파일  -->
		<table class="board_view">
			<colgroup>
				<col width="15%">
				<col width="*"/>
			</colgroup>
			<caption>게시글 작성</caption>
			<tbody>
				<tr>
					<th scope="row">제목</th>
					<td><input type="text" id="TITLE" name="TITLE" class="wdp_90"></input></td>
				</tr>
				<tr>
					<th scope="row">사진 URL</th>
					<td><input type="text" id="IMAGE_URL" name="IMAGE_URL" class="wdp_90"></input></td>
				</tr>
				
				<tr>
					<th scope="row">내용</th>
					<td colspan="2" class="view_text">
						<textarea rows="20" cols="100" title="내용" id="CONTENTS" name="CONTENTS"></textarea>
					</td>
				</tr>
			</tbody>
		</table>
			<p>
				<input type="file" name="file" id="file"> <!-- 첨부파일  -->
        		<a href="#this" class="btn" id="delete" >파일삭제</a>
        	</p>
         
        <br/><br/>		
		<a href="#this" class="btn" id="write">작성하기</a>
		<a href="#this" class="btn" id="list">목록으로</a>
	</form>
	
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
		
		
		$(document).ready(function() {
			$("#list").on("click", function(e) { //목록으로 버튼
				e.preventDefault();
				fn_openBoardList();
			});

			$("#write").on("click", function(e) { //작성하기 버튼
				e.preventDefault();
				fn_insertBoard();

			});

			var domEleArray = [ $('#file').clone() ];
			$('#delete').click(function() {		//첨부파일 초기화(삭제)
				domEleArray[1] = domEleArray[0].clone(true); // 쌔거(0번) -> 복사(1번)
				$('#file').replaceWith(domEleArray[1]);
			});
		});

		function fn_openBoardList() { //목록 버튼
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/board/openBoardList.do' />");
			comSubmit.submit();

		}

		function fn_insertBoard() { //작성 버튼 
			var comSubmit = new ComSubmit("frm");
			comSubmit.setUrl("<c:url value='/board/insertBoard.do' />");
			comSubmit.submit();
		}

		function fn_deleteFile(obj) { //삭제 버튼 
			obj.parent().remove();
		}
	</script>
</body>
</html>