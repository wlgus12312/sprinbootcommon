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
	
	function sendFrm(sendFrm){
		
		//서버에 호출할 URL
		var sendUrl = "/getDataMap";		
		//form data 서버에 전송
		var results = snedAjaxFrm(sendFrm, sendUrl, "POST");
		
		//리턴데이터 처리	
		//tbody 추가
	    $.each(results, function(i){		
		    var str = '<tr id=row' + i + '>';				    
	    	str += '<td>' + results[i].usrnm + '</td>'
	    	    +  '<td>' + i                + '</td>'
	    	    +  '<td>' + results[i].usrid + '</td>';			    	    
	    	str += '</tr>';			    	
	    	$("#frm_table").append(str);
	    });			
	}
	
	
	
	function sendGrid(grid){
		
		//서버에 호출할 URL
		var sendUrl = "/getDataMap";		
		//grid data 서버에 전송
		var results = sendAjaxGrid(grid, sendUrl, "POST");
		
		//리턴데이터 처리
		
		
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
	<input type="button" onclick="sendFrm('dataFrm');" value="맵전송">
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
	
	<input type="button" onclick="sendFrm('hello_frm');" value="폼데이터생성">
</form>


<form id="frm_gr">
	<table id="frm_table">
      <thead>
        <tr>
          <th>컬럼1</th>
          <th>컬럼2</th>
          <th>컬럼3</th>
        </tr>
      </thead>
      <tbody>
        
      </tbody>
    </table>
    
    <input type="button" onclick="sendGrid('frm_table');" value="그리드데이터생성">
    
</form>






</body>
</html>