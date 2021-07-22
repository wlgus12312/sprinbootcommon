package com.auc.common.config;

import javax.sql.DataSource;

import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement
public class DataBaseConfig {
	
	@Bean
	public DataSource dataSource() {
		return DataSourceBuilder.create()
			  .driverClassName("com.microsoft.sqlserver.jdbc.SQLServerDriver")
			  .url("jdbc:sqlserver://192.168.1.35;databaseName=brAuction")
			  .username("brAuction")
			  .password("brain21c!")
			  .build();
	}
	
	@Bean
	public PlatformTransactionManager txManager() throws Exception {
		return new DataSourceTransactionManager(dataSource());
	}

}
