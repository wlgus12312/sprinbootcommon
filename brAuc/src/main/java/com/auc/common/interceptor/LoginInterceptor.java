package com.auc.common.interceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.auc.common.vo.LoginUser;

@Component
public class LoginInterceptor implements HandlerInterceptor{
	
	private static Logger log = LoggerFactory.getLogger(LoginInterceptor.class);
		
	@Resource
	LoginUser loginUser;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
		
		//controller 에서 set 한 값
		log.info("loginInterceptor : " + loginUser.getEno());
		
		return true;		
	}
		
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
	                       ModelAndView modelAndView) throws Exception {
	        // TODO Auto-generated method stub
    }
 
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        // TODO Auto-generated method stub
    }

	public void setUserSession(LoginUser loginUser) {
		this.loginUser = loginUser;
		
	}



}
