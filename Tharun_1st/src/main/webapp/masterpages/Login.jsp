<%@page import="Model.RoleAsingModel"%>
<%@page import="Model.RolesDetails"%>
<%@ page import="Utilities.SampleUtilities"%>
<%@ page import="Model.SampleModel"%>
<%@page import="java.util.List"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>Project Compass</title>
<link
	href="${pageContext.request.contextPath}/vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/build/css/all.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/build/css/login.css"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath}/build/js/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%
SampleUtilities sampleUtilitiess = new SampleUtilities();
String action = request.getParameter("action");

if ("getRoles".equals(action)) {

	String username = request.getParameter("username");

	List<RolesDetails> roleList = sampleUtilitiess.getdropdown(username);

	out.println("<option value=''>Select-Role</option>");

	for (RolesDetails role : roleList) {
		out.println("<option value='" + role.getSlno() + "'>" + role.getRolename() + "</option>");
	}
	return;
}
%>
<style>
body {
	font-family: Arial, sans-serif;
	background: #ede9fe;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.login-box {
	background: white;
	padding: 30px;
	width: 320px;
	border-radius: 10px;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
}

h2 {
	text-align: center;
	color: #6d28d9;
}

button {
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

input, select {
	width: 80%;
	padding: 10px;
	margin: 10px auto;
	border: 1px solid #ccc;
	border-radius: 5px;
	display: block;
}

.signin-link {
	text-align: center;
	margin-top: 15px;
}

.signin-link a {
	color: #6d28d9;
	text-decoration: none;
	font-weight: bold;
}
</style>

</head>

<body onload="myFunction()">


	<input type="hidden" value="<%=request.getParameter("error")%>"
		id="errormessage" />
	<input type="hidden" value="<%=request.getParameter("success")%>"
		id="successmessage" />

	<%
	session.setAttribute("pagename", "Login");
	try {
		SampleModel SampleModels = new SampleModel();
		SampleUtilities SampleUtilitiess = new SampleUtilities();
		RoleAsingModel RoleAsingModels = new RoleAsingModel();

		if ("saveData".equals(request.getParameter("type"))) {

			String username = request.getParameter("username");

			String roleId = request.getParameter("role");
			String roleName = request.getParameter("rolename");

			if (username != null && roleId != null && roleName != null) {

				session.setAttribute("User", username);
				session.setAttribute("RoleId", roleId);
				session.setAttribute("Role", roleName);
		
				response.sendRedirect(request.getContextPath() + "/pages/Main.jsp");
				return;
					} else {
				response.sendRedirect(request.getContextPath() + "/masterpages/Login.jsp?error=Select Username and Role");
				return;
					}
				}
	%>
	<div class="login-box">


		<form id="editForm" class="row g-3" method="post"
			action="<%=request.getContextPath()%>/masterpages/Login.jsp?type=saveData">

			<div class="container">
				<div class="row"
					style="margin-top: 8%; display: flex; justify-content: center;">
					<div class="col-md-6 col-lg-4">
						<div class="card card-signin my-5">
							<div class="card-body text-center">
								<img src="${pageContext.request.contextPath}/images/logo.png"
									width="100%"><br> <br>
								<h5 style="font-size: 20px; margin: 0 auto;">
									<b>Sign In</b>
								</h5>

								<select name="username" id="username"
									class="form-control field-input" required>
									<option value="">Select-Username</option>
									<%
									for (RolesDetails u : SampleUtilitiess.getdropdownusername()) {
										String selected = (RoleAsingModels != null && u.getUsername().equals(RoleAsingModels.getUsername()))
										? "selected"
										: "";
									%>
									<option value="<%=u.getUsername()%>" <%=selected%>>
										<%=u.getUsername()%>
									</option>
									<%
									}
									%>
								</select>
								<div class="col-md-4">

									<%--  <%
			List<RolesDetails> rolename = SampleUtilitiess.getdropdown(); %>
								<select class="form-control mb-3" name="role"
									id="role" data-live-search="true" required>
									<option value="">Select-Role</option>
									<%
										for (RolesDetails displayrole : rolename) {
									%>
									<option value="<%=displayrole.getSlno()%>">
										&nbsp;
										<%=displayrole.getRolename()%>
									</option>
									<%
										}
									%>
								</select> --%>
									<select class="form-control mb-3" name="role" id="role"
										required>
										<option value="">Select-Role</option>
									</select>

								</div>
								<input type="hidden" name="rolename" id="rolename">

								<button type="submit">LOGIN</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
		<div class="signin-link">
			Not Having Account? <a href="Register.jsp">Register Here</a>
		</div>
	</div>

	<script>
$(document).ready(function () {

    // When role changes, store role name
    $("#role").change(function () {
        let roleName = $("#role option:selected").text();
        $("#rolename").val(roleName);
    });

});
</script>

	<script>
$(document).ready(function () {

    $("#username").change(function () {

        let username = $(this).val();
        //console.log("Username changed:", username);

        if (username === "") {
            $("#role").html('<option value="">Select-Role</option>');
            return;
        }

        $.ajax({
            url: "<%=request.getContextPath()%>
		/masterpages/Login.jsp",
															type : "POST",
															data : {
																action : "getRoles",
																username : username
															},
															success : function(
																	data) {
																$("#role")
																		.html(
																				data);
															},
															error : function() {
																alert("Failed to load roles");
															}
														});
											});

						});
	</script>




	<%
	} catch (Exception e) {
	e.printStackTrace();
	}
	%>


</body>
</html>
