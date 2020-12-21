<%@page import="com.raystech.proj4.bean.StudentBean"%>
<%@page import="com.raystech.proj4.model.StudentModel"%>
<%@page import="com.raystech.proj4.bean.CollegeBean"%>
<%@page import="com.raystech.proj4.model.CollegeModel"%>
<%@page import="com.raystech.proj4.controller.GetMarksheetCtl"%>
<%@page import="com.raystech.proj4.util.DataUtility"%>
<%@page import="com.raystech.proj4.util.ServletUtility"%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../format.css"></link>
</head>
<body>
    <%@ include file="Header.jsp"%>

    <jsp:useBean id="bean" class="com.raystech.proj4.bean.MarksheetBean" scope="request"></jsp:useBean>
        

    <center>
        <h1>Get Marksheet</h1>

        <h3><font color="red"> <%=ServletUtility.getErrorMessage(request)%>
        </font></h3>
       

        <H2>
            <font color="green"> <%=ServletUtility.getSuccessMessage(request)%>
            </font>
        </H2>
        

        <form action="<%=ORSView.GET_MARKSHEET_CTL%>" method="post">

            <input type="hidden" name="id" value="<%=bean.getId()%>">
           
            
            <table>
                <label>RollNo :</label>&emsp;
                <input type="text" name="rollNo" placeholder="Enter Roll Number"
                    value="<%=ServletUtility.getParameter("rollNo", request)%>">&emsp;
                <input type="submit" name="operation" value="<%=GetMarksheetCtl.OP_GO%>"> &nbsp;
                 <input type="submit" name="operation" value="<%=GetMarksheetCtl.OP_RESET%>">
                <br>
                </table>
                
                

                <%
                    if (bean.getRollNo() != null && bean.getRollNo().trim().length() > 0) {
                %>
                
                <% int physics = Integer.parseInt(DataUtility.getStringData(bean.getPhysics()));
                int chemistry = Integer.parseInt(DataUtility.getStringData(bean.getChemistry()));
                int maths = Integer.parseInt(DataUtility.getStringData(bean.getMaths()));
                int total = physics+chemistry+maths; 
        		String phyremark = DataUtility.passOrNot(physics);
        		String cheremark = DataUtility.passOrNot(chemistry);
        		String mathremark = DataUtility.passOrNot(maths);
        		float per = total/3;
        		String res = DataUtility.result(per, physics, chemistry, maths);%>
                <br>
                <table align="center" border="1" width="50%" height="50%">
					<tr>
                		<td colspan="5" align="center"><h2>Marksheet</h2></td>
                	</tr>
                	
                	<tr>
                		<td colspan="5"><h3>Roll No : <%=DataUtility.getStringData(bean.getRollNo()) %></h3></td>
                	</tr>
                	
                	<tr>
                		<td colspan="5"><h3>Student Name : <%=DataUtility.getStringData(bean.getName()) %></h3></td>
                	</tr>
                		
                	<tr align="center">
                		<td  rowspan="2" style="width: 20%; font-weight: bold;">Subject</td>
                		<td  rowspan="2" style="width: 20%; font-weight: bold;">Maximum Marks</td>
                		<td  rowspan="2" style="width: 20%; font-weight: bold;">Minimum Marks</td>
                		<td  colspan="2" style="width: 40%; font-weight: bold;">Marks Obtained</td>
                	</tr>
                	
                	<tr align="center">
                		<td style="font-weight: bold;">Marks</td>
                		<td style="font-weight: bold;">Remark</td>
                	</tr>
                	
                	<tr align="center">
                		<td>Physics</td>
                		<td>100</td>
                		<td>35</td>
                		<td><%=physics%></td>
                		<td><%=phyremark %></td>
                	</tr>
                	
                	<tr align="center">
                		<td>Chemistry</td>
                		<td>100</td>
                		<td>35</td>
                		<td><%=chemistry%></td>
                		<td><%=cheremark %></td>
                	</tr>
                	
                	<tr align="center">
                		<td>Maths</td>
                		<td>100</td>
                		<td>35</td>
                		<td><%=maths%></td>
                		<td><%=mathremark %></td>
                	</tr>
                	
                	<tr align="center">
                		<td style="font-weight: bold;">Total</td>
                		<td>300</td>
                		<td>105</td>
                		<td colspan="2" style="font-weight: bold;"><%=total%></td>
                	</tr>
                	
                	<tr>
                		<td colspan="2" align="center" style="font-weight: bold;">Grand Total</td>
                		<td colspan="3" align="center" style="font-weight: bold;"><%=total %> Out of 300</td>
                	</tr>
                	
                	
                	<tr>
                		<td colspan="2" align="center" style="font-weight: bold;">Percentage</td>
                		<td colspan="3" align="center" style="font-weight: bold;"><%=per %>%</td>
                	</tr>
                	
                	<tr>
                		<td colspan="2" align="center" style="font-weight: bold;">Result</td>
                		<td colspan="3" align="center" style="font-weight: bold;"><%=res %></td>
                	</tr>
                
                </table>
                
            <%
                }
            %>
        </form>
    </center>
    <%@ include file="Footer.jsp"%>
</body>
</html>