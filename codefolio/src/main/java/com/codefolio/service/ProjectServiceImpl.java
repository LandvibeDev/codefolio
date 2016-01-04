package com.codefolio.service;

import java.util.Map.Entry;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.codefolio.dao.BoardDAO;
import com.codefolio.dao.ProjectDAO;
import com.codefolio.util.FileUtils;
import com.codefolio.util.GitUtils;


/*
 *  게시판 관련 비지니스 계층 
 * 
 */
@Service("projectService")
public class ProjectServiceImpl implements ProjectService{
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Resource(name="projectDAO")
	private ProjectDAO projectDAO;
	
	@Resource(name="gitUtils")
	private GitUtils gitUtils;
	
	
	
	@Override
	public String gitStore(Map<String, Object> map, HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		String result= "";
		String projectName="";
		projectName = fileUtils.makegit(map, request);
		log.debug("projectName : "+projectName );
			result = gitUtils.getProjectList(projectName, 4);
			map.put("projectName", projectName);
		
			projectDAO.insertProject(map);
			return result;
	}
	
	
	
}
