<%@page import="com.raystech.proj4.controller.UserRegistrationCtl"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.raystech.proj4.util.HTMLUtility"%>
<%@page import="com.raystech.proj4.util.DataUtility"%>
<%@page import="com.raystech.proj4.util.ServletUtility"%>
<%@page import="com.raystech.proj4.controller.ORSView"%>

<html>
<head>

<link rel="stylesheet" href="<%=ORSView.APP_CONTEXT%>/js/jquery-ui.css">

<script type="text/javascript"
	src="<%=ORSView.APP_CONTEXT%>/js/calendar.js"></script>
<script type="text/javascript"
	src="<%=ORSView.APP_CONTEXT%>/js/jquery-1.12.4.js"></script>
<script type="text/javascript"
	src="<%=ORSView.APP_CONTEXT%>/js/jquery-ui.js"></script>
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


</head>
<body>
 <%@ include file="Header.jsp"%>
    <form action="<%=ORSView.USER_REGISTRATION_CTL%>" name="frm" method="post">

       
        <jsp:useBean id="bean" class="com.raystech.proj4.bean.UserBean"
            scope="request"></jsp:useBean>

        <center>
            <h1>User Registration</h1>

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
            

            <table align="center" style="margin-left:38%">

                <tr>
                    <th align="left">First Name<font style="color: red">*</font></th>
                    <td><input style="width: 200px; padding: 5px;" type="text" name="firstName" placeholder="Enter Your First Name"
                        value="<%=DataUtility.getStringData(bean.getFirstName())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("firstName", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Last Name<font style="color: red">*</font></th>
                    <td><input style="width: 200px; padding: 5px;" type="text" name="lastName" placeholder="Enter Your Last Name"
                        value="<%=DataUtility.getStringData(bean.getLastName())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("lastName", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">LoginId<font style="color: red">*</font></th>
                    <td><input style="width: 200px; padding: 5px;" type="text" name="login"
                        placeholder="Enter Your Email-Id"
                        value="<%=DataUtility.getStringData(bean.getLogin())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("login", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Password<font style="color: red">*</font></th>
                    <td><input style="width: 200px; padding: 5px;" type="password" name="password" placeholder="Enter Password"
                        value="<%=DataUtility.getStringData(bean.getPassword())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("password", request)%></font></td>
                </tr>
                <tr>
                    <th align="left">Confirm Password<font style="color: red">*</font></th>
                    <td><input style="width: 200px; padding: 5px;" type="password" name="confirmPassword" placeholder="Re-Enter Password"
                        value="<%=DataUtility.getStringData(bean.getConfirmPassword())%>"><font
                        color="red"> <%=ServletUtility
                    .getErrorMessage("confirmPassword", request)%></font></td>
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
                        color="red"> <%=ServletUtility.getErrorMessage("gender", request)%></font></td>

                   
                </tr>

                <tr>
                    <th align="left">Date Of Birth</th>
                    <td><input style="width: 200px; padding: 5px;" type="text" name="dob" id="datepicker" readonly="readonly"
                     placeholder="Click Here" 
                        value="<%=DataUtility.getDateString(bean.getDob())%>"> 
                        <font color="red"> <%=ServletUtility.getErrorMessage("dob", request)%></font></td>
                </tr>
                
                <tr>
                    <th align="left">Contact No<font style="color: red">*</font></th>
                    <td><input style="width: 200px; padding: 5px;" type="text" name="contactNo" placeholder="Enter Your Contact No"
                        value="<%=DataUtility.getStringData(bean.getMobileNo())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("contactNo", request)%></font></td>
                </tr>
                <tr></tr><tr></tr><tr></tr><tr></tr>
                <tr>
                	<td></td>
                    <td><input style="padding: 5px 28px; border-radius: 4px; width: 99px;" 
                    type="submit" align="left" name="operation" value="<%=UserRegistrationCtl.OP_SIGN_UP %>">
                    <input style="padding: 5px 28px; border-radius: 4px; width: 99px;" 
                    type="submit" align="left" name="operation" value="<%=UserRegistrationCtl.OP_CANCEL %>">
                    </td>
                </tr>
            </table>
    </form>
    </center>
    <%@ include file="Footer.jsp"%>
</body>
</html>