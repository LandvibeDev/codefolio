package com.codefolio.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface BoardService {

	Map<String, Object> selectBoardList(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectTopicList(Map<String, Object> map) throws Exception;

	void insertBoard(Map<String, Object> map) throws Exception;
	
	void insertTopic(Map<String, Object> map) throws Exception;
	
	void insertFile(Map<String, Object> map,HttpServletRequest request) throws Exception;
	
	public Map<String, Object> selectBoardDetail(Map<String, Object> map, boolean isBoardDetail) throws Exception;

	void updateBoard(Map<String, Object> map) throws Exception;

	void deleteBoard(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> selectTimelineList(Map<String, Object> map) throws Exception;
	
	Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception;
}
