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


/*
 * BoardController : 게시판 관련 Controller 
 * 
 */
@Controller
public class BoardController {
	Logger log = Logger.getLogger(this.getClass());
	
	
	@Resource(name="boardService")
	private BoardService boardService;
	

	//게시판 리스트 페이지    
	@RequestMapping(value="/board/openBoardList.do")
	public ModelAndView openBoardList(CommandMap commandMap) throws Exception{
	    ModelAndView mv = new ModelAndView("/board/boardList");
	     
	    Map<String,Object> resultMap = boardService.selectBoardList(commandMap.getMap());
	     
	    mv.addObject("paginationInfo", (PaginationInfo)resultMap.get("paginationInfo"));
	    mv.addObject("list", resultMap.get("result"));
	     
	    return mv;
	}
	
	//게시글 작성 페이지 
	@RequestMapping(value="/board/openBoardWrite.do")
	public ModelAndView openBoardWrite(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("/board/boardWrite");
		
		return mv;
	}
	
	//게시글 작성 
	@RequestMapping(value="/board/insertBoard.do")
	public ModelAndView insertBoard(CommandMap commandMap ,HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView("redirect:/front/blog.do");
		boardService.insertBoard(commandMap.getMap(),request);
		
		return mv;
	}
	
	
	//게시글 상세보기 페이지 
	@RequestMapping(value="/board/openBoardDetail.do")
	public ModelAndView openBoardDetail(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("/board/boardDetail");
		
		Map<String,Object> map = boardService.selectBoardDetail(commandMap.getMap());
		mv.addObject("map", map.get("map"));
		mv.addObject("list", map.get("list"));
		
		return mv;
	}
	
	//게시글 수정 페이지 
	@RequestMapping(value="/board/openBoardUpdate.do")
	public ModelAndView openBoardUpdate(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("/board/boardUpdate");
		
		Map<String,Object> map = boardService.selectBoardDetail(commandMap.getMap());
		mv.addObject("map", map);
		
		return mv;
	}
	
	//게시글 수정 
	@RequestMapping(value="/board/updateBoard.do")
	public ModelAndView updateBoard(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("redirect:/front/blogDetail.do");
		
		boardService.updateBoard(commandMap.getMap());
		
		mv.addObject("IDX", commandMap.get("IDX"));
		return mv;
	}
	
	//게시글 삭제 
	@RequestMapping(value="/board/deleteBoard.do")
	public ModelAndView deleteBoard(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("redirect:/front/blog.do");
		
		boardService.deleteBoard(commandMap.getMap());
		
		return mv;
	}
	

	//파일 다운로드 요청 
	 @RequestMapping(value="/board/downloadFile.do")
	    public void downloadFile(CommandMap commandMap, HttpServletResponse response) throws Exception{
	        Map<String,Object> map = boardService.selectFileInfo(commandMap.getMap());
	        String storedFileName = (String)map.get("STORED_FILE_NAME");
	        String originalFileName = (String)map.get("ORIGINAL_FILE_NAME");
	        
	        byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("/Users/kimgh6554/Documents/Dev/File/"+storedFileName)); //mac
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
