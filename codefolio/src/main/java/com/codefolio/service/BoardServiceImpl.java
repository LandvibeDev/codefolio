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

@Service("boardService")
public class BoardServiceImpl implements BoardService{
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Resource(name="boardDAO")
	private BoardDAO boardDAO;
	
	@Override
	public Map<String, Object> selectBoardList(Map<String, Object> map) throws Exception {
	    return boardDAO.selectBoardList(map);
	}

	@Override
	public void insertBoard(Map<String, Object> map,HttpServletRequest request) throws Exception {
		
		boardDAO.insertBoard(map);
		    
		  Iterator<Entry<String,Object>> iterator2 = map.entrySet().iterator();
	        Entry<String,Object> entry = null;
	        log.debug("--------------------printMap--------------------\n");
	        while(iterator2.hasNext()){
	        entry = iterator2.next();
	        log.debug("key : "+entry.getKey()+",\tvalue : "+entry.getValue());
	        }
	        log.debug("");
	        log.debug("------------------------------------------------\n");
	        
	        
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(map, request);
		for(int i=0, size=list.size(); i<size; i++){
			boardDAO.insertFile(list.get(i)); //db에저장 (임시방편 )
			}
		
	}

	@Override
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception {
		boardDAO.updateHitCnt(map);
		Map<String,Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> tempMap = boardDAO.selectBoardDetail(map);
		resultMap.put("map", tempMap);
		
		List<Map<String,Object>> list = boardDAO.selectFileList(map);
		resultMap.put("list",list);
		
		return resultMap;
	}

	@Override
	public void updateBoard(Map<String, Object> map) throws Exception{
		boardDAO.updateBoard(map);
	}

	@Override
	public void deleteBoard(Map<String, Object> map) throws Exception {
		boardDAO.deleteBoard(map);
	}
	
	@Override
	public List<Map<String, Object>> selectTimelineList(Map<String, Object> map) throws Exception {
	    return boardDAO.selectTimelineList(map);
	}
	
	@Override
    public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
        return boardDAO.selectFileInfo(map);
    }
}
