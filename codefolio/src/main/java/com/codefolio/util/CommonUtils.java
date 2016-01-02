package com.codefolio.util;

import java.util.UUID;

public class CommonUtils{
	
	
	public static String getRandomString(){
		return UUID.randomUUID().toString().replaceAll("-", ""); //32글자의 랜덤한 문자열(숫자포함) 반환 
	}
	
}