<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><sitemesh:write property='title' /></title> 

	<sitemesh:write property='head' />

</head>

<body>
<%@include file="/WEB-INF/view/layer/header.jsp"%>
<div>
		<sitemesh:write property='body' />
</div>
<decorator:getProperty property="page.local_script"></decorator:getProperty>
</body>

</html>