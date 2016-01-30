<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
</head>
<body>
	<div class="row" style="padding:15px 15px 15px 15px;">
		<div class="col-md-1"></div>
  		<div class="col-md-11">
			<table class="board_list">
				<colgroup>
					<col width="*"/>
					<col width="10%"/>
					<col width="20%"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">카테고리 이름</th>
						<th scope="col">조회수</th>
						<th scope="col">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(list) > 0}">
							<c:forEach items="${list }" var="row">
								<tr>
									<td class="title">
										<input type='hidden' id='TOPIC_IDX' value="${row.TOPIC_IDX }">
										<input type='hidden' id='IDX' value="${row.BOARD_IDX }">
										<a href='#this' name='title'>${row.TITLE }</a>
									</td>
									<td style="font-size:13px">${row.COUNT }</td>
									<td style="font-size:13px">${row.DATE }</td>
								</tr>
						
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="3">조회된 결과가 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>
	<br/>
	<div align="center" class="row" style="padding:15px 15px 15px 15px;">
			<c:if test="${not empty paginationInfo}">
       			<ui:pagination paginationInfo = "${paginationInfo}" type="text" jsFunction="fn_search"/>
    		</c:if>
    		<input type="hidden" id="currentPageNo" name="currentPageNo"/>
	</div>
	<div class="row" style="padding:15px 15px 15px 15px;">
		<div class="col-md-1"></div>
		<div class="col-md-11">
			<a href="#this" class="btn" id="write"><span style="color:#000000">글쓰기</span></a>
		</div>
	</div>	
	
	
		
		
		
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#write").on("click", function(e){ //글쓰기 버튼
				e.preventDefault();
				fn_openBoardWrite();
			});	
			
			$("a[name='title']").on("click", function(e){ //제목 
				e.preventDefault();
				fn_openBoardDetail($(this));
			});
		});
	
		function fn_openBoardWrite(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/front/blogWrite.do' />");
			comSubmit.submit();
		}
		
		function fn_openBoardDetail(obj){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/front/blogDetail.do' />");
			comSubmit.addParam("IDX", obj.parent().find("#IDX").val());
			comSubmit.addParam("TOPIC_IDX", obj.parent().find("#TOPIC_IDX").val());
			comSubmit.submit();
		}
		
		 function fn_search(pageNo){
	            var comSubmit = new ComSubmit();
	            comSubmit.setUrl("<c:url value='/front/blog.do' />");
	            comSubmit.addParam("currentPageNo", pageNo);
	            comSubmit.submit();
	        }
	</script>	
	
</body>
</html>