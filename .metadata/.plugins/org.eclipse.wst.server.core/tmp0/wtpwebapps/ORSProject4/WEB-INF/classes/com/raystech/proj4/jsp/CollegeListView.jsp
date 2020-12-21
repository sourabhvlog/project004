<%@page import="com.raystech.proj4.util.HTMLUtility"%>
<%@page import="com.raystech.proj4.model.CollegeModel"%>
<%@page import="com.raystech.proj4.model.UserModel"%>
<%@page import="com.raystech.proj4.controller.CollegeListCtl"%>
<%@page import="com.raystech.proj4.util.ServletUtility"%>
<%@page import="com.raystech.proj4.bean.CollegeBean"%>
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
}</script>
<link rel="stylesheet" type="text/css" href="../format.css"></link>
</head>
<body>
    <%@include file="Header.jsp"%>
    <jsp:useBean id="bean" class="com.raystech.proj4.bean.CollegeBean" scope="request"></jsp:useBean>
    <center>
        <h1>College List</h1>
        <h3><font color="red"><%=ServletUtility.getErrorMessage(request)%></font>
        <font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></h3>
		
		
		
        <form action="<%=ORSView.COLLEGE_LIST_CTL%>" name="frm" method="POST">
		<% List list = ServletUtility.getList(request); 
		List collegeList = (List)request.getAttribute("collegeList");%>
		<%if(list.size()!=0) { %>
            <table width="100%">
                <tr>
                    <td align="center"><label> Name : </label><%=HTMLUtility.getList("collegeId", String.valueOf(bean.getId()), collegeList, "College") %>&emsp;
                        <label>City :</label> <input type="text" name="city" placeholder="Enter City"
                        value="<%=ServletUtility.getParameter("city", request)%>">&emsp;
                        <input style="padding: 5px; width: 100px;" type="submit" name="operation"
                        value="<%=CollegeListCtl.OP_SEARCH%>"></td>
                </tr>
            </table>
            <br>
            <table border="2" width="100%">
                <tr>
                	<th style="width: 100px"><input type="checkbox" name="chk_all" onclick="checkedAll()"/>Select All</th>
                    <th>S.No.</th>
                    <th>Name</th>
                    <th>Address</th>
                    <th>State</th>
                    <th>City</th>
                    <th>PhoneNo</th>
                    <th>Edit</th>
                </tr>
                
                <%
                	CollegeModel model = new CollegeModel();
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize) + 1;
					
                    CollegeBean cBean = null;
                    Iterator<CollegeBean> it = list.iterator();
                    while (it.hasNext()) {

                     cBean = it.next();
                %>
                <tr align="center">
                	<td><input type="checkbox" id="sid" name="chk_1" onchange="check()" 
                    value="<%=cBean.getId()%>"></td>
                    <td><%=index++%></td>
                    <td><%=cBean.getName()%></td>
                    <td><%=cBean.getAddress()%></td>
                    <td><%=cBean.getState()%></td>
                    <td><%=cBean.getCity()%></td>
                    <td><%=cBean.getPhoneNo()%></td>
                    <td><a href="CollegeCtl?id=<%=cBean.getId()%>">Edit</a></td>
                </tr>
                <%
                    }
                %>
            </table>
            <br>
            <table width="100%">
                <tr>
                <%if(pageNo==1){ %>
                    <td><input style="padding: 5px; width: 100px;" type="submit" name="operation"
                        value="<%=CollegeListCtl.OP_PREVIOUS%>" disabled="disabled"></td><%} else {%>
                        <td><input style="padding: 5px; width: 100px;" type="submit" name="operation"
                        value="<%=CollegeListCtl.OP_PREVIOUS%>"></td><%} %>
                        
                    <td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=CollegeListCtl.OP_NEW%>"></td>
                    
                    <td align="center"><input style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=CollegeListCtl.OP_RESET%>"></td>
                    
                    <td><input style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=CollegeListCtl.OP_DELETE%>" <%if(list.size()==0){ %>disabled="disabled"<%} %>></td>
                    
                    <%if(pageSize > list.size() || model.nextPK()-1 == cBean.getId()) { %>
                    <td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
                        value="<%=CollegeListCtl.OP_NEXT%>" disabled="disabled"></td><%} else{ %>
                        <td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
                        value="<%=CollegeListCtl.OP_NEXT%>"></td><%} %>
                </tr>
            </table>
            <input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
                type="hidden" name="pageSize" value="<%=pageSize%>">
                <%} else{ %>
                <input style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=CollegeListCtl.OP_BACK%>">
                <%} %>
        </form>
        
    </center>
    <%@include file="Footer.jsp"%>
</body>
</html>
