<%@page import="com.raystech.proj4.controller.ChangePasswordCtl"%>
<%@page import="com.raystech.proj4.util.DataUtility"%>
<%@page import="com.raystech.proj4.util.ServletUtility"%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../format.css"></link>
</head>

<body>
    <form action="<%=ORSView.CHANGE_PASSWORD_CTL%>" method="post">
        
        <%@ include file="Header.jsp"%>

        <jsp:useBean id="bean" class="com.raystech.proj4.bean.UserBean"
            scope="request"></jsp:useBean>

        <center>
            <h1>Change Password</h1>


            <H3>
                <font color="red"> <%=ServletUtility.getErrorMessage(request)%>
                </font>
                <font color="green"> <%=ServletUtility.getSuccessMessage(request)%>
                </font>
            </H3>

            <input type="hidden" name="id" value="<%=bean.getId()%>">
            <input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
            <input type="hidden" name="modifiedBy" value="<%=bean.getModifiedBy()%>"> 
            <input type="hidden" name="createdDatetime" value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
            <input type="hidden" name="modifiedDatetime" value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">

            <table align="center" style="margin-left:38% ">



                <tr>
                    <th align="left">Old Password<font style="color: red">*</font></th>
                    <td><input type="password" name="oldPassword" placeholder="Enter Your Old Password"
                        value=<%=DataUtility
                    .getString(request.getParameter("oldPassword") == null ? ""
                            : DataUtility.getString(request
                                    .getParameter("oldPassword")))%>><font
                        color="red"> <%=ServletUtility.getErrorMessage("oldPassword", request)%></font></td>
                </tr>

                <tr>
                    <th align="left">New Password<font style="color: red">*</font></th>
                    <td><input type="password" name="newPassword" placeholder="Enter New Password"
                        value=<%=DataUtility
                    .getString(request.getParameter("newPassword") == null ? ""
                            : DataUtility.getString(request
                                    .getParameter("newPassword")))%>><font
                        color="red"> <%=ServletUtility.getErrorMessage("newPassword", request)%></font></td>
                </tr>

                <tr>
                    <th align="left">Confirm Password<font style="color: red">*</font></th>
                    <td><input type="password" name="confirmPassword" placeholder="Re-Enter New Password"
                        value=<%=DataUtility.getString(request
                    .getParameter("confirmPassword") == null ? "" : DataUtility
                    .getString(request.getParameter("confirmPassword")))%>><font
                        color="red"> <%=ServletUtility
                    .getErrorMessage("confirmPassword", request)%></font></td>
                </tr>
				
				<tr></tr><tr></tr><tr></tr><tr></tr>
				
                <tr>
                	<td></td>
                    <td><input type="submit" name="operation"
                        value="<%=ChangePasswordCtl.OP_CHANGE_MY_PROFILE %>" style="padding: 5px; width: 125px;"> <input type="submit"
                        name="operation" value="<%= ChangePasswordCtl.OP_SAVE%>" style="padding: 5px;width: 70px;"></td>
                </tr>

            </table>
            
    </form>
    </center>
    <%@ include file="Footer.jsp"%>
</body>
</html>