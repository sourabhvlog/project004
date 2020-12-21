<%@page import="com.raystech.proj4.controller.MarksheetCtl"%>
<%@page import="java.util.List"%>
<%@page import="com.raystech.proj4.util.HTMLUtility"%>
<%@page import="com.raystech.proj4.util.DataUtility"%>
<%@page import="com.raystech.proj4.util.ServletUtility"%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../format.css"></link>
</head>

<body>

    <form action="<%=ORSView.MARKSHEET_CTL%>" method="post">
        <%@ include file="Header.jsp"%>
        <jsp:useBean id="bean" class="com.raystech.proj4.bean.MarksheetBean" scope="request"></jsp:useBean>

        <%
            List l = (List) request.getAttribute("studentList");
        %>
        
        <center>
        	<%if(bean.getId()>0){ %>
        	<h1>Update Marksheet</h1>
        	<%} else { %>
            <h1>Add Marksheet</h1>
            <%} %>
            <H2>
                <font color="red"> <%=ServletUtility.getErrorMessage(request)%>
                </font>
            </H2>
            <H2>
                <font color="green"> <%=ServletUtility.getSuccessMessage(request)%>
                </font>
            </H2>


            <input type="hidden" name="id" value="<%=bean.getId()%>">
            <input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
            <input type="hidden" name="modifiedBy" value="<%=bean.getModifiedBy()%>"> 
            <input type="hidden" name="createdDatetime" value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
            <input type="hidden" name="modifiedDatetime" value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">
            

            <table align="center" style="margin-left:40% ">
                <tr>
                    <th align="left">Rollno<font style="color: red">*</font></th>
                    <td><input type="text" name="rollNo" placeholder="Enter Roll Number"
                        value="<%=DataUtility.getStringData(bean.getRollNo())%>"
                        <%=(bean.getId() > 0) ? "readonly" : ""%>> <font
                        color="red"> <%=ServletUtility.getErrorMessage("rollNo", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Name<font style="color: red">*</font></th>
                    <td><%=HTMLUtility.getList("studentId",
                    String.valueOf(bean.getStudentId()), l, "Name")%><font
                        color="red"> <%=ServletUtility.getErrorMessage("stname", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Physics<font style="color: red">*</font></th>
                    <td><input type="text" name="physics" placeholder="Enter Physics Marks" 
                        value="<%=DataUtility.getStringData(bean.getPhysics())%>"  ><font
                        color="red"> <%=ServletUtility.getErrorMessage("physics", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Chemistry<font style="color: red">*</font></th>
                    <td><input type="text" name="chemistry" placeholder="Enter Chemistry Marks"
                        value="<%=DataUtility.getStringData(bean.getChemistry())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("chemistry", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Maths<font style="color: red">*</font></th>
                    <td><input type="text" name="maths" placeholder="Enter Maths Marks"
                         value="<%=DataUtility.getStringData(bean.getMaths())%>"	><font
                        color="red"> <%=ServletUtility.getErrorMessage("maths", request)%></font></td>

                </tr>
                
                <tr></tr><tr></tr><tr></tr><tr></tr>
                
                <tr>
                	<td></td>
                    <td><input type="submit" name="operation"
                        value="<%=(bean.getId()<=0)?MarksheetCtl.OP_SAVE:MarksheetCtl.OP_UPDATE%>" style="width: 99px;"> 
                        <input type="submit" name="operation"
                        value="<%=MarksheetCtl.OP_CANCEL%>" style="width: 97px;"></td>
                </tr>
            </table>
        </form>
        
        <%@ include file="Footer.jsp"%>
    </body>
</html>