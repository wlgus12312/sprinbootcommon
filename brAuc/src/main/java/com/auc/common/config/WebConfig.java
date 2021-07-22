package com.auc.common.config;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.auc.common.interceptor.AucArgumentResolver;
import com.auc.common.interceptor.LoginInterceptor;
import com.auc.common.vo.LoginUser;

@Configuration
public class WebConfig implements WebMvcConfigurer {
	
	private static Logger log = LoggerFactory.getLogger(WebConfig.class);
	
	@Autowired
	LoginInterceptor loginInterceptor;
	
	@Bean
    @Scope(value = "session", proxyMode = ScopedProxyMode.TARGET_CLASS)
    public LoginUser loginUser() {
        return new LoginUser();
    }
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
//		registry.addInterceptor(loginInterceptor)
//		        //.excludePathPatterns("/**/*.js")
//		        .addPathPatterns("/*");		
		loginInterceptor.setUserSession(loginUser());
		registry.addInterceptor(loginInterceptor).addPathPatterns("/*");
		
	}
	

	@Bean
	public AucArgumentResolver aucArgumentResolver() {
		return new AucArgumentResolver();
	}
	
	@Bean
	public MappingJackson2JsonView jsonView() {
		return new MappingJackson2JsonView();
	}
	
	
	@Override
	public void addArgumentResolvers(List<HandlerMethodArgumentResolver> argumentResolvers) {
		argumentResolvers.add(aucArgumentResolver());	    
	}	
	
	

}
