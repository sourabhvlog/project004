<%@page import="com.raystech.proj4.model.SubjectModel"%>
<%@page import="com.raystech.proj4.controller.SubjectListCtl"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.raystech.proj4.controller.SubjectListCtl"%>
<%@page import="com.raystech.proj4.util.ServletUtility"%>
<%@page import="com.raystech.proj4.util.HTMLUtility"%>
<%@page import="com.raystech.proj4.bean.SubjectBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
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
	var en=document.forms[0].elements[3].name;
	if(en!=undefined & en.indexOf("chk_")!=-1)
	{	
		document.forms[0].elements[3].checked=document.frm.chk_all.unchecked;
	}	
}
</script>
<link rel="stylesheet" type="text/css" href="../format.css"></link>
</head>
<body>

 <%@include file="Header.jsp"%>
 <jsp:useBean id="bean" class="com.raystech.proj4.bean.SubjectBean" scope="request"></jsp:useBean>
 <jsp:useBean id="cBean" class="com.raystech.proj4.bean.CourseBean" scope="request"></jsp:useBean>
 
 <%
 	List l=(List)request.getAttribute("subjectList");
 
 %>
    <center>
        <h1>Subject List</h1>
  <h3><font color="red"><%=ServletUtility.getErrorMessage(request)%></font></h3>
  <h3><font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></h3>
		
		
        <form action="<%=ORSView.SUBJECT_LIST_CTL%>" name="frm" method="post">
        <%List list = ServletUtility.getList(request); %>
        <%if(list.size()!=0){ %>
        <%List cList = (List)request.getAttribute("courseList"); %>
            <table width="100%">
                <tr>
                    <td align="center">
                    <label>Course : </label><%=HTMLUtility.getList("courseId", String.valueOf(bean.getCourseId()), cList, "Course") %>&emsp;
						<label>Subject Name :</label> <input
						type="text" name="name" placeholder="Enter Subject Name"
						value="<%=ServletUtility.getParameter("name", request)%>">
						&emsp;
						<input style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=SubjectListCtl.OP_SEARCH %>"></td>
                </tr>
            </table>
            <br>
            <table border="2" width="100%">
                <tr>
                    <th style="width: 100px"><input type="checkbox" name="chk_all" onclick="checkedAll()"/>Select All</th>
                    <th>S.No.</th>
                    <th>Course Name</th>
                    <th>Subject Name</th>
                    <th>Description</th>
                    <th>Edit</th>
                </tr>
                <%	SubjectModel model = new SubjectModel();
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize) + 1;

                    
                    Iterator<SubjectBean> it = list.iterator();

                    while (it.hasNext()) {

                         bean = it.next();
                %>
                <tr align="center">
                	<td><input type="checkbox" id="sid" name="chk_1" onchange="check()" 
                    value="<%=bean.getId()%>"></td>
                    <td><%=index++%></td>
                    <td><%=bean.getCourseName()%></td>
                    <td><%=bean.getName()%></td>
                    <td><%=bean.getDescription()%></td>
                     <%
						if (userBean.getRoleId() == RoleBean.ADMIN) {
					%>
                    <td><a href="SubjectCtl?id=<%=bean.getId()%>">Edit</a></td>
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
						value="<%=SubjectListCtl.OP_PREVIOUS%>"
						<%=(pageNo <= 1) ? "disabled" : ""%>></td>
						
                    <td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
						value="<%=SubjectListCtl.OP_NEW%>"
						<%=(userBean.getRoleId() == 1) ? "" : "disabled"%>></td>
						
                        <%
						if (userBean.getRoleId() == 1) {
					%>
					
					<td align="center"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
					value="<%=SubjectListCtl.OP_RESET%>"></td>

					<td><input style="padding: 5px; width: 100px;" type="submit" name="operation"
						value="<%=SubjectListCtl.OP_DELETE%>"
						<%=(list.size() == 0) ? "disabled" : ""%>></td>
						<%
						}

				
						List subjectList = (List) request.getAttribute("subjectList");

						if (pageSize > list.size() || model.nextPK()-1 == bean.getId()) {
					%>
                        
                	<td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
						 disabled="disabled" value="<%=SubjectListCtl.OP_NEXT%>"></td>
					<%
						} else {
					%>
					<td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
						value="<%=SubjectListCtl.OP_NEXT%>"></td>
					<%
						}
					%></tr>
            </table>
            <input type="hidden" name="pageNo" value="<%=pageNo%>"><input
                type="hidden" name="pageSize" value="<%=pageSize%>">
				<%}else{ %>
				<input style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=SubjectListCtl.OP_BACK%>">
				<%} %>
        </form>
        
    </center>
<%@include file="Footer.jsp"%>
</body>
</html>