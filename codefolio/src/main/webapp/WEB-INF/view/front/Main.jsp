<%@ page contentType="text/html;charset=UTF-8" language="java"%>


<% String cp = request.getContextPath(); %>

<%--ContextPath 선언 --%>

<html>
<head>

<%@ include file="/WEB-INF/include/include-header.jspf" %>
<%@ include file="/WEB-INF/include/include-body.jspf" %>
<%@ include file="/WEB-INF/include/include-Topbase.jspf" %>

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
				<c:forEach items="${timelineJson}" var="timeline">
				
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
		                	"url": "${timeline.IMAGE_URL }",
		                	"credit": "<a href=\"#\" onclick=\"go2Post(${timeline.BOARD_IDX},${timeline.TOPIC_IDX}); \"> Link to [ ${timeline.TITLE} ]</a>"
		                		//"<a href =\'javascript:void(0);\' onclick=\"go2Post(\"ddag\");\">게시판으로</a>"
		            },
		            "text": {
		            	
		                "headline":"${timeline.TITLE}", 
		                "text": "${timeline.TIMELINE_CONTENTS } "
		            },
		            "autolink" : "true"
		        },
				</c:forEach>
		       
		    ]
		
    };
    
    window.timeline = new TL.Timeline('timeline', timelineJson,additionalOptions);
    
   /* function go2Post(str)
    {
    	alert(str);
    }*/
    
    function go2Post(str1, str2)
    {
    	var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/front/blogDetail.do' />");
		comSubmit.addParam("IDX", str1);
		comSubmit.addParam("TOPIC_IDX", str2);
		comSubmit.submit();
    }
    
  /*  function fn_openBoardDetail(obj){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/front/blogDetail.do' />");
		comSubmit.addParam("IDX", obj.parent().find("#IDX").val());
		comSubmit.addParam("TOPIC_IDX", obj.parent().find("#TOPIC_IDX").val());
		comSubmit.submit();
	}*/
    
      
      function fn_dateParse(str){ //date parsing
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