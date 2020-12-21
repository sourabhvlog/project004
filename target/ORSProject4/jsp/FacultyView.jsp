<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.raystech.proj4.controller.FacultyCtl"%>
<%@page import="com.raystech.proj4.controller.UserCtl"%>
<%@page import="com.raystech.proj4.util.DataUtility"%>
<%@page import="com.raystech.proj4.util.ServletUtility"%>
<%@page import="com.raystech.proj4.util.HTMLUtility"%>
<%@page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
			defaultDate : "01/01/1948",
			changeMonth : true,
			changeYear : true,
			yearRange : '-60:-25' 
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
	<form action="<%=ORSView.FACULTY_CTL%>" method="post">
		<div><%@ include file="Header.jsp"%></div>
		<script type="text/javascript" src="../js/calendar.js"></script>
		
			<jsp:useBean id="bean" class="com.raystech.proj4.bean.FacultyBean"
				scope="request"></jsp:useBean>

			<%
				List collegeList = (List) request.getAttribute("collegeList");
				List courseList = (List) request.getAttribute("courseList");
				List subjectList = (List) request.getAttribute("subjectList");
			%>

			
				<%
					if (bean.getId() > 0) {
				%>
				<h1 align="center" style="margin-left:3% ">Update Faculty</h1>
				<%
					} else {
				%>
				<h1 align="center" style="margin-left:3% ">Add Faculty</h1>
				<%
					}
				%>

				<H2 align="center">
					<font color="red"> <%=ServletUtility.getErrorMessage(request)%>
					</font>
				
					<font color="green"> <%=ServletUtility.getSuccessMessage(request)%>
					</font>
				</H2>
		
		
			<input type="hidden" name="id" value="<%=bean.getId()%>"> <input
				type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
			<input type="hidden" name="modifiedBy"
				value="<%=bean.getModifiedBy()%>"> <input type="hidden"
				name="createdDatetime"
				value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
			<input type="hidden" name="modifiedDatetime"
				value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">

			<table class="t1">
				<colgroup>
					<col style="width: 22%">
					<col style="width: 22%">
					<col style="width: 56%">
				</colgroup>
				<table align="center" style="margin-left:39% ">
					<tr>
						<th align="left">First Name<font color="red">*</font></th>
						<td><input type="text" name="firstName" placeholder="Enter First Name"
							value="<%=DataUtility.getStringData(bean.getFirstName())%>"><font
							color="red"> <%=ServletUtility.getErrorMessage("firstName", request)%></font></td>
					</tr>
					<tr>
						<th align="left">Last Name<font color="red">*</font></th>
						<td><input type="text" name="lastName" size="26" placeholder="Enter Last Name"
							value="<%=DataUtility.getStringData(bean.getLastName())%>"><font
							color="red"> <%=ServletUtility.getErrorMessage("lastName", request)%></font></td>
					</tr>
					<tr>
						<th align="left">Gender<font color="red">*</font></th>
						<td>
							<%
								HashMap map = new HashMap();
								map.put("Male", "Male");
								map.put("Female", "Female");

								String htmlList = HTMLUtility.getList("gender", bean.getGender(), map, "Gender");
								
							%> <%=htmlList%>
						<font
								color="red"> <%=ServletUtility.getErrorMessage("gender", request)%></font></td>
					</tr>

					<tr>
						<th align="left">College Name<font color="red">*</font></th>
						<td><%=HTMLUtility.getList("collegeId", String.valueOf(bean.getCollegeId()), collegeList, "College")%>
						<font
							color="red"> <%=ServletUtility.getErrorMessage("collegeId", request)%></font>
					</tr>
					
					<tr>
						<th align="left">Course Name<font color="red">*</font></th>
						<td><%=HTMLUtility.getList("courseId", String.valueOf(bean.getCourseId()), courseList, "Course")%>
						<font
							color="red"> <%=ServletUtility.getErrorMessage("courseId", request)%></font></td>
					</tr>
					<tr>
						<th align="left">Subject Name<font color="red">*</font></th>
						<td><%=HTMLUtility.getList("subjectId", String.valueOf(bean.getSubjectId()), subjectList, "Subject")%>
						<font
							color="red"> <%=ServletUtility.getErrorMessage("subjectId", request)%></font></td>
					</tr>
					
					<tr>
						<th align="left">Qualification<font color="red">*</font></th>
						<td><input type="text" name="qualification" size="26" placeholder="Enter Qualification"
							value="<%=DataUtility.getStringData(bean.getQualification())%>"><font
							color="red"> <%=ServletUtility.getErrorMessage("qualification", request)%></font></td>
					</tr>
					<tr>
						<th align="left">EmailId<font color="red">*</font></th>
						<td><input type="text" name="emailId" size="26" placeholder="Enter Email-Id"
							value="<%=DataUtility.getStringData(bean.getEmailId())%>"
							<%=(bean.getId() > 0) ? "readonly" : ""%>><font
							color="red"> <%=ServletUtility.getErrorMessage("emailId", request)%></font></td>
					</tr>

					<tr>
						<th align="left">Mobile No<font color="red">*</font></th>
						<td><input type="text" name="mobNo" size="26" placeholder="Enter Contact No"
							value="<%=DataUtility.getStringData(bean.getMobNo())%>"><font
							color="red"> <%=ServletUtility.getErrorMessage("mobNo", request)%></font></td>
					</tr>

					<tr>
						<th align="left">Date Of Birth<font color="red">*</font></th>
						<td><input type="text" name="dob" 
							id="datepicker" size="26" placeholder="Click Here" readonly="readonly"
							value="<%=DataUtility.getDateString(bean.getDob())%>"></a><font
							color="red"> <%=ServletUtility.getErrorMessage("dob", request)%></font></td>
					</tr>
					<tr></tr><tr></tr><tr></tr><tr></tr>
					<tr>
						<td></td>
						<td><input style="width: 99px;" type="submit" name="operation"
							value="<%=(bean.getId() > 0) ? FacultyCtl.OP_UPDATE : UserCtl.OP_SAVE%>">
							<input style="width: 97px;" type="submit" name="operation"
							value="<%=FacultyCtl.OP_CANCEL%>"></td>
					</tr>
				</table>
				
				
			</table>
		
	</form>
	
	<div><%@ include file="Footer.jsp"%></div>


</body>
</html>