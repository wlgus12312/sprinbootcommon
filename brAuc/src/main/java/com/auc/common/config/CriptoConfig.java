package com.auc.common.config;

import java.security.Key;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class CriptoConfig {
	
	private static Logger log = LoggerFactory.getLogger(CriptoConfig.class);
	
	
	@Value("${cript.key}")
    private String key;
	@Value("${cript.iv}")
    private String iv;
    
    private String text;
    private String enText;
    
    
    public void setText(String text) {
    	this.text = text;
    }
    
    public String getEnText() {
    	
    	try {
			enText = encript(text);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	return this.enText;
    }
	

	public Key getAESKey() throws Exception {		
	    
		//String iv;
	    Key keySpec;
	    
	    //iv = key.substring(0, 16);
	    byte[] keyBytes = new byte[16];
	    byte[] b = key.getBytes("UTF-8");

	    int len = b.length;
	    if (len > keyBytes.length) {
	       len = keyBytes.length;   
	    }

	    System.arraycopy(b, 0, keyBytes, 0, len);
	    keySpec = new SecretKeySpec(keyBytes, "AES");

	    return keySpec;
	}
	
	// 암호화
	public String encript(String str) throws Exception {
	    
		Key keySpec = getAESKey();
		
	    Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
	    c.init(Cipher.ENCRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes("UTF-8")));
	    byte[] encrypted = c.doFinal(str.getBytes("UTF-8"));
	    String enStr = new String(Base64.encodeBase64(encrypted));

	    return enStr;
	    
	}
    

	public String decrypt(String text)  throws Exception{
		
		Key keySpec = getAESKey();
	    Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
	    c.init(Cipher.DECRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes("UTF-8")));
	    byte[] byteStr = Base64.decodeBase64(text.getBytes("UTF-8"));
	    String decStr = new String(c.doFinal(byteStr), "UTF-8");

	    return decStr;
	}
	
	
    
}
