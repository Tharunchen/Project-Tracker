<%@ page contentType="text/html; charset=UTF-8" %>

<%
String username = (String) session.getAttribute("User");
String role = (String) session.getAttribute("Role");

if (username == null) username = "Guest";
if (role == null) role = "User";
%>

<style>
    .sidebar {
        width: 220px;
        height: 100vh;
        background: #ede9fe;
        display: flex;
        justify-content: center;
        align-items: center;
        box-shadow: 2px 0 6px rgba(0,0,0,0.08);
    }

    .profile-box {
        text-align: center;
        padding: 20px;
    }

    .profile-box img {
        width: 90px;
        height: 90px;
        border-radius: 50%;
        object-fit: cover;
        border: 3px solid #7c3aed;
        margin-bottom: 12px;
    }

    .profile-name {
        font-size: 16px;
        font-weight: 600;
        color: #5b21b6;
        margin-bottom: 4px;
    }

    .profile-role {
        font-size: 13px;
        color: #6d28d9;
        font-weight: 500;
    }
</style>

<div class="sidebar">
    <div class="profile-box">
        <img src="${pageContext.request.contextPath}/images/user.png" alt="User Image">
        <div class="profile-name"><%= username %></div>
        <div class="profile-role"><%= role %></div>
    </div>
</div>


