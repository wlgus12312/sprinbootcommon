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
<script src="/js/jquery/json2.js"></script>
<script src="/js/jquery/jquery-ui.js"></script>
<script src="/js/rollups/aes.js"></script>
<script src="/js/rollups/sha256.js"></script>

<link rel="stylesheet" href="/css/jquery/jquery-ui.css">

<script type="text/javascript">

var keyutf = CryptoJS.enc.Utf8.parse("<%=key%>");
var ivutf = CryptoJS.enc.Utf8.parse("<%=iv%>");



</script>


<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>