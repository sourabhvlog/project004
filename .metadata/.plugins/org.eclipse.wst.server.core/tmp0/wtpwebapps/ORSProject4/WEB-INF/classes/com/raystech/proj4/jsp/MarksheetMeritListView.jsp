
<%@page import="com.raystech.proj4.controller.MarksheetMeritListCtl"%>
<%@page import="com.raystech.proj4.util.ServletUtility"%>
<%@page import="com.raystech.proj4.bean.MarksheetBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../format.css"></link>
</head>
<body>
    <%@include file="Header.jsp"%>
    <center>
        <h1>Marksheet Merit List</h1>
        <h3><font color="red"><%=ServletUtility.getErrorMessage(request)%></font></h3>

        <form action="<%=ORSView.MARKSHEET_MERIT_LIST_CTL%>" method="POST">
        <%List list = ServletUtility.getList(request); %>
            <%if(list.size()!=0){ %>
            <table border="1" width="100%">
                <tr align="center">

                    <th>Rank</th>
                    <th>Roll No</th>
                    <th>Name</th>
                    <th style="width: 12%;">Physics</th>
                    <th style="width: 12%;">Chemistry</th>
                    <th style="width: 12%;">Maths</th>
                    <th style="width: 12%;">Total</th>
                    <th style="width: 12%;">Percentage</th>

                </tr>
                
                <%
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize) + 1;

                    Iterator<MarksheetBean> it = list.iterator();

                    while (it.hasNext()) {

                        MarksheetBean bean = it.next();
                        float per = (bean.getPhysics()+bean.getMaths()+bean.getChemistry())/3;
                %>
                <tr align="center">

                    <td><%=index++%></td>
                    <td><%=bean.getRollNo()%></td>
                    <td><%=bean.getName()%></td>
                    <td><%=bean.getPhysics()%></td>
                    <td><%=bean.getChemistry()%></td>
                    <td><%=bean.getMaths()%></td>
                    <td><%=bean.getPhysics()+bean.getMaths()+bean.getChemistry() %></td>
					<td><%=per %>%</td>
                </tr>

                <%
                    }
                %>
            </table>
            <br>
            <table>
                <tr>
                    <td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
                        value="<%=MarksheetMeritListCtl.OP_BACK%>"></td>
                </tr>
            </table>
            <input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
                type="hidden" name="pageSize" value="<%=pageSize%>">
                <%}else{ %>
                <input style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=MarksheetMeritListCtl.OP_BACK%>">
                <%} %>
        </form>
    </center>
    <%@include file="Footer.jsp"%>
</body>
</html>