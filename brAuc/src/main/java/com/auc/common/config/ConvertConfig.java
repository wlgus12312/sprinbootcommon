package com.auc.common.config;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import java.util.Set;

import org.springframework.stereotype.Component;

import com.auc.common.vo.LoginUser;
import com.auc.common.vo.ResolverMap;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Component
public class ConvertConfig {
	
	ObjectMapper mapper = new ObjectMapper();
	
	@Resource
	LoginUser loginUser;
		
	public Map<String, Object> conMap(ResolverMap rMap) throws Exception{
				
		String data = rMap.get("data").toString();
				
		Map<String, Object> getMap = mapper.readValue(data, HashMap.class);
		Map<String, Object> map = new HashMap<String, Object>();
		
		//모든 맵 안에 session 값을 넣어준다.
		//Object 값이 List면 list안에 ss_eno를 넣어준다.				
		List<Map<String, Object>> inList = null;

	    for (Map.Entry<String, Object> entry : getMap.entrySet()) {
	    	
	        if(entry.getValue() instanceof List) {
	        	inList = (List<Map<String, Object>>) entry.getValue();   
	        	for (int i = 0; i < inList.size(); i++) {
	        		//세션값 넣음
            		inList.get(i).put("ss_eno", loginUser.getEno());
				}
	        }	        
	    }	    
	    
		//세션값 넣음	    
	    getMap.put("ss_eno", loginUser.getEno());
	    	    
	    //키 소문자로 변환
	    Set<String> set = getMap.keySet();
	    Iterator<String> e = set.iterator();

	    while(e.hasNext()){
	      String key = e.next();
	      Object value = (Object) getMap.get(key);

	      map.put(key.toLowerCase(), value);
	    }
		
		return map;
	}
	
	
	
	
	
//	public List<Map<String, Object>> conListMap(ResolverMap rMap) throws Exception{
//		
//		String data = rMap.get("data").toString();
//
//		List<Map<String, Object>> list = mapper.readValue( data, new TypeReference<List<Map<String, Object>>>() {} );
//
//		return list;
//
//	}

}
