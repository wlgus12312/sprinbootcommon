package com.auc.common.interceptor;

import java.util.Iterator;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.core.MethodParameter;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import com.auc.common.config.CriptoConfig;
import com.auc.common.vo.ResolverMap;

@Component
public class AucArgumentResolver implements HandlerMethodArgumentResolver{
	
	private static Logger log = LoggerFactory.getLogger(AucArgumentResolver.class);

	@Autowired
	CriptoConfig criptoConfig;
		
	@Override
	public boolean supportsParameter(MethodParameter parameter) {						
		//false 면 아래 함수를 진행하지 않음
		return true;
	}
	
	@Override
	public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer,
			NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
		
		//파라미터 받아서 가공
		log.info("resolver@@@@@@@@");
		
		ResolverMap rMap = new ResolverMap();
				
		Iterator<String> iter = webRequest.getParameterNames();
		
		while(iter.hasNext()) {
			String paraName = iter.next();
			String paraValue = criptoConfig.decrypt(webRequest.getParameter(paraName));
			rMap.put(paraName, paraValue);
			
		}
	
		return rMap;
	}

	
	
	
	

}
