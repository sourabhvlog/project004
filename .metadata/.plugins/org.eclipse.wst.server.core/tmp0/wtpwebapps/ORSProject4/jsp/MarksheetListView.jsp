<%@page import="com.raystech.proj4.model.MarksheetModel"%>
<%@page import="com.raystech.proj4.util.DataUtility"%>
<%@page import="com.raystech.proj4.util.HTMLUtility"%>
<%@page import="com.raystech.proj4.controller.MarksheetListCtl"%>
<%@page import="com.raystech.proj4.controller.BaseCtl"%>
<%@page import="com.raystech.proj4.util.ServletUtility"%>
<%@page import="com.raystech.proj4.bean.MarksheetBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<html>
<head>
<script type="text/javascript">
function checkedAll()
{
	
	var totalElement=document.forms[0].elements.length;
	for(var i=0;i<totalElement;i++){
		var en=document.forms[0].elements[i].name;
		
		if(en!=undefined & en.indexOf("chk_")!=-1)
		{	
			document.forms[0].elements[i].checked=document.frm.chk_all.checked;
		 
		}		
	}
}
function check(){
	var en=document.forms[0].elements[3].name;
	if(en!=undefined & en.indexOf("chk_")!=-1)
	{	
		document.forms[0].elements[3].checked=document.frm.chk_all.unchecked;
	}	
}
</script>
<link rel="stylesheet" type="text/css" href="../format.css"></link>
</head>
<body>
<jsp:useBean id="sbean" class="com.raystech.proj4.bean.StudentBean" scope="request"></jsp:useBean>
<jsp:useBean id="bean" class="com.raystech.proj4.bean.MarksheetBean" scope="request"></jsp:useBean>
<%List studentList  = (List)request.getAttribute("studentList"); %>
    <%@include file="Header.jsp"%>
    <center>
        <h1>Marksheet List</h1>
        <h3><font color="red"><%=ServletUtility.getErrorMessage(request)%></font>
        <font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></h3>
		<br>
        <form action="<%=ORSView.MARKSHEET_LIST_CTL%>" name="frm" method="POST">
			<%List list = ServletUtility.getList(request); %>
			<%if(list.size()!=0){ %>
            <table width="100%">
                <tr>
                    <td align="center"><label style="font-size: 15px"> Name :</label> 
                    	<%=HTMLUtility.getList("studentId", String.valueOf(bean.getStudentId()), studentList, "Student Name") %>
                        &emsp; <label style="font-size: 15px">RollNo :</label> <input type="text" name="rollNo" placeholder="Enter Roll Number"
                        value="<%=ServletUtility.getParameter("rollNo", request)%>">&emsp;
                        <input style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=MarksheetListCtl.OP_SEARCH %>"></td>
                </tr>
            </table>
            <br>
            <table border="1" width="100%">
                <tr>
                    <th style="width: 100px"><input type="checkbox" name="chk_all" onclick="checkedAll()"/>Select All</th>
                    <th>S.No</th>
                    <th>RollNo</th>
                    <th>Name</th>
                    <th style="width: 8%;">Physics</th>
                    <th style="width: 8%;">Chemistry</th>
                    <th style="width: 8%;">Maths</th>
                    <th style="width: 8%;">Total</th>
                    <th style="width: 8%;">Percentage</th>
                    <th style="width: 8%;">Result</th>
                    <th style="width: 8%;">Edit</th>
                </tr>
                
                <%
                	MarksheetModel model = new MarksheetModel();
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize) + 1;

                    MarksheetBean mbean = null;
                    Iterator<MarksheetBean> it = list.iterator();

                    while (it.hasNext()) {

                        mbean = it.next();
                        int total = mbean.getPhysics()+mbean.getChemistry()+mbean.getMaths();
                        float per = total/3;
                %>
                <tr align="center">
                    <td><input type="checkbox" id="sid" name="chk_1" onchange="check()" 
                    value="<%=mbean.getId()%>"></td>
                    <td><%=index++%></td>
                    <td><%=mbean.getRollNo()%></td>
                    <td><%=mbean.getName()%></td>
                    <td><%=mbean.getPhysics()%></td>
                    <td><%=mbean.getChemistry()%></td>
                    <td><%=mbean.getMaths()%></td>
                    <td><%=total %></td>
                    <td><%=per %>%</td>
                    <td><%=DataUtility.result(per, mbean.getPhysics(), mbean.getChemistry(), mbean.getMaths()) %></td>
                    <td><a href="MarksheetCtl?id=<%=mbean.getId()%>">Edit</a></td>
                </tr>

                <%
                    }
                %>
            </table>
            <br>
            <table width="100%">
            
                <tr>
                <%if(pageNo == 1){ %>
                    <td><input style="padding: 5px; width: 100px;" type="submit" name="operation"
                        value="<%=MarksheetListCtl.OP_PREVIOUS%>" disabled="disabled"></td><%}else{ %>
                        <td><input style="padding: 5px; width: 100px;" type="submit" name="operation"
                        value="<%=MarksheetListCtl.OP_PREVIOUS%>"></td><%} %>
                    <td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
                        value="<%=MarksheetListCtl.OP_NEW%>"></td>
                    <td align="center"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
                        value="<%=MarksheetListCtl.OP_RESET%>"></td>
                    <td><input style="padding: 5px; width: 100px;" type="submit"
                        name="operation" value="<%=MarksheetListCtl.OP_DELETE%>" <%if(list.size()==0) {%>disabled="disabled"<%} %>></td>
                    <%if(pageSize > list.size() || model.nextPK()-1 == mbean.getId()){ %>
                    <td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
                        value="<%=MarksheetListCtl.OP_NEXT%>" disabled="disabled"></td><%}else{ %>
                        <td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
                        value="<%=MarksheetListCtl.OP_NEXT%>"></td><%} %>
                </tr>
            </table>
            <input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
                type="hidden" name="pageSize" value="<%=pageSize%>">
                <%}else{ %>
                <input style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=MarksheetListCtl.OP_BACK%>">
                <%} %>
        </form>
        
    </center>
    <%@include file="Footer.jsp"%>
</body>
</html>