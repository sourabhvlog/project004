<%@page import="com.raystech.proj4.controller.UserCtl"%>
<%@page import="java.util.List"%>
<%@page import="com.raystech.proj4.util.HTMLUtility"%>
<%@page import="java.util.HashMap"%> 
<%@page import="com.raystech.proj4.util.DataUtility"%>
<%@page import="com.raystech.proj4.util.ServletUtility"%>
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
			defaultDate : "01/01/1982",
			changeMonth : true,
			changeYear : true,
			yearRange : '-35:-18' 
		});
	});
</script>
<link rel="stylesheet" type="text/css" href="../format.css"></link>
</head>
<body>
    <form action="<%=ORSView.USER_CTL%>" method="post">
        <%@ include file="Header.jsp"%>
        <jsp:useBean id="bean" class="com.raystech.proj4.bean.UserBean"
            scope="request"></jsp:useBean>

        <%
            List l = (List) request.getAttribute("roleList");
        %>

        <center>
        	<%if(bean.getId()>0){ %>
        	<h1>Update User</h1>
        	<%} else {%>
            <h1>Add User</h1>
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


            <table align="center" style="margin-left:38% ">
                <tr>
                    <th align="left">First Name<font style="color: red">*</font></th>
                    <td><input type="text" name="firstName" placeholder="Enter First Name" 
                    value="<%=DataUtility.getStringData(bean.getFirstName())%>"><font 
                    color="red"> <%=ServletUtility.getErrorMessage("firstName", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Last Name<font style="color: red">*</font></th>
                    <td><input type="text" name="lastName" placeholder="Enter Last Name"
                        value="<%=DataUtility.getStringData(bean.getLastName())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("lastName", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">LoginId<font style="color: red">*</font></th>
                    <td><input type="text" name="login" placeholder="Enter Login-Id"
                        value="<%=DataUtility.getStringData(bean.getLogin())%>"
                        <%=(bean.getId() > 0) ? "readonly" : ""%>><font
                        color="red"> <%=ServletUtility.getErrorMessage("login", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Password<font style="color: red">*</font></th>
                    <td><input type="password" name="password" placeholder="Enter Password"
                        value="<%=DataUtility.getStringData(bean.getPassword())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("password", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Confirm Password<font style="color: red">*</font></th>
                    <td><input type="password" name="confirmPassword" placeholder="Re-Enter Password"
                        value="<%=DataUtility.getStringData(bean.getPassword())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("confirmPassword",
                    request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Gender<font style="color: red">*</font></th>
                    <td>
                        <%
                            HashMap map = new HashMap();
                            map.put("Male", "Male");
                            map.put("Female", "Female");

                            String htmlList = HTMLUtility.getList("gender", bean.getGender(),
                                    map, "Gender");
                        %> <%=htmlList%><font
                        color="red"> <%=ServletUtility.getErrorMessage("gender",
                    request)%></font>
                        </td>
                </tr>
               <tr>
                    <th align="left">Role<font style="color: red">*</font></th>
                    <td><%=HTMLUtility.getList("roleId", String.valueOf(bean.getRoleId()), l, "Role")%><font
                        color="red"> <%=ServletUtility.getErrorMessage("roleId",request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Date Of Birth<font style="color: red">*</font></th>
                    <td><input type="text" name="dob" placeholder="Click Here" id="datepicker" readonly="readonly"
                        value="<%=DataUtility.getDateString(bean.getDob())%>">
                    <font
                        color="red"> <%=ServletUtility.getErrorMessage("dob", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Contact No<font style="color: red">*</font></th>
                    <td><input type="text" name="contactNo" placeholder="Enter Contact No"
                        value="<%=DataUtility.getStringData(bean.getMobileNo())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("mno", request)%></font></td>
                </tr>
                <tr></tr><tr></tr><tr></tr><tr></tr>
                <tr>
                	<td></td>
                    <td><input type="submit" name="operation"
                        value="<%=(bean.getId()<=0) ? UserCtl.OP_SAVE : UserCtl.OP_UPDATE%>" style="width: 99px"> <input type="submit"8
                        name="operation" value="<%=UserCtl.OP_CANCEL%>" style="width: 97px"></td>
                </tr>
                
            </table>
    </form>
    </center>
    <%@ include file="Footer.jsp"%>
</body>
</html>