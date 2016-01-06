package com.codefolio.dao;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.stereotype.Repository;

@Repository("projectDAO")
public class ProjectDAO extends AbstractDAO{

	/**
	 * 프로젝트 insert
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertProject(Map<String, Object> map) throws Exception{
		insert("project.insertProject", map);
	}
	
	/**
	 * 프로젝트 리스트 select
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectProjectList(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("project.selectProjectList", map);  
	}
	
}
