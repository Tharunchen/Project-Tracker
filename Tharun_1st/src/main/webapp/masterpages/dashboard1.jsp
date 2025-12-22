<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body onload="myFunction()">

<input type="hidden" value="<%=request.getParameter("error")%>" id="errormessage" />
<input type="hidden" value="<%=request.getParameter("success")%>" id="successmessage" />


	<div role="main" id="main-wrapper">
		<main id="main" class="main">


			<jsp:include page="/pages/topnavbar.jsp" />
		</main>
		<div class="container p-4">
		
</body>
</html>