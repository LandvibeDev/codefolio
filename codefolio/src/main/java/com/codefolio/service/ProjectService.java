package com.codefolio.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface ProjectService {

	String gitStore(Map<String, Object> map,HttpServletRequest request) throws Exception;

}
