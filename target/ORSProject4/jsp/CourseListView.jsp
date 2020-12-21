<%@page import="com.raystech.proj4.model.CourseModel"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.raystech.proj4.controller.CourseListCtl"%>
<%@page import="com.raystech.proj4.util.ServletUtility"%>
<%@page import="com.raystech.proj4.util.HTMLUtility"%>
<%@page import="com.raystech.proj4.util.DataUtility"%>
<%@page import="com.raystech.proj4.bean.CourseBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>

<html>
<head>
<link rel="stylesheet" type="text/css" href="../format.css"></link>
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
	var en=document.forms[0].elements[3].name;
	if(en!=undefined & en.indexOf("chk_")!=-1)
	{	
		document.forms[0].elements[3].checked=document.frm.chk_all.unchecked;
	}	
}
</script>
</head>
<body >

	<%@include file="Header.jsp"%>
	<div style="min-height: 450px">
	<jsp:useBean id="bean" class="com.raystech.proj4.bean.CourseBean"
		scope="request"></jsp:useBean>
		
		<%
		List l = (List) request.getAttribute("courseList");
		
			%>
	
	<center>
		<h1>Course List</h1>
  <h3><font color="red"><%=ServletUtility.getErrorMessage(request)%></font></h3>
<h3><font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></h3>

		
		<form action="<%=ORSView.COURSE_LIST_CTL%>" name="frm" method="POST">

			<% List list = ServletUtility.getList(request); %>
			<%if(list.size()!=0){ %>
			<table width="100%">
				<tr>
					<td align="center"><%-- <label>Name :</label> <%=HTMLUtility.getList("courseId", String.valueOf(bean.getName()),l)%>
						&emsp; --%>
						<label>Course Name :</label> <input
						type="text" name="name" placeholder="Enter Course Name"
						value="<%=ServletUtility.getParameter("name", request)%>">
						&emsp;
						<label>Duration : </label><% 
							HashMap map = new HashMap();
							map.put("2 years", "2 years");
							map.put("3 years", "3 years");
							map.put("4 years", "4 years");

							String htmlList = HTMLUtility.getList("duration", bean.getDuration(), map, "Duration");
							DataUtility.getStringData("duration");
						%> <%=htmlList%>&emsp;
						<input  style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=CourseListCtl.OP_SEARCH %>">
					</td>
				</tr>
			</table>
			<br>
			<table border="2" width="100%">
				<tr>
					<th style="width: 100px"><input type="checkbox" name="chk_all" onclick="checkedAll()"/>Select All</th>
					<th>S.No</th>
					<th>Name</th>
					<th>Description</th>
					<th>Duration</th>
					<th>Edit</th>
				</tr>
				<%	CourseModel model = new CourseModel();
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize) + 1;

                   
                    Iterator<CourseBean> it = list.iterator();

                    while (it.hasNext()) {

                         bean = it.next();
                %>
				<tr align="center">
					<td><input type="checkbox" id="sid" name="chk_1" onchange="check()" 
                    value="<%=bean.getId()%>"></td>
					<td><%=index++%></td>
					<td><%=bean.getName()%></td>
					<td><%=bean.getDescription()%></td>
					<td><%=bean.getDuration()%></td>
				 <%
						if (userBean.getRoleId() == 1) {
					%>
                    <td><a href="CourseCtl?id=<%=bean.getId()%>">Edit</a></td>
                    <%
						} else {
					%>
					<td><a>----</a></td>
					<%
						}
					%>
                </tr>
                <%
                    }
                %>
			</table>
			<br>
			<table width="100%">
				<tr>
					<td><input style="padding: 5px; width: 100px;" type="submit" name="operation"
						value="<%=CourseListCtl.OP_PREVIOUS%>"
						<%=(pageNo <= 1) ? "disabled" : ""%>></td>
						
                    <td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
						value="<%=CourseListCtl.OP_NEW%>"
						<%=(userBean.getRoleId() == 1) ? "" : "disabled"%>></td>
						
                        <%
						if (userBean.getRoleId() == 1) {
					%>
					
					<td align="center"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
					value="<%=CourseListCtl.OP_RESET%>"></td>					
		
					<td><input style="padding: 5px; width: 100px;" type="submit" name="operation"
						value="<%=CourseListCtl.OP_DELETE%>"
						<%=(list.size() == 0) ? "disabled" : ""%>></td>
						<%
						}

				
						List courseList = (List) request.getAttribute("courseList");

						if (pageSize > list.size() || model.nextPK()-1 == bean.getId()) {
					%>
                        
                	<td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
						disabled="disabled" value="<%=CourseListCtl.OP_NEXT%>"></td>
					<%
						} else {
					%>
					<td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
						value="<%=CourseListCtl.OP_NEXT%>"></td>
					<%
						}
					%></tr>
			</table>
			<input type="hidden" name="pageNo" value="<%=pageNo%>"> 
			<input
				type="hidden" name="pageSize" value="<%=pageSize%>">
				<%}else{ %>
				<input style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=CourseListCtl.OP_BACK%>"> 
				<%} %>
		</form>
		
	</center>
	</div>
<%@include file="Footer.jsp"%>
</body>
</html>