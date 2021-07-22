package com.auc;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;

import com.auc.common.filter.AucFilter;

@MapperScan(basePackages = "com.auc.**.*Impl")
@SpringBootApplication
public class BrAucApplication extends SpringBootServletInitializer{

	public static void main(String[] args) {
		SpringApplication.run(BrAucApplication.class, args);
	}
	
	@Override 
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) 
	{ return builder.sources(BrAucApplication.class); }

	@Bean
	public FilterRegistrationBean setFilterRegistration() {
		FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean(new AucFilter());
		// filterRegistrationBean.setUrlPatterns(Collections.singletonList("/filtered/*")); // list 를 받는 메소드
		filterRegistrationBean.addUrlPatterns("/*"); // string 여러개를 가변인자로 받는 메소드
		
		return filterRegistrationBean;
	}
	
}
