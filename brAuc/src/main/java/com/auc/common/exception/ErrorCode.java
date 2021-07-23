package com.auc.common.exception;

public enum ErrorCode {
	   // Common
    INVALID_INPUT_VALUE(400, "C001", " AAA2222A"),
    METHOD_NOT_ALLOWED(405, "C002", " BBBB"),
    HANDLE_ACCESS_DENIED(403, "C006", "CCCC"),

    // Member
    LOGIN_INPUT_INVALID(400, "M002", "DDDD"),

    ;
	private int status;
	private String code;
	private String message;
	private String detail;

	ErrorCode(int status, String code, String message) {
		this.status = status;
		this.message = message;
		this.code = code;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}
}
