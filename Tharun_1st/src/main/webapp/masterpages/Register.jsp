<%@ page import="Utilities.SampleUtilities" %>
<%@ page import="Model.SampleModel" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>

<style>
    body{
        font-family: Arial, sans-serif;
        background: #f5f3ff;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    .register-box{
        background: white;
        padding: 30px;
        width: 350px;
        border-radius: 10px;
        box-shadow: 0 0 15px rgba(0,0,0,0.1);
    }
    h2{
        text-align: center;
        color: #6d28d9;
    }
    input{
        width: 80%;
        padding: 10px;
        margin:  10px auto;
        border: 1px solid #ccc;
        border-radius: 5px;
        display: block;
    }
    button{
        width: 50%;
	    padding: 12px;
	    margin-top: 18px;
	    background: #6c2bd9;
	    color: #fff;
	    border: none;
	    border-radius: 6px;
	    font-size: 16px;
	    cursor: pointer;
	    display: block;
        margin: 0 auto;
    }
    .signin-link{
        text-align: center;
        margin-top: 15px;
    }
    .signin-link a{
        color: #6d28d9;
        text-decoration: none;
        font-weight: bold;
    }
</style>

</head>
<body onload="myFunction()">

<input type="hidden" value="<%=request.getParameter("error")%>" id="errormessage" />
<input type="hidden" value="<%=request.getParameter("success")%>" id="successmessage" />

<%
session.setAttribute("pagename", "Register"); 
try {
    SampleModel SampleModels = new SampleModel();
    SampleUtilities SampleUtilitiess = new SampleUtilities();
    
    if(request.getParameter("type")!=null  && request.getParameter("type").equalsIgnoreCase("saveData")) {

        SampleModels.setName(request.getParameter("name")); 
        SampleModels.setAddress(request.getParameter("address"));
        SampleModels.setUsername(request.getParameter("username"));
        SampleModels.setPassword(request.getParameter("password"));

        String message = SampleUtilitiess.insertdetails(SampleModels); 
        response.sendRedirect( request.getContextPath()  + "/masterpages/Login.jsp?" + message);
    }
%>


<div class="register-box">
    <h2>Sign Up</h2>

   <form id="editForm" class="row g-3" method="post"
      action="<%=request.getContextPath() %>/masterpages/Register.jsp?type=saveData">
      
        <input type="text" name="name" placeholder="Full Name" required>
        <input type="email" name="address" placeholder="Email Address" required>
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
       

        <button type="submit">Register</button>
    </form>

    <div class="signin-link">
        Already registered?
        <a href="Login.jsp">Sign In</a>
    </div>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
}
%>

</body>
</html>
