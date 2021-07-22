package com.auc.common.config;

import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.stereotype.Component;

@Component
public class CommonFunc {
	
	public JSONArray convertListMapToJson(List<Map<String, Object>> list) throws JSONException {
		
		JSONArray jsonArray = new JSONArray();
		
		for(Map<String, Object> map : list) {
					
			jsonArray.put(convertMaptoJson(map));
			
		}
		
		return jsonArray;
	}
	
	public JSONObject convertMaptoJson(Map<String, Object> map) throws JSONException {
		
		JSONObject jsonObject = new JSONObject();
		
		for(Entry<String, Object> entry : map.entrySet()) {
			String key = entry.getKey();
			Object value = entry.getValue();
			jsonObject.put(key, value);				
		}
		
		return jsonObject;
	}
	

}
