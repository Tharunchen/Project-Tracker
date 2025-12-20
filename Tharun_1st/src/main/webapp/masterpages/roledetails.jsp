<%@page import="Utilities.Message"%>
<%@page import="Model.RoleAsingModel"%>
<%@page import="Utilities.RoleAssignUtilities"%>
<%@page import="Model.SampleModel"%>
<%@page import="Utilities.SampleUtilities"%>
<%@page import="Model.RolesDetails"%>
<%@page import="java.util.List"%>
<%@ page import="Utilities.RedirectUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Bootstrap 4 -->
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Bootstrap Select -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.18/dist/css/bootstrap-select.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.18/dist/js/bootstrap-select.min.js"></script>
<link rel="stylesheet"
      href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">

<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

<!-- DataTables Buttons -->
<link rel="stylesheet"
      href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.dataTables.min.css">

<script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.print.min.js"></script>

<!-- Required for export -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
<script>
$(document).ready(function () {
    $('#datatable-buttons').DataTable({
        dom: 'Bfrtip',
        pageLength: 5,
        lengthMenu: [5, 10, 25, 50, 100],
        buttons: [
            'copy',
            'csv',
            'excel',
            'pdf',
            'print'
        ]
    });
});
</script>
<style>
.dt-buttons {
    display: flex;
    flex-wrap: wrap;
    }
.dt-buttons .dt-button {
    white-space: nowrap;
    width: auto;
    min-width: auto;
    writing-mode: horizontal-tb;
    padding: 6px 12px;
    line-height: 1.5;
}
</style>
<script>
$(function () {
    $('.selectpicker').selectpicker();
});
</script>
<style>
button {
	width: 10%;
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
</style>

<script type="text/javascript">
	function editrow(slno) {
		window.location.href = "Main.jsp?page=/masterpages/roledetails.jsp?slno=" + slno
				+ "&type=displayData";
	}
</script>
<script type="text/javascript">
	function deleterow(slno) {
		window.location.href = "Main.jsp?page=/masterpages/roledetails.jsp?slno=" + slno
				+ "&type=deleteData";
	}
</script>
</head>
<body>
	<%
		int slno=0;
		SampleModel SampleModels = new SampleModel();
		SampleUtilities SampleUtilitiess = new SampleUtilities();
		RoleAssignUtilities RoleAssignUtilitiess = new RoleAssignUtilities();
		RoleAsingModel RoleAsingModels = new RoleAsingModel();
		
		if (request.getParameter("type") != null && request.getParameter("type").equalsIgnoreCase("saveData")) {
		
		RoleAsingModels.setUsername(request.getParameter("username"));
		RoleAsingModels.setRoleid(request.getParameter("role"));
		
		String message = RoleAssignUtilitiess.insertroledetails(RoleAsingModels);
		 request.setAttribute("msg", message);
		  
		 RequestDispatcher rd =
				    request.getRequestDispatcher(
				        "/pages/Main.jsp?contentPage=masterpages/roledetails.jsp"
				    );
				rd.forward(request, response);
				return;

		/* response.sendRedirect(request.getContextPath() + "/pages/Main.jsp?page=/masterpages/roledetails.jsp" + message); */
		
}


if ("displayData".equalsIgnoreCase(request.getParameter("type"))) {

	RoleAsingModel RoleAsingModelss = new RoleAsingModel(); 
	String slnoParam = request.getParameter("slno");

    if (slnoParam != null && !slnoParam.isEmpty()) {
        slno = Integer.parseInt(slnoParam);
        RoleAsingModelss = RoleAssignUtilitiess.getIndividualroleDetails(slno);
    }
}

if(request.getParameter("type")!=null && request.getParameter("type").equalsIgnoreCase("deleteData")){
	 String message;

	    if (request.getParameter("slno") != null) {
	        slno = Integer.parseInt(request.getParameter("slno"));
	        message = new RoleAssignUtilities().deleteentry(slno);
	    } else {
	        message = Message.SOMETHING_WENT_WRONG;
	    }

	    RedirectUtil.redirect( request, response, message, "/masterpages/roledetails.jsp"
	    );
	    return;
	
}

%>
<%
String msg = (String) session.getAttribute("msg");
if (msg != null) {
%>
<div class="alert alert-success text-center">
    <%= msg %>
</div>
<%
    session.removeAttribute("msg"); // show once only
}
%>
	<div role="main" id="main-wrapper">
		<main id="main" class="main">


			<jsp:include page="/pages/topnavbar.jsp" />
		</main>
		<div class="container p-4">
		
	<form method="post" class="row align-items-center"
      action="<%=request.getContextPath()%>/pages/Main.jsp?contentPage=masterpages/roledetails.jsp&type=saveData">
    <input type="hidden" name="slno" value="<%=slno%>">
    
    <div class="col-md-4 col-12 d-flex align-items-center gap-2"> 
    <label class="mb-0 fw-semibold">UserName:</label>
    <select name="username" class="form-control field-input" required>
        <option value="">Select-Username</option>
        <%
        for (RolesDetails u : SampleUtilitiess.getdropdownusername()) {
        	String selected = (RoleAsingModels.getUsername() != null &&
                    u.getUsername().equals(RoleAsingModels.getUsername()))
                    ? "selected" : "";

        %>
        <option value="<%=u.getUsername()%>" <%=selected%>>
            <%=u.getUsername()%>
        </option>
        <% } %>
    </select>
    </div>

    <div class="col-md-4 col-12 d-flex align-items-center gap-2"> 
    <label class="mb-0 fw-semibold">Role:</label>
    <select name="role" class="form-control field-input" required>
        <option value="">Select-Role</option>
        <%
        for (RolesDetails r : SampleUtilitiess.getroledropdown()) {
        	String selected = (RoleAsingModels.getRoleid() != null &&
                    String.valueOf(r.getSlno()).equals(RoleAsingModels.getRoleid()))
                    ? "selected" : "";


        %>
        <option value="<%=r.getSlno()%>" <%=selected%>>
            <%=r.getRolename()%>
        </option>
        <% } %>
    </select>
    </div>
   
<div class="col-12 mt-3 text-center">
    <button type="submit" class="btn btn-primary px-4">
        <%= (slno == 0 ? "Submit" : "Update") %>
    </button>
</div>

   
</form>


		</div>
		

		<%if(slno == 0){ %>
		<div class="row">
			<div class="col-lg-12">
				<div class="card">
					<div class="card-body table-responsive">
						<table class="table table-borderless dataTable no-footer"
							id="datatable-buttons" role="grid"
							aria-describedby="datatable-buttons_info">
							<thead>
								<tr>
									<th>Sl No</th>
									<th>UserName</th>
									<th>Role</th>
									<th>Delete</th>
									<!-- <th>Edit</th> -->

								</tr>
							</thead>
							<tbody>
								<% int count = 0;
						for(RoleAsingModel display : RoleAssignUtilitiess.getAllRoleDetails()){
												count++;
											%>
								<tr>
									<td><%=count%></td>
									<td><%=display.getUsername()%></td>
									<td><%=display.getRolename() %></td>


									<%-- <td><button onclick="editrow('<%=display.getSlno()%>')"
											class="btn edit" title="Edit">
											<i class="fa fa-pencil"></i>
										</button></td> --%>
										
										<td><button onclick="deleterow('<%=display.getSlno()%>')"
											class="btn delete" title="Delete">
											<i class="fa fa-trash"></i>
										</button></td>

								</tr>
								<% } %>
							</tbody>

						</table>
					</div>
				</div>
			</div>
			<%} %>

		</div>
		</div>
</body>
</html>