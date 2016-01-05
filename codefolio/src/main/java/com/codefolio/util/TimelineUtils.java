package com.codefolio.util;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import org.springframework.stereotype.Component;



/**
 * TimelineJs에 필요한 데이터 가공 
 * 
 */
@Component("timelineUtils")
public class TimelineUtils {
	
	
	/**	 
	 * 	DEFAULTURL : CONTENTS에 이미지 url이 없을 때 디폴트값
	 */
	private static final String DEFAULTURL = "http://dev.naver.com/dbimage.php?id=3955";
	
	
	
	/** 
	 * DB의 data 가공
	 *  
	 * @param queryId List from DB
	 */
	public List<Map<String,Object>> makeTiemline(List<Map<String,Object>> list) throws Exception{
		
		String imageURL = null;
		String contents = null;
		
		List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
		Map<String,Object> iter =null; 
		
		for(int i = 0 ; i < list.size(); i++){
			
			iter = list.get(i);
			
			imageURL = extractUrl((String)iter.get("CONTENTS"));
			contents = extractTotalUnderline((String)iter.get("CONTENTS"));
			
			iter.put("IMAGE_URL", imageURL);
			iter.put("TIMELINE_CONTENTS", contents);
			
			resultList.add(iter);
		}
		
		return resultList;
	}

	/**
	 *  contents의 사진 url을 추출 
	 * 
	 * @param contents
	 */
	public String extractUrl(String contents) {

		String url = null;

		if (contents.indexOf("img") == -1) {

			url = DEFAULTURL;

		} else {
			String findImg = contents.substring(contents.indexOf("img"));

			if (findImg.indexOf("src") == -1) {
				url = DEFAULTURL;
			} else {
				String findSrc = findImg.substring(findImg.indexOf("src"));

				String findSecondDQmarks = findSrc.substring(findSrc.indexOf("\"") + 1);

				url = findSrc.substring(findSrc.indexOf("\"") + 1,
						findSrc.indexOf("\"") + 1 + findSecondDQmarks.indexOf("\""));
			}

		}

		return url;
	}
	
	/**
	 *  contents의 모든 u태그 내용을 추출 
	 * 
	 * @param contents
	 */
	public String extractTotalUnderline(String contents) {
		
		String underline = "";
		String underlineTemp = null;
		String iterator = contents;
		while(iterator.indexOf("<u>") != -1)
		{
			underlineTemp = extractUnderline(iterator);
			underline += underlineTemp+"<br/>";
			iterator = iterator.substring(iterator.indexOf(underlineTemp) + underlineTemp.length());
		}
		return underline;
	}
	
	/**
	 *  contents의 맨처음 u태그 내용을 추출 
	 * 
	 * @param contents
	 */
	public String extractUnderline(String contents) {

		String underline = null;
		if (contents.indexOf("<u>") == -1) {
			underline = "";
		} else {
			String findUtag = contents.substring(contents.indexOf("<u>")+3);
			underline = findUtag.substring(0,findUtag.indexOf("</u>"));
		}
		
		return underline;
	}
		
		
}
