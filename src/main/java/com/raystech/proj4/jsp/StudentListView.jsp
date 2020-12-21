<%@page import="com.raystech.proj4.model.StudentModel"%>
<%@page import="com.raystech.proj4.util.HTMLUtility"%>
<%@page import="javax.swing.text.html.HTML"%>
<%@page import="com.raystech.proj4.controller.StudentListCtl"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.raystech.proj4.util.ServletUtility"%>
<%@page import="com.raystech.proj4.bean.StudentBean"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
	var en=document.forms[0].elements[4].name;
	if(en!=undefined & en.indexOf("chk_")!=-1)
	{	
		document.forms[0].elements[4].checked=document.frm.chk_all.unchecked;
	}	
}
</script>
<link rel="stylesheet" type="text/css" href="../format.css"></link>
</head>
<body>

	<%@include file="Header.jsp"%>
	<jsp:useBean id="bean" class="com.raystech.proj4.bean.StudentBean" scope="request"></jsp:useBean>
	<jsp:useBean id="collBean" class="com.raystech.proj4.bean.CollegeBean" scope="request"></jsp:useBean>
	<center>
		<h1>Student List</h1>

			<h3><font color="red"><%=ServletUtility.getErrorMessage(request)%></font>
			
			<font color="green"><%= ServletUtility.getSuccessMessage(request) %></font>
			</h3>	
			
			
		<form action="<%=ORSView.STUDENT_LIST_CTL%>" name="frm" method="post">
		<%List list = ServletUtility.getList(request); %>
		<%if(list.size()!=0) { %>
		<%List collList = (List)request.getAttribute("collList"); %>
			<table width="100%">
				<tr>
					<td align="center">
						<label>College : </label><%=HTMLUtility.getList("collegeid", String.valueOf(bean.getCollegeId()), collList, "College") %>&emsp;
						<label> FirstName :</label> <input type="text" name="firstName" placeholder="Enter First Name"
						value="<%=ServletUtility.getParameter("firstName", request)%>">&emsp;
						<label>LastName :</label> <input type="text" name="lastName" placeholder="Enter Last Name"
						value="<%=ServletUtility.getParameter("lastName", request)%>">&emsp;
						
						<input style="padding: 5px; width: 100px;" type="submit" name="operation"
						value="<%=StudentListCtl.OP_SEARCH%>">
				</tr>
			</table>
			<br>
			
			<table border="2" width="100%">
				
				<tr>
					<th style="width: 100px"><input type="checkbox" name="chk_all" onclick="checkedAll()"/>Select All</th>
					<th>S.No.</th>
					<th>College Name</th>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Date Of Birth</th>
					<th>Mobile No</th>
					<th>Email ID</th>
					<th>Edit</th>
				</tr>
				
				<%	StudentModel model = new StudentModel();
					int pageNo = ServletUtility.getPageNo(request);
					int pageSize = ServletUtility.getPageSize(request);
					int index = ((pageNo - 1) * pageSize) + 1;

					StudentBean sbean = null;
					Iterator<StudentBean> it = list.iterator();

					while (it.hasNext()) {

						sbean = it.next();
				%>
				
				<tr align="center">
				 	<td><input type="checkbox" id="sid" name="chk_1" onchange="check()" 
                    value="<%=sbean.getId()%>"></td>
					<td><%=index++%></td>
					<td><%=sbean.getCollegeName()%></td>
					<td><%=sbean.getFirstName()%></td>
					<td><%=sbean.getLastName()%></td>
					<td><%=sbean.getDob()%></td>
					<td><%=sbean.getMobileNo()%></td>
					<td><%=sbean.getEmail()%></td>
					<td><a href="StudentCtl?id=<%=sbean.getId()%>">Edit</a></td>
				</tr>
				<%
					}
				%>
			</table>
			<br>
			
			<table width="100%">
				<tr>
					<td><input style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=StudentListCtl.OP_PREVIOUS%>" <%if(pageNo==1){ %>disabled="disabled"<%} %>></td>
					<td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=StudentListCtl.OP_NEW%>"></td>
					<td align="center"><input style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=StudentListCtl.OP_RESET%>"></td>
					<td><input style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=StudentListCtl.OP_DELETE%>" <%if(list.size()==0){ %>disabled="disabled"<%} %>></td>
					
					<td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
						value="<%=StudentListCtl.OP_NEXT%>" <%if(pageSize > list.size() || model.nextPK()-1 == sbean.getId()){ %>disabled="disabled"<%} %>></td>
				</tr>
			</table>
			<input type="hidden" name="pageNo" value="<%=pageNo%>"><input
				type="hidden" name="pageSize" value="<%=pageSize%>">

		<%}else{ %>
		<input style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=StudentListCtl.OP_BACK%>"> 
		<%} %>
		</form>
		
		<%@ include file="Footer.jsp"%>
	</center>

</body>
</html>