<%@ page contentType="text/html; charset=UTF-8" %>

<%
String username = (String) session.getAttribute("User");
String role = (String) session.getAttribute("Role");
if (username == null) username = "Guest";
if (role == null) role = "";
%>

<!DOCTYPE html>
<html>
<head>
<title>Project Tracker</title>

<link href="${pageContext.request.contextPath}/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    margin: 0;
    background: #f5f6fb;
    font-family: Arial, sans-serif;
}

/* HEADER */
.header {
    height: 60px;
    background: white;
    display: flex;
    align-items: center;
    padding: 0 20px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.08);
}

.header img {
    height: 30px;
}

.header h4 {
    flex: 1;
    text-align: center;
    margin: 0;
    color: #1e3a8a;
}

/* LAYOUT */
.main {
    display: flex;
}

/* SIDEBAR */
.sidebar {
    width: 220px;
    background: #ede9fe;
    height: calc(100vh - 60px);
    display: flex;
    justify-content: center;
    align-items: center;
}

.profile-box {
    text-align: center;
}

.profile-box img {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    border: 3px solid #7c3aed;
    margin-bottom: 10px;
}

.profile-name {
    font-weight: 600;
    color: #4c1d95;
}

.profile-role {
    font-size: 13px;
    color: #6d28d9;
}

/* CONTENT */
.content {
    flex: 1;
    padding: 20px;
}
</style>
</head>

<body>


<div class="header">
    <img src="${pageContext.request.contextPath}/images/industry.png">
    <h4>Project Tracker</h4>
    
     <a href="${pageContext.request.contextPath}/masterpages/Login.jsp">
                <img src="${pageContext.request.contextPath}/images/logout.png">
                </a>
</div>


<!-- BODY -->
<div class="main">

    <!-- LEFT PROFILE -->
    <div class="sidebar">
        <div class="profile-box">
            <img src="${pageContext.request.contextPath}/images/user.png">
            <div class="profile-name"><%= username %></div>
            <div class="profile-role"><%= role %></div>
        </div>
    </div>

    <!-- PAGE CONTENT -->
    <div class="content">
        <jsp:include page="${param.contentPage}" />
    </div>

</div>

</body>
</html>
