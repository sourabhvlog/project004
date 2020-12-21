<%@page import="com.raystech.proj4.controller.LoginCtl"%>
<%@page import="com.raystech.proj4.util.DataUtility"%>
<%@page import="com.raystech.proj4.util.ServletUtility"%>
<%@page import="com.raystech.proj4.controller.ORSView"%>


<html>
<head>
<link rel="stylesheet" type="text/css" href="../format.css"></link>
</head>


<body>

    <form action="<%=ORSView.LOGIN_CTL%>" method="post" >
        
        
      
         <%@ include file="Header.jsp"%> 
		
        
        
        <jsp:useBean id="bean" class="com.raystech.proj4.bean.UserBean"
            scope="request"></jsp:useBean>

        <center>
            <h1>Login</h1>
			<% String mess  = (String)request.getAttribute("message");%>
            <H2>
                <font color="red"> <%=ServletUtility.getErrorMessage(request)%></font>
                <font color="green"> <%=ServletUtility.getSuccessMessage(request)%></font>
                <%if(mess!=null){ %>
                <font color="red"><%=request.getAttribute("message") %></font><%} %>
            </H2>
            <%String path = (String) request.getAttribute("repath"); %>
            <input type ="hidden" value=<%=path!=null ? path : "/WelcomeCtl"%> name="repath">
            
              
              <input type="hidden" name="id" value="<%=bean.getId()%>">
              <input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
              <input type="hidden" name="modifiedBy" value="<%=bean.getModifiedBy()%>"> 
              <input type="hidden" name="createdDatetime" value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
              <input type="hidden" name="modifiedDatetime" value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">

			
            <table align="center" style="margin-left:40%"  style="min-height: 800px">
                <tr>
                    <th align="left">Login Id<font style="color: red">*</font></th>
                    <td><input style="width: 200px; padding: 5px;" type="text" name="login" placeholder="Enter Your Login-Id"
                        value="<%=DataUtility.getStringData(bean.getLogin())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("login", request)%></font></td>
                </tr><tr></tr><tr></tr>
                <tr>
                    <th align="left">Password<font style="color: red">*</font></th>
                    <td><input style="width: 200px; padding: 5px;" type="password"  name="password" placeholder="Enter Your Password"
                        value="<%=DataUtility.getStringData(bean.getPassword())%>"><font
                        color="red"> <%=ServletUtility.getErrorMessage("password", request)%></font></td>
                </tr>
                <tr></tr><tr></tr><tr></tr><tr></tr>
                <tr>
                <td></td>
                    <td> <input style="padding: 5px 28px; border-radius: 4px; width: 99px;" type="submit" name="operation"
                        value="<%=LoginCtl.OP_SIGN_IN %>"> 
                        <input style="padding: 5px 28px; border-radius: 4px; width: 99px;" type="submit" name="operation" 
                        value="<%=LoginCtl.OP_SIGN_UP %>"> &nbsp;</td>
                </tr>
                <tr></tr>
                <tr>
                <td></td>
                <td> <a href="<%=ORSView.FORGET_PASSWORD_CTL%>" style="margin-left: 25px;"><b>Forget my password</b></a>&nbsp;</td>
            </tr>
            </table>
            
    </form>
     <%@ include file="Footer.jsp"%>
</body>
</html>