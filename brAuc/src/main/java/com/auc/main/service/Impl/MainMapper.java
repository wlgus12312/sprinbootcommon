package com.auc.main.service.Impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MainMapper {

	List<Map<String, Object>> getUserList(Map<String, Object> map) throws Exception;
	

}
