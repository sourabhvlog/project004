<%@page import="com.raystech.proj4.controller.MyProfileCtl"%>
<%@page import="com.raystech.proj4.util.HTMLUtility"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.raystech.proj4.util.DataUtility"%>
<%@page import="com.raystech.proj4.util.ServletUtility"%>
<html>
<head>
<link  rel="stylesheet" type="text/css" href="../js/jquery-ui.css"></link>
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
<link  rel="stylesheet" type="text/css" href="../format.css"></link>
</head>
<body>

<form action="<%=ORSView.MY_PROFILE_CTL%>" method="post">

        <%@ include file="Header.jsp"%>
        <script type="text/javascript" src="../js/calendar.js"></script>
        <jsp:useBean id="bean" class="com.raystech.proj4.bean.UserBean" scope="request"></jsp:useBean>

        <center>
            <h1>My Profile</h1>
            
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
                    <th align="left">LoginId<font style="color: red">*</font></th>
                    <td><input type="text" name="login"
                        value="<%=DataUtility.getStringData(bean.getLogin())%>" readonly="readonly"><font
                        color="red"> <%=ServletUtility.getErrorMessage("login", request)%></font></td>
                </tr>

                <tr>
                    <th align="left">First Name<font style="color: red">*</font></th>
                    <td><input type="text" name="firstName"
                        value="<%=DataUtility.getStringData(bean.getFirstName())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("firstName", request)%></font></td>
                </tr>
                
                <tr>
                    <th align="left">Last Name<font style="color: red">*</font></th>
                    <td><input type="text" name="lastName"
                        value="<%=DataUtility.getStringData(bean.getLastName())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("lastName", request)%></font></td>
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
                        color="red"> <%=ServletUtility.getErrorMessage("gender", request)%></font>
                    </td>
                </tr>
                
                <tr>
                    <th align="left">Mobile No<font style="color: red">*</font></th>
                    <td><input type="text" name="mobileNo"
                        value="<%=DataUtility.getStringData(bean.getMobileNo())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("mobileNo", request)%></font></td>
                </tr>

                <tr>
                    <th align="left">Date Of Birth<font style="color: red">*</font></th>
                    <td><input type="text" name="dob" id="datepicker" readonly="readonly" 
                        value="<%=DataUtility.getDateString(bean.getDob())%>">
                    <font color="red"> <%=ServletUtility.getErrorMessage("dob", request)%></font></td>
                </tr>
                
                <tr></tr><tr></tr><tr></tr><tr></tr>
                
                <tr>
                <td></td>
                    <td><input style="padding: 5px; width: 125px;" type="submit" name="operation"
                        value="<%=MyProfileCtl.OP_CHANGE_MY_PASSWORD %>">  
                        <input style="padding: 5px; width: 70px;" type="submit" name="operation" 
                        value="<%=MyProfileCtl.OP_SAVE %>"></td>
                </tr>
            </table>
    </form>
    </center>
    <%@ include file="Footer.jsp"%>
</body>
</html>