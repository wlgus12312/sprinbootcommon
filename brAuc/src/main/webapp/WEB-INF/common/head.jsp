<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ page language="java" import="java.util.*" %> 
<%@ page import = "java.util.ResourceBundle" %>

<%
	ResourceBundle resource = ResourceBundle.getBundle("application");
	String key = resource.getString("cript.key");
	String iv  = resource.getString("cript.iv");
%>

<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery/jquery-3.5.1.min.js"></script>
<script src="/js/jquery/jquery-1.12.4.js"></script>
<script src="/js/jquery/jquery-ui.js"></script>
<script src="/js/rollups/aes.js"></script>
<script src="/js/rollups/sha256.js"></script>

<link rel="stylesheet" href="/css/jquery/jquery-ui.css">

<script type="text/javascript">

var keyutf = CryptoJS.enc.Utf8.parse("<%=key%>");
var ivutf = CryptoJS.enc.Utf8.parse("<%=iv%>");


function createFrm(frmStr){
	
	var frmIds = $("#" + frmStr).children('input[type=text], textarea, select, input[type=checkbox]');		
	
	var data = new Object();
	
	var id = "";		
	var tagName = "";
	var tagType = "";
			
	for(var i=0; i<frmIds.length; i++){			
		
		tagName = $(frmIds[i]).prop('tagName');			
		id = $(frmIds[i]).attr('id');
		
		if(tagName == 'INPUT'){				
			tagType = $(frmIds[i]).attr('type');
			
			//인풋텍스트 일때
			if(tagType == 'text'){									
				data[id] = $(frmIds[i]).val();			
			
			//인풋체크박스 일때
			}else if(tagType == 'checkbox'){							
				data[id] =  $(frmIds[i]).is(":checked") ? '1' : '0';					
			}
			
		}else if(tagName == 'TEXTAREA'){
			data[id] = $(frmIds[i]).val();
			
		}else if(tagName == 'SELECT'){
			data[id] = $(frmIds[i]).val();				
		}				
	}
	
	console.log(data);
	
	// String 형태로 변환
    var jsonData = JSON.stringify(data);      
            
	var encrypt = CryptoJS.AES.encrypt(jsonData.toString(), keyutf, {iv:ivutf});
					
	$.ajax({
		url:'/getDataMap',
		type:'POST',
		dataType:'json',
		data:{
			   data : encrypt.toString()
		},
		success:function(data) { 	
							
			var bytes  = CryptoJS.AES.decrypt(data.data.toString(), keyutf, {iv: ivutf});
			var plaintext = bytes.toString(CryptoJS.enc.Utf8);
						    
		    console.log(plaintext);
		}
	});	
	
	
}

</script>


<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>