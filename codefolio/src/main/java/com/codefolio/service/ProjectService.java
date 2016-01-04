package com.codefolio.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface ProjectService {

	
	List<Map<String, Object>> selectProjectList(Map<String, Object> map) throws Exception;
	String gitStore(Map<String, Object> map,HttpServletRequest request) throws Exception;
	List<String> getfileList(Map<String, Object> map) throws Exception;
	String getSource(Map<String, Object> map) throws Exception;
}
