package com.codefolio.dao;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.stereotype.Repository;

@Repository("boardDAO")
public class BoardDAO extends AbstractDAO{

	//게시글 리스트
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardList(Map<String, Object> map) throws Exception{
	    return (Map<String, Object>)selectPagingList("board.selectBoardList", map);
	}
	
	//파일 정보 저장 
	public void insertFile(Map<String, Object> map) throws Exception{
	    insert("board.insertFile", map); 	//파일입력 
	}
	
	//게시글 삽입
	public void insertBoard(Map<String, Object> map) throws Exception{
		insert("board.insertBoard", map);
		update("board.updateFile",map);
	}

	//게시글 조회수 증가 
	public void updateHitCnt(Map<String, Object> map) throws Exception{
		update("board.updateHitCnt", map);
	}
	
	//게시글 상세 정보 
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) selectOne("board.selectBoardDetail", map);
	}
	
	
	//파일 리스트 in 게시글 상세 페이지 
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFileList(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("board.selectFileList", map);  
	}
	
	//게시글 수정 
	public void updateBoard(Map<String, Object> map) throws Exception{
		update("board.updateBoard", map);
	}

	//게시글 삭제 
	public void deleteBoard(Map<String, Object> map) throws Exception{
		delete("board.deleteBoard", map);
		delete("board.deleteFile", map);
	}
	
	//TimelineJS 정보
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTimelineList(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("board.selectTimelineList", map);
	}
	
	//파일 정보 in 파일 다운로드 
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception{
	    return (Map<String, Object>)selectOne("board.selectFileInfo", map);
	}
}
