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
import com.codefolio.util.TimelineUtils;


/**
 * 프로젝트 관련 서비스 계층
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
	
	@Resource(name="timelineUtils")
	private TimelineUtils timelineUtils;
	
	
	/**
	 * TimelineJS 정보
	 * @return DB data 에서 TimelineJS에 쓰일 정보들 추출 
	 */

	@Override
	public List<Map<String, Object>> selectProjectList(Map<String, Object> map) throws Exception {
	    return timelineUtils.extractUrlContentsFromProject(projectDAO.selectProjectList(map));
	}
	

	/**
	 * 로컬 저장소에 git repositoy 생성, 업로드한 프로젝트 이동 
	 * @return 결과
	 */

	@Override
	public String gitStore(Map<String, Object> map, HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		String result= "success";
		String projectName="";
		String source ="";
		
		projectName = fileUtils.makegit(map, request);
		
		
		log.debug("projectName : "+projectName );
		
		map.put("projectName", projectName);
		map.put("comment", map.get("comment"));
		projectDAO.insertProject(map);
		
			return result;
	}

	/**
	 * git repositoy의 파일 목록을 리턴
	 * @return 결과
	 */
	@Override
	public List<String> getfileList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		log.debug(" map.get(IDX).toString() :" + map.get("IDX").toString()  );
		return gitUtils.getProjectList(map.get("IDX").toString());
		 
	}
	/**
	 * git repository의 파일들의 경로를 통해 해당 코드를 리턴
	 * @return 결과
	 */
	@Override
	public String getSource(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		return gitUtils.getSource(map.get("TITLE").toString(), map.get("IDX").toString());
		 
	}
	
	
	
}
