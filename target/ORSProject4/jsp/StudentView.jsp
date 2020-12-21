<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.raystech.proj4.controller.StudentCtl"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.raystech.proj4.util.HTMLUtility"%>
<%@page import="com.raystech.proj4.util.DataUtility"%>
<%@page import="com.raystech.proj4.util.ServletUtility"%>

<html>
<head>
<link rel="stylesheet" type="text/css" href="../js/jquery-ui.css"></link>
<script type="text/javascript" src="../js/calendar.js"></script>
<script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
<script type="text/javascript" src="../js/jquery-ui.js"></script>
<script type="text/javascript">
	$(function() {
		$("#datepicker").datepicker({
			dateFormat : 'mm/dd/yy',
			defaultDate : "01/01/1982",
			changeMonth : true,
			changeYear : true,
			yearRange : '-35:-18' 
		});
	});
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style type="text/css">
input[type=text],input[type=password],textarea{
	width: 186px;
	padding: 5px ;
}


input[type=button], input[type=submit], input[type=reset] {
    
    padding: 5px 28px;
    border-radius: 4px;
}
</style>
</head>
<body>

	<form action="<%=ORSView.STUDENT_CTL%>" method="post">
		<div>
			<%@ include file="Header.jsp"%></div>

		<script type="text/javascript"></script>
		<!-- <script type="text/javascript" src="./js/calendar.js"></script> -->


		<jsp:useBean id="bean" class="com.raystech.proj4.bean.StudentBean"
			scope="request"></jsp:useBean>

		<%
			List l = (List) request.getAttribute("collegeList");
		%>


		<%
			if (bean.getId() > 0) {
		%>
		<h1 align="center">Update Student</h1>
		<%
			} else {
		%>
		<h1 align="center">Add Student</h1>
		<%
			}
		%>

		<center>
		<H2>
			<font color="red"> <%=ServletUtility.getErrorMessage(request)%>
			</font>
		</H2>
		<H2>
			<font color="green"> <%=ServletUtility.getSuccessMessage(request)%>
			</font>
		</H2>
		</center>

		<input type="hidden" name="id" value="<%=bean.getId()%>"> 
		<input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
		<input type="hidden" name="modifiedBy" value="<%=bean.getModifiedBy()%>"> 
		<input type="hidden" name="createdDatetime" value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
		<input type="hidden" name="modifiedDatetime" value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">

		
			<table align="center" style="margin-left: 39%">
				<tr>
					<th>College Name<font color="red">*</font></th>
					<td><%=HTMLUtility.getList("collegeId", String.valueOf(bean.getCollegeId()), l, "College")%>
						<font color="red"> <%=ServletUtility.getErrorMessage("collegeId", request)%></font></td>


				</tr>
				<tr>
					<th align="left">First Name<font color="red">*</font></th>
					<td><input type="text" name="firstName"
						placeholder="Enter First Name"
						value="<%=DataUtility.getStringData(bean.getFirstName())%>"><font
						color="red"> <%=ServletUtility.getErrorMessage("firstName", request)%></font></td>
				</tr>
				<tr>
					<th align="left">Last Name<font color="red">*</font></th>
					<td><input type="text" name="lastName"
						placeholder="Enter Last Name"
						value="<%=DataUtility.getStringData(bean.getLastName())%>"><font
						color="red"> <%=ServletUtility.getErrorMessage("lastName", request)%></font></td>
				</tr>
				<tr>
					<th align="left">Email<font color="red">*</font></th>
					<td><input type="text" name="email"
						placeholder="Enter Email-Id"
						value="<%=DataUtility.getStringData(bean.getEmail())%>"
						<%=(bean.getId() > 0) ? "readonly" : ""%>><font
						color="red"> <%=ServletUtility.getErrorMessage("email", request)%></font></td>
				</tr>
				<tr>
					<th align="left">Mobile No<font color="red">*</font></th>
					<td><input type="text" name="mobileNo"
						placeholder="Enter Contact No"
						value="<%=DataUtility.getStringData(bean.getMobileNo())%>"><font
						color="red"> <%=ServletUtility.getErrorMessage("mobileNo", request)%></font></td>
				</tr>
				<tr>
					<th align="left">Date Of Birth<font color="red">*</font></th>
					<td><input type="text" name="dob" 
						id="datepicker" placeholder="Click Here" readonly="readonly"
						value="<%=DataUtility.getDateString(bean.getDob())%>"><font
						color="red"> <%=ServletUtility.getErrorMessage("dob", request)%></font></td>
				</tr>
				<tr></tr><tr></tr><tr></tr><tr></tr>
				<tr>
					<td></td>
					<td><input style="width: 99px;" type="submit" name="operation"
						value="<%=(bean.getId()<=0)?StudentCtl.OP_SAVE:StudentCtl.OP_UPDATE%>"> <input style="width: 97px;"
						type="submit" name="operation" value="<%=StudentCtl.OP_CANCEL%>"></td>
				</tr>
				<tr></tr>
			</table>

		


	</form>
	
	
	<div><%@ include file="Footer.jsp"%></div>
</body>
</html>