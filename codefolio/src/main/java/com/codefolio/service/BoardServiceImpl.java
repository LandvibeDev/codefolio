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
import com.codefolio.util.FileUtils;


/*
 *  게시판 관련 비지니스 계층 
 * 
 */
@Service("boardService")
public class BoardServiceImpl implements BoardService{
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Resource(name="boardDAO")
	private BoardDAO boardDAO;
	
	//게시글 리스트 
	@Override
	public Map<String, Object> selectBoardList(Map<String, Object> map) throws Exception {
	    return boardDAO.selectBoardList(map);
	}

	//게시글 입력 
	@Override
	public void insertBoard(Map<String, Object> map,HttpServletRequest request) throws Exception {
		
		boardDAO.insertBoard(map);
		
//		//첨부파일 정보 저장 
//		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(map, request);
//		for(int i=0, size=list.size(); i<size; i++){
//			boardDAO.insertFile(list.get(i)); //db에저장
//			}
		
	}
	
	@Override
	public void insertFile(Map<String, Object> map,HttpServletRequest request) throws Exception {
		
		//첨부파일 정보 저장 
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(map, request);
		for(int i=0, size=list.size(); i<size; i++){
			boardDAO.insertFile(list.get(i)); //db에저장
			}
		
	}
	//게시글 상세 
	@Override
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception {
		boardDAO.updateHitCnt(map); // 조회수 증가 
		Map<String,Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> tempMap = boardDAO.selectBoardDetail(map); // 게시글 정보 
		resultMap.put("map", tempMap);
		
		List<Map<String,Object>> list = boardDAO.selectFileList(map);	// 파일 정보
		resultMap.put("list",list);
		
		return resultMap;
	}
	
	//파일 리스트
	@Override
    public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
        return boardDAO.selectFileInfo(map);
    }

	// 게시글 수정 
	@Override
	public void updateBoard(Map<String, Object> map) throws Exception{
		boardDAO.updateBoard(map);
	}

	//게시글 삭제 
	@Override
	public void deleteBoard(Map<String, Object> map) throws Exception {
		boardDAO.deleteBoard(map);
	}
	
	//TimelineJS 정보 
	@Override
	public List<Map<String, Object>> selectTimelineList(Map<String, Object> map) throws Exception {
	    return boardDAO.selectTimelineList(map);
	}
	
	
	
}
