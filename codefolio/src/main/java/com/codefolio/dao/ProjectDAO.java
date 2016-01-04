package com.codefolio.dao;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.stereotype.Repository;

@Repository("projectDAO")
public class ProjectDAO extends AbstractDAO{

	public void insertProject(Map<String, Object> map) throws Exception{
		insert("project.insertProject", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectProjectList(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("project.selectProjectList", map);  
	}
	
}
