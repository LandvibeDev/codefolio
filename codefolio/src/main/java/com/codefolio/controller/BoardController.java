package com.codefolio.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.codefolio.common.CommandMap;
import com.codefolio.service.BoardService;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**
 * 
 * 게시판 관련 Controller
 *
 */
@Controller
public class BoardController {
	Logger log = Logger.getLogger(this.getClass());
	
	
	@Resource(name="boardService")
	private BoardService boardService;
	

	/**
	 * 게시판 리스트 페이지   
	 * @param commandMap
	 * @param request
	 * @return
	 * @throws Exception
	 */  
	@RequestMapping(value="/board/openBoardList.do")
	public ModelAndView openBoardList(CommandMap commandMap,HttpServletRequest request) throws Exception{
	    ModelAndView mv = new ModelAndView("/board/boardList");
	    
	    commandMap.put("T_IDX", request.getAttribute("TOPIC_IDX")==null||request.getAttribute("TOPIC_IDX").equals("undefined")?
	    		-1:request.getAttribute("TOPIC_IDX"));
	    
	    Map<String,Object> resultMap = boardService.selectBoardList(commandMap.getMap());
	     
	    mv.addObject("paginationInfo", (PaginationInfo)resultMap.get("paginationInfo"));
	    mv.addObject("list", resultMap.get("result"));
	     
	    return mv;
	}
	
	
	/**
	 * 게시글 작성 페이지 
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/openBoardWrite.do")
	public ModelAndView openBoardWrite(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("/board/boardWrite");
		
		List<Map<String, Object>> list = boardService.selectTopicList(commandMap.getMap());
		mv.addObject("topicList", list);
		
		return mv;
	}
	
	
	/**
	 * 게시글 작성  
	 * @param commandMap
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/insertBoard.do")
	public ModelAndView insertBoard(CommandMap commandMap ,HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("redirect:/front/blog.do");
		boardService.insertBoard(commandMap.getMap());
		
		return mv;
	}
	
	/**
	 * 파일 업로
	 * @param commandMap
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/insertFile.do")
	public ModelAndView insertFile(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("/FileNotice");
		boardService.insertFile(commandMap.getMap(), request);

		return mv;
	}
	
	
	/**
	 * 게시글 상세보기 페이지 
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/openBoardDetail.do")
	public ModelAndView openBoardDetail(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("/board/boardDetail");
		
		Map<String,Object> map = boardService.selectBoardDetail(commandMap.getMap(),true);
		mv.addObject("map", map.get("map"));
		mv.addObject("list", map.get("list"));
		mv.addObject("topic", map.get("topicInfo"));
		
		return mv;
	}

	
	/**
	 * 게시글 수정 페이지 
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/openBoardUpdate.do")
	public ModelAndView openBoardUpdate(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("/board/boardUpdate");
		
		Map<String,Object> map = boardService.selectBoardDetail(commandMap.getMap(),false);
		mv.addObject("map", map.get("map"));
		mv.addObject("topicInfo", map.get("topicInfo"));
		List<Map<String, Object>> list = boardService.selectTopicList(commandMap.getMap());
		mv.addObject("topicList", list);
		
		return mv;
	}
	
	/**
	 * 게시글 수정 
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/updateBoard.do")
	public ModelAndView updateBoard(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("redirect:/front/blogDetail.do");
		
		boardService.updateBoard(commandMap.getMap());
		mv.addObject("TOPIC_IDX", commandMap.get("TOPIC_IDX"));
		mv.addObject("IDX", commandMap.get("IDX"));
		return mv;
	}
	
	/**
	 * 게시글 삭제 
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/deleteBoard.do")
	public ModelAndView deleteBoard(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("redirect:/front/blog.do");
		
		boardService.deleteBoard(commandMap.getMap());
		
		return mv;
	}
	

	/**
	 * 파일 다운로드 요청 
	 * @param commandMap
	 * @param response
	 * @throws Exception
	 */
	 @RequestMapping(value="/board/downloadFile.do")
	    public void downloadFile(CommandMap commandMap, HttpServletResponse response) throws Exception{
		 	
		 	Map<String,Object> map = boardService.selectFileInfo(commandMap.getMap());
	        String storedFileName = (String)map.get("STORED_FILE_NAME");
	        String originalFileName = (String)map.get("ORIGINAL_FILE_NAME");
	        
	        byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(
	        		new File("/Users/kimgh6554/Documents/Dev/File/"+storedFileName)); // 서버의 저장경로
	        //byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("C:\\dev\\file\\"+storedFileName)); //window
	        response.setContentType("application/octet-stream");
	        response.setContentLength(fileByte.length);
	        response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(originalFileName,"UTF-8")+"\";");
	        response.setHeader("Content-Transfer-Encoding", "binary");
	        response.getOutputStream().write(fileByte);
	         
	        response.getOutputStream().flush();
	        response.getOutputStream().close();
	        
	    }
}
