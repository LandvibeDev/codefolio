package com.codefolio.util;
 
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mysql.jdbc.log.Log;
 
@Component("fileUtils")
public class FileUtils {
    private static final String filePath = "/Users/kimgh6554/Documents/Dev/File/"; //파일이 저장될 위치 mac 
    //private static final String filePath = "C:\\dev\\file\\"; //파일이 저장될 위치 window
    Logger log = Logger.getLogger(this.getClass());
	
    
    //파일의 이름을 재정의하여 저장 
    public List<Map<String,Object>> parseInsertFileInfo(Map<String,Object> map, HttpServletRequest request) throws Exception{
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
        Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
         
        MultipartFile multipartFile = null;
        String originalFileName = null;
        String originalFileExtension = null;
        String storedFileName = null;
         
        List<Map<String,Object>> list = new ArrayList<Map<String,Object>>(); //다중파일 전송을 위한 리스트  
        Map<String, Object> listMap = null; 
        
        
        
        
		File file = new File(filePath);
		if (file.exists() == false) {
			file.mkdirs(); // 지정된위치에 폴더가 없으면 폴더생성
		}

        while(iterator.hasNext()){
            multipartFile = multipartHttpServletRequest.getFile(iterator.next());
            if(multipartFile.isEmpty() == false){
                originalFileName = multipartFile.getOriginalFilename();
                originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                storedFileName = CommonUtils.getRandomString() + originalFileExtension; //랜덤파일이름+확장
                 
                file = new File(filePath + storedFileName);
                multipartFile.transferTo(file); //파일저장
                 
                listMap = new HashMap<String,Object>();
                listMap.put("BOARD_IDX", -1);
                listMap.put("ORIGINAL_FILE_NAME", originalFileName);
                listMap.put("STORED_FILE_NAME", storedFileName);
                listMap.put("FILE_SIZE", multipartFile.getSize());
                list.add(listMap);
            }
        }
        return list;
    }
}