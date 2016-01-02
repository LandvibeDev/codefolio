package com.codefolio.dao;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.stereotype.Repository;

@Repository("boardDAO")
public class BoardDAO extends AbstractDAO{

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardList(Map<String, Object> map) throws Exception{
	    return (Map<String, Object>)selectPagingList("board.selectBoardList", map);
	}

	public void insertFile(Map<String, Object> map) throws Exception{
	    insert("board.insertFile", map); 	//파일입력 
	}
	
	public void insertBoard(Map<String, Object> map) throws Exception{
		insert("board.insertBoard", map);
	}

	public void updateHitCnt(Map<String, Object> map) throws Exception{
		update("board.updateHitCnt", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) selectOne("board.selectBoardDetail", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFileList(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("board.selectFileList", map); //파일 리스트 저장 
	}
	
	public void updateBoard(Map<String, Object> map) throws Exception{
		update("board.updateBoard", map);
	}

	public void deleteBoard(Map<String, Object> map) throws Exception{
		update("board.deleteBoard", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTimelineList(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("board.selectTimelineList", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception{
	    return (Map<String, Object>)selectOne("board.selectFileInfo", map);
	}
}
