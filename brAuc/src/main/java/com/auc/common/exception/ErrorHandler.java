package com.auc.common.exception;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class ErrorHandler {
	
	private static Logger log = LoggerFactory.getLogger(ErrorHandler .class);

	/**
     * 지원하지 않은 HTTP method 호출 할 경우 발생
     */
    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    protected ResponseEntity<ErrorResponse> handleHttpRequestMethodNotSupportedException(HttpServletRequest reqeust, HttpRequestMethodNotSupportedException e) {
        log.error("handleHttpRequestMethodNotSupportedException", e);
        final ErrorResponse response = ErrorResponse.of(ErrorCode.METHOD_NOT_ALLOWED);
        return new ResponseEntity<>(response, HttpStatus.METHOD_NOT_ALLOWED);
    }
    
    @ExceptionHandler(RuntimeException.class)
 	public ResponseEntity<ErrorResponse> handler(HttpServletRequest reqeust, RuntimeException e) {
    	log.info("RunTimeException ##############");
    	final ErrorResponse response = ErrorResponse.of(ErrorCode.INVALID_INPUT_VALUE);
 		return new ResponseEntity<>(response, HttpStatus.NOT_FOUND);
 	}
    
    @ExceptionHandler(SQLException.class)
 	public ResponseEntity<ErrorResponse> handler2(HttpServletRequest reqeust, SQLException e) {
    	log.info("SqlException ##############");
    	final ErrorResponse response = ErrorResponse.of(ErrorCode.HANDLE_ACCESS_DENIED);
 		return new ResponseEntity<>(response, HttpStatus.NOT_FOUND);
 	}

}
