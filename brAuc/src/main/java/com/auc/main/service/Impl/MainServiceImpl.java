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
	public List<Map<String, Object>> getUserList() throws Exception {

		List<Map<String, Object>> list = null;
		
		list = mainMapper.getUserList();
		
		System.out.println(list.toString());
		
		return list;
	}

}
