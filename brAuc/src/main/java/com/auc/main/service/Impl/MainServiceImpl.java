package com.auc.main.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.auc.main.service.MainService;

@Service("MainService")
public class MainServiceImpl implements MainService{
	
	@Autowired
	MainMapper mainMapper;	
	

	@Override
	public List<Map<String, Object>> getUserList(Map<String, Object> map) throws Exception {

		List<Map<String, Object>> list = null;
		
		list = mainMapper.getUserList(map);
		
		return list;
	}


	@Override
	public List<Map<String, Object>> selectMenuList(Map<String, Object> map) throws Exception {
		
		List<Map<String, Object>> list = null;
		
		list = mainMapper.selectMenuList(map);
		
		return list;
	}


}
