<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>

<style>
/* Card container */
.card-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
    gap: 20px;
    padding: 20px;
}

/* Individual card */
.card {
    background: #ffffff;
    border-radius: 12px;
    padding: 30px 20px;
    text-align: center;
    font-weight: 600;
    color: #5b21b6;
    cursor: pointer;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    transition: all 0.3s ease;
}

/* Hover effect */
.card:hover {
    background: #7c3aed;
    color: white;
    transform: translateY(-5px);
    box-shadow: 0 8px 18px rgba(0,0,0,0.2);
}
</style>
</head>

<body>

<div role="main" id="main-wrapper">
    <main id="main" class="main">

       
        <jsp:include page="/pages/topnavbar.jsp" />
</main>
        <!-- Cards Section -->
        <div class="card-container">

            <div class="card"
                 onclick="location.href='${pageContext.request.contextPath}/pages/Main.jsp?page=/masterpages/roledetails.jsp'">
                Assigning Role
            </div>

            <div class="card"
                 onclick="location.href='${pageContext.request.contextPath}/pages/Main.jsp?page=/masterpages/opldetails.jsp'">
                Open Points List
            </div>

            <div class="card"
                 onclick="location.href='${pageContext.request.contextPath}/pages/Main.jsp?page=/masterpages/changerequestdetails.jsp'">
                Change Request
            </div>
            

            <div class="card"
                 onclick="location.href='${pageContext.request.contextPath}/pages/Main.jsp?page=/masterpages/asseteissuebyuser.jsp'">
                Asset Issue
            </div>

            <div class="card"
                 onclick="location.href='${pageContext.request.contextPath}/pages/Main.jsp?page=/masterpages/feedbackbyuser.jsp'">
                Feedback
            </div>

            <div class="card"
                 onclick="location.href='${pageContext.request.contextPath}/pages/Main.jsp?page=/masterpages/lpc.jsp'">
                LPC
            </div>

        </div>

    
</div>

</body>
</html>
