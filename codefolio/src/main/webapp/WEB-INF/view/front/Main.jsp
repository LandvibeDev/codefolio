<%@ page contentType="text/html;charset=UTF-8" language="java"%>


<% String cp = request.getContextPath(); %>

<%--ContextPath 선언 --%>

<html>
<head>

<%@ include file="/WEB-INF/include/include-header.jspf" %>
<%@ include file="/WEB-INF/include/include-body.jspf" %>


	<!-- timelineJS -->
	<link title="timeline-styles" rel="stylesheet" href="//cdn.knightlab.com/libs/timeline3/latest/css/timeline.css">
    <script src="//cdn.knightlab.com/libs/timeline3/latest/js/timeline.js"></script>
    <script type="text/javascript" src="https://cdn.knightlab.com/libs/timeline/latest/js/timeline-min.js"></script>
   
	 <!-- CSS-->
    <link rel="stylesheet" href="../css/timeline.css?v1">
    <!--FONT-->
    <link rel="stylesheet" href="../css/fonts/font.default.css?v1">
    <!-- Style-->
    <style>
      html, body {
      	height:100%;
      	width:100%;
      	padding: 0px;
      	margin: 0px;
      	text-align: right;
      }
      .tl-timeline {
      
      }
      
    </style> 
  </head>
  
 
    
    
     

  </head>
  <body >
 <!-- 첫 번째 층에 대한 내용 -->	
 <div style="height:12%;width:100% ; float:left; " >
  <!-- 첫 번째 층의 왼쪽 홈 버튼 -->
<div style="background-color :#75A3A3; height:100%;width:30%;float:left ;" >
<button type="button" class="btn btn-default btn-lg " style="float:left ;background-color :#75A3A3;" ><span class="glyphicon glyphicon-home" aria-hidden="true" style="color:#000000" ></span></button>
</div>
<!-- 첫번째 층 중간의 "codeFOLIO" 마크버튼 구현 -->
<!-- script 이용 id=Cf -->
<div style="background-color: #75A3A3; height:100%;width:40% ;float:left; " >
		
 		<a href="#this"  id="Cf">
 		<span style="color:#ffffff; " ><button  style=" WIDTH: 100%; HEIGHT: 100%; padding:0%;margin:0%; font-size: 40pt; background-color:#75A3A3;border:0;float:left;"   type="button"><em>CodeFOLIO</em></button></span>
		 </a>
		 
		
	</div>



	<!-- 상단 우측 -->
 <div class="dropdown" style="background-color :#75A3A3;  padding:3%; height:100%;width:30% ;float:left;" >
      	
   	<ul class="nav nav-tabs">
  <li><a href="#"><span style="color:#000000 " ><strong></strong>홈</span></a></li>
  <li role="presentation" class="dropdown">
    <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
      <span style="color:#000000 " ><strong>계정 관리</strong></span> <span class="caret"></span>
    </a>
    <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
    <li><a href="#">비밀번호 변경</a></li>
    <li><a href="#">회원 탈퇴</a></li>
    <li><a href="#">로그아웃</a></li>
    <li role="separator" class="divider"></li>
    <li><a href="#">고객 센터</a></li>
  </ul>
  
    
  </li>
  <li><a href="#"><span style="color:#000000 " ><strong>메시지</strong></span></a></li>
  <li><a href="#"><span style="color:#000000 " ><strong>알림</strong></span></a></li>
</ul>
 		
</div><!-- /.row -->
</div>



<!-- 메뉴 바 -->
<div  style="width:100%;height:7%;float:left;background-color :#75A3A3;">
<div style="height:100%;width:35%;float:left;">
<form class="navbar-search pull-left" >
  <input type="text" class="search-query" placeholder="검색" style="background-color :#FFFFFF; height:30pt;width:200pt ">
	<button type="submit" class="btn btn-default-center" style="height:30pt;width:60pt">Submit</button>
</form>
</div>

<div style="height:100%;width:40%;float:left;">
	<ul class="nav nav-pills">

  <li role="presentation" ><a href="/codefolio/front/codeHub.do">소스 저장소</a></li>
  <li role="presentation" ><a href="/codefolio/front/blog.do">코드 포스팅</a></li>
  <li role="presentation" ><a href="">개인 포트폴리오 관리</a></li>
  <li role="presentation" class="disabled"><a href="">팀 프로젝트 내역</a></li>


</ul>
</div>
<div style="height:100%;width:25%;float:left;"></div>

</div>



<!--중간  timeline -->
<div id="timeline" style="width:100%;height:75%;float:left;">
</div>


<!-- 하단 -->
 <div style="width:100%;height:6%;float:left;background-color: #B26B69;">
 </div>
 

    <!-- JavaScript-->
    
    
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
    
    
    <script>

    var additionalOptions = {
            start_at_end: true,
            default_bg_color: {r:255, g:255, b:255},
            timenav_height_percentage : 30,
            timenav_height_min : 100,
            //timenav_mobile_height_percentage : 40
            //track_events: 'zoom_in'
            //hash_bookmark:true
          }
    
    var timelineJson  = {
 			"eras":{ 
				"start_date": {
	                "year":			"2010",
	                "month":		"1",
	                "day": 			"1",
	                "hour": 		"0",
	                "minute": 		"0",
	                "second": 		"0",
	                "millisecond": 	"",
	                "format": 		""
	            },
	            "end_date" :{
	            	 "year":			"2020",
		             "month":			"12",
		             "day": 			"31",
		             "hour": 			"11",
		             "minute": 			"59",
		             "second": 			"59",
		             "millisecond": 	"",
		             "format": 			""
	            },
	            "text": {
	                "headline": "The Code Folio??"
	            }
				
			},
		    "scale": "human",
		    "events": [ 		
				<c:forEach items="${timelineJson }" var="timeline">
				
				{
		            "start_date": {
		                "year":			fn_dateParse("${timeline.DATE}")[0],
		                "month":		fn_dateParse("${timeline.DATE}")[1],
		                "day": 			fn_dateParse("${timeline.DATE}")[2],
		                "hour": 		fn_dateParse("${timeline.DATE}")[3],
		                "minute": 		fn_dateParse("${timeline.DATE}")[4],
		                "second": 		fn_dateParse("${timeline.DATE}")[5],
		                "millisecond": 	"",
		                "format": 		""
		            },
		            "media": {
		                	"url": fn_urlDefault("${timeline.IMAGE_URL}"),
		                	"credit": "<a href ='openBoardList.do' id = 'board'>게시판으로</a>"
		            },
		            "text": {
		            	
		                "headline":"${timeline.TITLE}", 
		                "text": fn_contentSlice("${timeline.CONTENTS}")
		            },
		            "autolink" : "true"
		        },
				</c:forEach>
		       
		    ]
		
    };
    window.timeline = new TL.Timeline('timeline', timelineJson,additionalOptions);
    
   
      
      function fn_dateParse(str){ //date parse
  		var dateList = new Array();
      	var date = str.split(/[-:. ]/);
      	dateList.push(date[0]);	//year
      	dateList.push(date[1]);	//month
      	dateList.push(date[2]);	//day
      	dateList.push(date[3]);	//hour
      	dateList.push(date[4]);	//minute
      	dateList.push(date[5]);	//second
      	
      	return dateList;
  	}
      function fn_urlDefault(url){
      	if(url == ""){
      		return "http://dev.naver.com/dbimage.php?id=3955";
      	}
      		
      	return url;
      }
      
      function fn_contentSlice(content){ 	//content를 200글자 이하로 축소 
      	if(content.length>200){
      		return content.slice(0,200);
      	}
      	return content;
      
      }
   
        
    
     /*  $(document).ready(function(){
			$("#board").on("click", function(e){ //제목 
				e.preventDefault();
				fn_openBoardDetail($(this));
			});
      });
      function fn_openBoardDetail(obj){
			 var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/openBoardDetail.do' />");
			comSubmit.addParam("IDX", obj.parent().find("#IDX").val());
			comSubmit.submit(); 
		}
		 */
    
     
      </script>
 
    
      
    
  </body>
</html>

</body>
</html>