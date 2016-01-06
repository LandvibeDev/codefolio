package com.codefolio.dao;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Repository;


/**
 *	DB에 저장된 정보들  
 *
 */
@Repository("boardDAO")
public class BoardDAO extends AbstractDAO{

	/**
	 * 게시글 리스트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardList(Map<String, Object> map) throws Exception{
		String queryId = map.get("T_IDX").equals(-1)? "board.selectBoardList":"selectTopicBoardList"; 
	   
		return (Map<String, Object>)selectPagingList(queryId, map);
	}
	
	/**
	 * 카테고리 리스트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTopicList(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("board.selectTopicList", map);
	}
	
	/**
	 * 파일 정보 입력 
	 * @param map
	 * @throws Exception
	 */
	public void insertFile(Map<String, Object> map) throws Exception{
	    insert("board.insertFile", map); 	//파일입력 
	}
	
	/**
	 * 게시글 삽입 
	 * @param map
	 * @throws Exception
	 */
	public void insertBoard(Map<String, Object> map) throws Exception{
		insert("board.insertBoard", map);
		update("board.updateFile",map);
	}
	
	/**
	 * 카테고리 삽입 
	 * @param map
	 * @throws Exception
	 */
	public void insertTopic(Map<String, Object> map) throws Exception{
		insert("board.insertTopic", map);
	}

	/**
	 * 게시글 조회수 증가 
	 * @param map
	 * @throws Exception
	 */
	public void updateHitCnt(Map<String, Object> map) throws Exception{
		update("board.updateHitCnt", map);
	}
	
	/**
	 * 게시글 상세정보 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) selectOne("board.selectBoardDetail", map);
	}

	/**
	 * 카테고리 정보 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectTopicInfo(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) selectOne("board.selectTopicInfo", map);
	}
	
	
	/**
	 * 파일리스트 in 게시글 상세 페이
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFileList(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("board.selectFileList", map);  
	}
	
	/**
	 * 게시글 수정  
	 * @param map
	 * @throws Exception
	 */
	public void updateBoard(Map<String, Object> map) throws Exception{
		update("board.updateBoard", map);
	}

	/**
	 * 게시글 삭제 
	 * @param map
	 * @throws Exception
	 */
	public void deleteBoard(Map<String, Object> map) throws Exception{
		delete("board.deleteBoard", map);
		delete("board.deleteFile", map);
	}
	
	/**
	 * TimelineJS 정보 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTimelineList(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("board.selectTimelineList", map);
	}
	
	/**
	 * 파일정보 in 파일 다운로드 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception{
	    return (Map<String, Object>)selectOne("board.selectFileInfo", map);
	}
}
