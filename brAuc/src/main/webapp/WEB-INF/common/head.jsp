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

<script src="/js/jquery/jquery-3.5.1.min.js"></script>
<script src="/js/jquery/jquery-1.12.4.js"></script>
<script src="/js/jquery/json2.js"></script>
<script src="/js/jquery/jquery-ui.js"></script>
<script src="/js/rollups/aes.js"></script>
<script src="/js/rollups/sha256.js"></script>

<link rel="stylesheet" href="/css/jquery/jquery-ui.css">
<style>
#context-menu {
  position:fixed;
  z-index:10000;
  width:150px;
  background:#1b1a1a;
  border-radius:5px;
  transform:scale(0);
  transform-origin:top left;
}
#context-menu.active {
  transform:scale(1);
  transition:transform 300ms ease-in-out;
}
#context-menu .item {
  padding:8px 10px;
  font-size:15px;
  color:#eee;
}
#context-menu .item:hover {
  cursor:pointer;
  background:#555;
  -ms-user-select: none; 
  -moz-user-select: -moz-none;
  -khtml-user-select: none;
  -webkit-user-select: none;
  user-select: none;
}
#context-menu .item i {
  display:inline-block;
  margin-right:5px;
}
#context-menu hr {
  margin:2px 0px;
  border-color:#555;
}

.errPop {	
  position:fixed;
  width:50%;
  height:50%;
  background-color : skyblue;
  color : black;  
}

</style>


<script type="text/javascript">

var keyutf = CryptoJS.enc.Utf8.parse("<%=key%>");
var ivutf = CryptoJS.enc.Utf8.parse("<%=iv%>");

$(document).ready(function() {
	
	//새로고침 및 페이지 이동 방지
	window.addEventListener('beforeunload', (event) => {
		// 표준에 따라 기본 동작 방지
		event.preventDefault();
		// Chrome에서는 returnValue 설정이 필요함
		event.returnValue = '';
	});

	//컨텍스트 메뉴	
	window.addEventListener("contextmenu",function(event){
		event.preventDefault();
		var contextElement = document.getElementById("context-menu");
		contextElement.style.top = event.clientY + document.body.scrollLeft + "px";
		contextElement.style.left = event.clientX  + document.body.scrollTop   + "px";
		var selectionText = "";
		if (document.getSelection) {
			

			console.log('포커스['+document.getSelection().focusNode+']');
			console.log('앵커['+document.getSelection()+']');
            selectionText = document.getSelection();
            
        } 
		

		console.log(event);

		console.log(event.target.tagName);
		contextElement.classList.add("active");
	});
	window.addEventListener("click",function(){
		document.getElementById("context-menu").classList.remove("active");
	});
	
	// F5, ctrl + F5, ctrl + r 새로고침 막기
	$(document).keydown(function (e) {
		if (e.which === 116) {
			if (typeof event == "object") {
				event.keyCode = 0;
            }
            return false;
        } else if (e.which === 82 && e.ctrlKey) {
            return false;
        }
	});
});


function snedAjaxFrm(frmStr, sendUrl, methodType){
	
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
			
			if(tagType == 'text'){									
				data[id] = $(frmIds[i]).val();			
			
			}else if(tagType == 'checkbox'){							
				data[id] =  $(frmIds[i]).is(":checked") ? '1' : '0';					
			}
			
		}else if(tagName == 'TEXTAREA'){
			data[id] = $(frmIds[i]).val();
			
		}else if(tagName == 'SELECT'){
			data[id] = $(frmIds[i]).val();				
		}				
	}
	
	// String 형태로 변환
    var jsonData = JSON.stringify(data);                  
	var encrypt = CryptoJS.AES.encrypt(jsonData.toString(), keyutf, {iv:ivutf});	
		
	var result;
	
	$.ajax({
		url: sendUrl,
		//url: '/err',
		type: methodType,
		dataType:'json',
		async: false,
		data:{
			   data : encrypt.toString()
		},
		success:function(data) { 	
							
			var bytes  = CryptoJS.AES.decrypt(data.data.toString(), keyutf, {iv: ivutf});
			var plaintext = bytes.toString(CryptoJS.enc.Utf8);				
			result = JSON.parse(plaintext);				    
		},
		error:function(request){			
			var errMsg = JSON.parse(request.responseText);	
			
			//에러
			$("#errStatus").text(errMsg.status);
			$("#errMessage").text(errMsg.message);
			$("#errCode").text(errMsg.code);
			
			$("#errDiv").show();
			$("#errDiv").draggable({
				handle: "#errDiv_in"
			});
						
		}
	});	
	
	return result;
	
	
}


function sendAjaxGrid(grid, sendUrl, methodType){
		
	var gridIds = $("#" + grid + " tbody tr");		
	var gridKeys = $("#" + grid + " thead tr th");
				
	var testList = new Array();	
	var data = new Object();
	
	var id = "";
	
	for(var i=0; i<gridIds.length; i++){
		
		id = $(gridIds[i]).attr('id');

		var inData = new Object();

		for(var j=0; j<gridKeys.length; j++){
			inData[$(gridKeys[j]).attr('id')] = $(gridIds[i]).find('td:hidden').eq(j).text();			
		}
		
		data[id] = inData;
	}
			
	testList.push(data);
	
    var data2 = new Object();
    data2.data = testList;
	
    // String 형태로 변환
    var jsonData = JSON.stringify(data2);         
	var encrypt = CryptoJS.AES.encrypt(jsonData.toString(), keyutf, {iv:ivutf});
	
	var result;
	
	$.ajax({
		url: sendUrl,
		type: methodType,
		dataType:'json',
		async: false,
		data:{
			   data : encrypt.toString()
		},
		success:function(data) { 	
							
			var bytes  = CryptoJS.AES.decrypt(data.data.toString(), keyutf, {iv: ivutf});
			var plaintext = bytes.toString(CryptoJS.enc.Utf8);				
			result = JSON.parse(plaintext);					
		},
		error:function(request){			
			var errMsg = JSON.parse(request.responseText);			
			console.log(errMsg);
			alert(errMsg.message);
		}
	});	        
	
	return result;
}



function setGrid(grid, results){
	
	var gridTh = $("#"+ grid + " thead tr").children();		
	var thValue = new Array();
	
	//thead value값 받아오기
	for(var i=0; i<gridTh.length; i++){
		if($(gridTh[i]).is(":visible")){
			thValue[i] = $(gridTh[i]).attr('value');
		}
	}
		
	//tbody 추가
    $.each(results, function(i){		
    	
    	var str = '<tr id=row' + i + '>';
    		    	
    	var resultsKeys   = Object.keys(results[i]);
    	var resultsValues = Object.values(results[i]);
    	    	
    	for(var j=0; j<resultsKeys.length; j++){
    		for(var k=0; k<thValue.length; k++){    			
    			if(resultsKeys[j].includes(thValue[k])){    				
    				str += '<td>' + resultsValues[j] + '</td>';
    				break;
    			}    			
    		}
    	}    	
    	
    	for(var n=0; n<resultsKeys.length; n++){
    		str += '<td style="display:none;">'+ resultsValues[n] + '</td>';
    	}
 
		str += '</tr>';
    	$("#" + grid).append(str);
    	
    });	
	
}

</script>
<div id="context-menu">
    <div id="item-cut" class="item">
        <i class="fa fa-cut"></i> Cut
    </div>
    <div id="item-copy" class="item">
        <i class="fa fa-clone"></i> Copy
    </div>
    <div id="item-paste" class="item">
        <i class="fa fa-paste"></i> Paste
    </div>
    <div id="item-delete" class="item">
        <i class="fa fa-trash-o"></i> Delete
    </div>
</div>