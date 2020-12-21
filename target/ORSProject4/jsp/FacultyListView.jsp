<%@page import="com.raystech.proj4.util.DataUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.raystech.proj4.bean.CollegeBean"%>
<%@page import="com.raystech.proj4.model.SubjectModel"%>
<%@page import="com.raystech.proj4.bean.SubjectBean"%>
<%@page import="com.raystech.proj4.bean.CourseBean"%>
<%@page import="com.raystech.proj4.bean.FacultyBean"%>
<%@page import="com.raystech.proj4.model.CourseModel"%>
<%@page import="com.raystech.proj4.model.CollegeModel"%>
<%@page import="com.raystech.proj4.model.FacultyModel"%>
<%@page import="com.raystech.proj4.controller.FacultyListCtl"%>
<%@page import="com.raystech.proj4.util.ServletUtility"%>
<%@page import="com.raystech.proj4.util.HTMLUtility"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript">
function checkedAll()
{
	
	var totalElement=document.forms[0].elements.length;
	for(var i=0;i<totalElement;i++){
		var en=document.forms[0].elements[i].name;
		
		if(en!=undefined & en.indexOf("chk_")!=-1)
		{	
			document.forms[0].elements[i].checked=document.frm.chk_all.checked;
		 
		}		
	}
}
function check(){
	var en=document.forms[0].elements[5].name;
	if(en!=undefined & en.indexOf("chk_")!=-1)
	{	
		document.forms[0].elements[5].checked=document.frm.chk_all.unchecked;
	}	
}
</script>
<link rel="stylesheet" type="text/css" href="../format.css"></link>
</head>
<body>
	<%@include file="Header.jsp"%>
	<jsp:useBean id="bean" class="com.raystech.proj4.bean.FacultyBean" scope="request"></jsp:useBean>


	<center>
		<h1>Faculty List</h1>
		
		<h3><font color="red"><%=ServletUtility.getErrorMessage(request)%></font></h3>
  <h3><font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></h3>
		
		
		<form action="<%=ORSView.FACULTY_LIST_CTL%>" name="frm" method="post">
			<%List list = ServletUtility.getList(request); %>
			<%if(list.size()!=0){ %>
			<%
			List facultyList = (List) request.getAttribute("facultyList");
			List courseList = (List) request.getAttribute("courseList");
			%>

			<table width="100%">
				<tr>
					<td align="center"><label>Course:</label> <%=HTMLUtility.getList("courseId", String.valueOf(bean.getCourseId()), courseList, "Course")%>
						&emsp; 
						<label>Full Name:</label> <%=HTMLUtility.getList("facultyId", String.valueOf(bean.getId()), facultyList, "Name")%>
						&emsp; 
						<label>First Name :</label> <input type="text" name="firstName" placeholder="Enter First Name" value="<%=ServletUtility.getParameter("firstName", request)%>">
						&emsp;
						<label>Last Name :</label> <input type="text" name="lastName" placeholder="Enter Last Name" value="<%=ServletUtility.getParameter("lastName", request)%>">
						&emsp;
						<label> <input style="padding: 5px; width: 100px;" type="submit" name="operation"
						value="<%=FacultyListCtl.OP_SEARCH%>"> </td>
				</tr>
			</table>
			<br>
			<table border="2" width="100%">
				<tr align="center">
					<th style="width: 100px"><input type="checkbox" name="chk_all" onclick="checkedAll()"/>Select All</th>
					<th>S.No.</th>
					<th>FirstName</th>
					<th>LastName</th>
					<th>EmailId</th>
					<th>Qualification</th>
					<th>CollegeName</th>
					<th>CourseName</th>
					<th>SubjectName</th>
					<th>DOB</th>
					<th>MOB</th>
					<th>Edit</th>
				</tr>


				<%	FacultyModel model = new FacultyModel();
					int pageNo = ServletUtility.getPageNo(request);
					int pageSize = ServletUtility.getPageSize(request);
					int index = ((pageNo - 1) * pageSize) + 1;
					FacultyBean bean1 = null;
					Iterator<FacultyBean> it = list.iterator();
					while (it.hasNext()) {
			 			 bean1 = it.next();
						
						    
				%>
				 <tr align="center">

					<td><input type="checkbox" id="sid" name="chk_1" onchange="check()" 
                    value="<%=bean1.getId()%>"></td>
					<td><%=index++%></td>
					<td><%=bean1.getFirstName()%></td>
					<td><%=bean1.getLastName()%></td>
					<td><%=bean1.getEmailId() %></td>
					<td><%=bean1.getQualification() %></td>
					<td><%=bean1.getCollegeName() %></td>
					<td><%=bean1.getCourseName()%></td>
					<td><%=bean1.getSubjectName() %></td>
					<td><%=DataUtility.getDateString(bean1.getDob())%></td>
					<td><%=bean1.getMobNo() %></td>
					<td><a href="FacultyCtl?id=<%=bean1.getId()%>">Edit</a></td>
				</tr> 
				<%
					}
				%>
			</table>
			
			<br>
			<table width="100%">
				

				<tr>
					<td><input style="padding: 5px; width: 100px;" type="submit" name="operation"
						value="<%=FacultyListCtl.OP_PREVIOUS%>"
						<%=(pageNo <= 1) ? "disabled" : ""%>></td>
					<td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
						value="<%=FacultyListCtl.OP_NEW%>"
						<%=(userBean.getRoleId() == 1) ? "" : "disabled"%>></td>
					<%
						if (userBean.getRoleId() == 1) {
					%>
					
					<td align="center"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
					value="<%=FacultyListCtl.OP_RESET%>"></td>

					<td><input style="padding: 5px; width: 100px;" type="submit" name="operation"
						value="<%=FacultyListCtl.OP_DELETE%>"
						<%=(list.size() == 0) ? "disabled" : ""%>></td>

					<%
						}

				
						List marksheetList = (List) request.getAttribute("facultyList");

						if (pageSize > list.size() || model.nextPK()-1 == bean1.getId()) {
					%>
					<td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
					disabled="disabled" value="<%=FacultyListCtl.OP_NEXT%>"></td>
					<%
						} else {
					%>
					<td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
						value="<%=FacultyListCtl.OP_NEXT%>"></td>
					<%
						}
					%>
				</tr>
			</table>
			<input type="hidden" name="pageNo" value="<%=pageNo%>"><input
				type="hidden" name="pageSize" value="<%=pageSize%>">
				<%} else { %>
				<input style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=FacultyListCtl.OP_BACK%>">
				<%} %>
		</form>
		
	</center>
	<%@include file="Footer.jsp"%>

</body>
</html> 