package com.auc.main.service;

import java.util.List;
import java.util.Map;

public interface MainService {

	List<Map<String, Object>> getUserList(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> selectMenuList(Map<String, Object> map) throws Exception;
	
	

}
