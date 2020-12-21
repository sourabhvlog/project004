<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.raystech.proj4.controller.SubjectCtl"%>
<%@page import="java.util.List"%>
<%@page import="com.raystech.proj4.util.HTMLUtility"%>
<%@page import="com.raystech.proj4.util.DataUtility"%>
<%@page import="com.raystech.proj4.util.ServletUtility"%>
<html>
<head>
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

<form action="<%=ORSView.SUBJECT_CTL%>" method="post">
       <div> <%@ include file="Header.jsp"%></div>
<script type="text/javascript"></script>
		
		
        <jsp:useBean id="bean" class="com.raystech.proj4.bean.SubjectBean"
            scope="request"></jsp:useBean>

        <%
            List l = (List) request.getAttribute("courseList");
        %>

        
          		<%
					if (bean.getId() > 0) {
				%>
				<h1 align="center">Update Subject</h1>
				<%
					} else {
				%>
				<h1 align="center" style="margin-left:1%">Add Subject</h1>
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
            


            <table align="center" style="margin-left:39% " >
                  <tr>
                    <th align="left">Course Name<font color="red">*</font></th>
                    <td><%=HTMLUtility.getList("courseId",
                    String.valueOf(bean.getCourseId()), l, "Course")%><font color="red"> <%=ServletUtility.getErrorMessage("courseId", request)%></font></td>
                </tr>
                
                <tr>
                    <th align="left">Subject Name<font color="red">*</font></th>
                    <td><input type="text" name="name" placeholder="Enter Subject Name"
                        value="<%=DataUtility.getStringData(bean.getName())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("name", request)%></font></td>
                </tr>
                
                 <tr>
                    <th align="left">Description<font color="red">*</font></th>
                    <td><input type="text" name="description" placeholder="Enter Subject Description"
                        value="<%=DataUtility.getStringData(bean.getDescription())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("description", request)%></font></td>
                </tr>
                
					<tr></tr><tr></tr><tr></tr><tr></tr>
              	
              	<tr>
              			<td></td>
						<td><input type="submit" name="operation"
							value="<%=(bean.getId()<=0)?SubjectCtl.OP_SAVE:SubjectCtl.OP_UPDATE%>" style="width: 99px;"> 
							<input type="submit" name="operation"
							value="<%=SubjectCtl.OP_CANCEL%>" style="width: 97px;"></td>
					</tr>
				</table>

				
		</div>
	</form>

	
	<div><%@ include file="Footer.jsp"%></div>
</body>
</html>