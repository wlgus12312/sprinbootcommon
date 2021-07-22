<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 암호화 -->
<%@ include file="/WEB-INF/common/head.jsp" %>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	
	function sendDataMap(){						
		//맵        
        var data = new Object();
        
        data.name = $("#data").val();
        data.id   = $("#data1").val();
        data.id2  = $("#data2").val();
        data.id3  = $("#data3").val();
        data.id4  = $("#data4").val();
        
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
	
	
	function sendDataListMap(){		
        
      	//리스트<맵>
        var sendData   = $("#data").val();
        var sendData1  = $("#data1").val();
        var sendData2  = $("#data2").val();	
        var sendData3  = $("#data3").val();	
        var sendData4  = $("#data4").val();	
        
        var testList = new Array();     
                
        var data = new Object();        
        data.name = $("#data").val();
        data.id   = $("#data1").val();
        data.id2  = $("#data2").val();
        data.id3  = $("#data3").val();
        data.id4  = $("#data4").val();
                
        testList.push(data);
        testList.push(data);
        
        var data2 = new Object();
        data2.nAme = testList;
                      
        // String 형태로 변환
        var jsonData = JSON.stringify(data2);         
		var encrypt = CryptoJS.AES.encrypt(jsonData.toString(), keyutf, {iv:ivutf});
						
		$.ajax({
			url:'/getDataListMap',
			type:'POST',
			dataType:'json',
			data:{
				   data : encrypt.toString()
			},
			success:function(data) { 	
				
				console.log(data);
			}
		});	
	}
	
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
<body>

<h1>HELLO</h1>


<form id="dataFrm">
	<input name="list" type="text" id="data"/>
	<input name="list" type="text" id="data1"/>
	<input name="list" type="text" id="data2"/>
	<input name="list" type="text" id="data3"/>
	<input name="list" type="text" id="data4"/>
	<input type="button" onclick="sendDataMap();" value="맵전송">
	<input type="button" onclick="sendDataListMap();" value="리스트전송">
</form>


<form id="hello_frm">	
	<input name="list" type="text" id="data"/>
	<input name="list" type="text" id="data1"/>
	<input name="list" type="text" id="data2"/>
	<input name="list" type="text" id="data3"/>
	<input name="list" type="text" id="data4"/>
	
	<textarea id="data5">12tadgasdg</textarea>
	
	<select name="job" id="data6">
	    <option value="">직업선택</option>
	    <option value="학생">학생</option>
	    <option value="회사원" selected="selected">회사원</option>
	    <option value="기타">기타</option>
	</select>
	
	<input type="checkbox" id="data7" name="xxx" value="yyy" checked>
	
	<input type="button" onclick="createFrm('hello_frm');" value="폼데이터생성">
</form>








</body>
</html>