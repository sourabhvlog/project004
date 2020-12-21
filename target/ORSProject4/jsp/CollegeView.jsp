<%@page import="com.raystech.proj4.controller.CollegeCtl"%>
<%@page import="com.raystech.proj4.util.DataUtility"%>
<%@page import="com.raystech.proj4.util.ServletUtility"%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../format.css"></link>
</head>
<body>
    <form action="CollegeCtl" method="POST">
        <%@ include file="Header.jsp"%>

        <jsp:useBean id="bean" class="com.raystech.proj4.bean.CollegeBean"
            scope="request"></jsp:useBean>

        <center>
        	<%if(bean.getId()>0) {%>
        	<h1>Update College</h1>
        	<% } else { %>
            <h1>Add College</h1>
            <%} %>

            <H2>
                <font color="green"> <%=ServletUtility.getSuccessMessage(request)%>
                </font>
            </H2>
            <H2>
                <font color="red"> <%=ServletUtility.getErrorMessage(request)%>
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

            <table align="center" style="margin-left:40% ">
                <tr>
                    <th align="left">Name<font style="color: red">*</font></th>
                    <td><input type="text" name="name" placeholder="Enter College Name"
                        value="<%=DataUtility.getStringData(bean.getName())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("name", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Address<font style="color: red">*</font></th>
                    <td><input type="text" name="address" placeholder="Enter College Address"
                        value="<%=DataUtility.getStringData(bean.getAddress())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("address", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">State<font style="color: red">*</font></th>
                    <td><input type="text" name="state" placeholder="Enter State"
                        value="<%=DataUtility.getStringData(bean.getState())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("state", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">City<font style="color: red">*</font></th>
                    <td><input type="text" name="city" placeholder="Enter City"
                        value="<%=DataUtility.getStringData(bean.getCity())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("city", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">PhoneNo<font style="color: red">*</font></th>
                    <td><input type="text" name="phoneNo" placeholder="Enter Contact No"
                        value="<%=DataUtility.getStringData(bean.getPhoneNo())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("phoneNo", request)%></font></td>
                </tr>
				<tr></tr><tr></tr><tr></tr><tr></tr>
				
                <td></td>
                	
                    <td><input type="submit" name="operation"
                        value="<%=(bean.getId()<=0)?CollegeCtl.OP_SAVE:CollegeCtl.OP_UPDATE%>" style="width: 99px"> <input type="submit" name="operation"
                        value="<%=CollegeCtl.OP_CANCEL%>" style="width: 97px"></td>
                </tr>
            </table>
    </form>
    </center>
    <%@ include file="Footer.jsp"%>
</body>
</html>