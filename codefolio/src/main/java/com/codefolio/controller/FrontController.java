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
public class FrontController {
	Logger log = Logger.getLogger(this.getClass());
	
	
	@Resource(name="boardService")
	private BoardService boardService;
	
	// Main 페이지
	@RequestMapping(value = "/front/Main.do")
	public ModelAndView openMainTimeline(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/front/Main");
		List<Map<String, Object>> timelines = boardService.selectTimelineList(commandMap.getMap());
		mv.addObject("timelineJson", timelines);

		return mv;
	}

	// Blog 페이지
	@RequestMapping(value = "/front/blog.do")
	public ModelAndView openBlogList(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/front/blog");

		return mv;
	}

	// BlogDetail 페이지
	@RequestMapping(value = "/front/blogDetail.do")
	public ModelAndView openBlogDetail(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/front/blogDetail");

		return mv;
	}

	// BlogUpdate 페이지
	@RequestMapping(value = "/front/blogUpdate.do")
	public ModelAndView openBlogUpdate(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/front/blogUpdate");

		return mv;
	}

	// BlogWrite 페이지
	@RequestMapping(value = "/front/blogWrite.do")
	public ModelAndView openBlogWrite(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/front/blogWrite");

		return mv;
	}
	
	
	
	
	
}