<%@ page contentType="text/html; charset=UTF-8"%>

<style>
.topnavbar {
	width: 100%;
	height: 60px;
	background: #ede9fe;
	padding: 0 20px;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
	display: flex;
	align-items: center;
}

.topnavbar h4 {
	margin: 0;
	margin-right: 30px;
	color: #5b21b6;
}

.topnavbar ul {
	list-style: none;
	padding: 0;
	margin: 0;
	display: flex; /* ⭐ KEY LINE */
	align-items: center;
}

.topnavbar ul li {
	margin: 0 10px; /* horizontal spacing */
}

.topnavbar ul li a {
	display: block;
	padding: 8px 14px;
	color: #6d28d9;
	text-decoration: none;
	font-weight: 600;
	border-radius: 6px;
	transition: background 0.3s, color 0.3s;
}

.topnavbar ul li a:hover {
	background: #a78bfa;
	color: white;
}

.topnavbar ul li a.active {
	background: #7c3aed;
	color: white;
}
</style>
<%
String role = (String) session.getAttribute("Role");
%>
<div class="topnavbar">



	<ul>
		<%
		if (role.contains("Admin") || role.contains("Developer")) {
		%>
		<li><a
			href="${pageContext.request.contextPath}/pages/Main.jsp?page=/masterpages/masterpage.jsp">
				MasterPages </a></li>
		<%
		}
		%>

		<li><a
			href="${pageContext.request.contextPath}/pages/Main.jsp?page=/masterpages/project_register.jsp">
				Project Register </a></li>

		<li><a
			href="${pageContext.request.contextPath}/pages/Main.jsp?page=/masterpages/dashboard1.jsp">
				Dashboard </a></li>
	</ul>

</div>
