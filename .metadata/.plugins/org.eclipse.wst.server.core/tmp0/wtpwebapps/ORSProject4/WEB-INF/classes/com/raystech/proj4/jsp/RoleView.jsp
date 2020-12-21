<%@page import="com.raystech.proj4.controller.RoleCtl"%>
<%@page import="com.raystech.proj4.controller.BaseCtl"%>
<%@page import="com.raystech.proj4.util.DataUtility"%>
<%@page import="com.raystech.proj4.util.ServletUtility"%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../format.css"></link>
</head>
<body>
    <form action="<%=ORSView.ROLE_CTL%>" method="post">
        <%@ include file="Header.jsp"%>

        <jsp:useBean id="bean" class="com.raystech.proj4.bean.RoleBean"
            scope="request"></jsp:useBean>

        <center>
        
        	<%if(bean.getId()>0){ %>
        	<h1>Update Role</h1>
        	<%}else{ %>
            <h1>Add Role</h1><%} %>
            <H2>
                <font color="green"> <%=ServletUtility.getSuccessMessage(request)%>
                </font>
            </H2>
            <H2>
                <font color="red"> <%=ServletUtility.getErrorMessage(request)%>
                </font>
            </H2>

            <input type="hidden" name="id" value="<%=bean.getId()%>">
            <input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
            <input type="hidden" name="modifiedBy" value="<%=bean.getModifiedBy()%>"> 
            <input type="hidden" name="createdDatetime" value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
            <input type="hidden" name="modifiedDatetime" value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">
            

            <table align="center" style="margin-left:40% ">
                <tr>
                    <th align="left">Name<font style="color: red">*</font></th>
                    <td><input type="text" name="name" placeholder="Enter Name"
                        value="<%=DataUtility.getStringData(bean.getName())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("name", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Description<font style="color: red">*</font></th>
                    <td><input type="text" name="description" placeholder="Enter Description"
                        value="<%=DataUtility.getStringData(bean.getDescription())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("description", request)%></font></td>
                </tr>
                <tr></tr><tr></tr><tr></tr><tr></tr>
                <tr>
                	<td></td>
                    <td><input type="submit" name="operation"
                        value="<%=(bean.getId()<=0)?RoleCtl.OP_SAVE:RoleCtl.OP_UPDATE%>" style="width: 99px"> <input type="submit"
                        name="operation" value="<%=RoleCtl.OP_CANCEL%>"  style="width: 97px"></td>
                </tr>
            </table>
    </form>
    </center>
    <%@ include file="Footer.jsp"%>
</body>
</html>
