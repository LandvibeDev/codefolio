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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.codefolio.common.CommandMap;
import com.codefolio.service.BoardService;
import com.codefolio.service.ProjectService;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 
 * 프로젝트 관련 Controller
 *
 */
// Rest Controller 바꾸기~
@Controller
public class ProjectController {
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "projectService")
	private ProjectService projectService;

	
	/**
	 * 프로젝트 리스트 페이지
	 * 
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/front/codeHubList.do")
	public ModelAndView opencodeHubList(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/front/codeHubList");

		List<Map<String, Object>> list = projectService.selectProjectList(commandMap.getMap());

		mv.addObject("list", list);

		return mv;
	}

	/**
	 * 프로젝트 업로드 결과 페이지
	 * 
	 * @param commandMap
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/front/codeHubResult.do")
	public ModelAndView resultGit(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("/front/codeHubResult");
		// log.debug("request : "+request.toString() + "\n" +
		// commandMap.get("file").toString()+ "\n");
		// sampleService.insertBoard(commandMap.getMap(),request);\
		String result = "";
		result += projectService.gitStore(commandMap.getMap(), request);

		log.debug("result = " + result.toString() + "\n");
		mv.addObject("fileList", result);
		return mv;
	}

	/**
	 * 프로젝트 첫 디렉토리 페이지
	 * 
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/front/codeHubDetail.do")
	public ModelAndView opencodeDetail(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/front/codeHubDetail");

		List<String> list = projectService.getfileList(commandMap.getMap());

		mv.addObject("list", list);
		mv.addObject("title", commandMap.get("IDX"));
		mv.addObject("filepath", "");

		return mv;
	}
	
	/**
	 * 프로젝트 브라우저 페이지
	 * 
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */

	@RequestMapping(value = "/front/codeHubBrowser.do")
	public ModelAndView opencodeBrowser(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/front/codeHubDetail");
		List<String> list = projectService.getfileList(commandMap.getMap());
		mv.addObject("list", list);
		mv.addObject("title", commandMap.get("TITLE"));
		mv.addObject("filepath", commandMap.get("FILEPATH") + "/");
		return mv;
	}

	/**
	 * 파일 뷰 페이지
	 * 
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/front/codeHubViewer.do")
	public ModelAndView opencodeViewer(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("/front/codeHubViewer");

		mv.addObject("source", projectService.getSource(commandMap.getMap()));

		return mv;
	}


}