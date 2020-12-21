<%@page import="com.raystech.proj4.controller.ForgetPasswordCtl"%>
<%@page import="com.raystech.proj4.util.DataUtility"%>
<%@page import="com.raystech.proj4.util.ServletUtility"%>
<html>


<body>
    <form action="<%=ORSView.FORGET_PASSWORD_CTL%>" method="post">

        <%@ include file="Header.jsp"%>

        <jsp:useBean id="bean" class="com.raystech.proj4.bean.UserBean"
            scope="request"></jsp:useBean>

        <center>
            <h1>Forgot your password?</h1>
            <input type="hidden" name="id" value="<%=bean.getId()%>">

            <table>
                 <lable><p style="text-decoration: underline;">Submit your email address and we'll send you password.</p></lable>
                 <H2>
                <font color="green"> <%=ServletUtility.getSuccessMessage(request)%>
                </font>
            </H2>
            <H2>
                <font color="red"> <%=ServletUtility.getErrorMessage(request)%>
                </font>
            </H2>
                <label>Email Id :</label>&emsp;
                <input style="width: 200px; padding: 5px;" type="text" name="login" placeholder="Enter ID Here"
                    value="<%=ServletUtility.getParameter("login", request)%>">&emsp;
                <input style="padding: 5px 28px; border-radius: 4px;" type="submit" name="operation" value="<%=ForgetPasswordCtl.OP_GO%>"> &nbsp;
                <input style="padding: 5px 28px; border-radius: 4px;" type="submit" name="operation" value="<%=ForgetPasswordCtl.OP_CANCEL%>"><br><br>
                <font color="red"> <%=ServletUtility.getErrorMessage("login", request)%></font>
            </table>
            
            
    </form>
    </center>
    <%@ include file="Footer.jsp"%>
</body>
</html>