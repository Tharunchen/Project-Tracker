<%@ page contentType="text/html; charset=UTF-8" %> 
<% String contentPage = request.getParameter("page"); 

if (contentPage == null || contentPage.trim().isEmpty()) 
{ 
	contentPage = "/masterpages/project_register.jsp"; // default page 
	} %> 
	
	<jsp:include page="/pages/template.jsp"> 
	<jsp:param name="contentPage" value="<%= contentPage %>" /> 
	</jsp:include>	