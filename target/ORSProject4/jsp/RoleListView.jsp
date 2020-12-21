<%@page import="com.raystech.proj4.util.HTMLUtility"%>
<%@page import="com.raystech.proj4.model.RoleModel"%>
<%@page import="com.raystech.proj4.controller.RoleListCtl"%>
<%@page import="com.raystech.proj4.controller.BaseCtl"%>
<%@page import="com.raystech.proj4.bean.RoleBean"%>
<%@page import="com.raystech.proj4.util.ServletUtility"%>
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
	var en=document.forms[0].elements[2].name;
	if(en!=undefined & en.indexOf("chk_")!=-1)
	{	
		document.forms[0].elements[2].checked=document.frm.chk_all.unchecked;
	}	
}
</script>
<link rel="stylesheet" type="text/css" href="../format.css"></link>
</head>
<body>

    <%@include file="Header.jsp"%>
    <jsp:useBean id="bean" class="com.raystech.proj4.bean.RoleBean" scope="request"></jsp:useBean>

    <center>
        <h1>Role List</h1>
        <h3><font color="red"><%=ServletUtility.getErrorMessage(request)%></font>
        <font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></h3>

			
        <form action="<%=ORSView.ROLE_LIST_CTL%>" name="frm" method="post">
            <%List list = ServletUtility.getList(request); %>
		<%if(list.size()!=0){ %>
		<%List rolelist = (List)request.getAttribute("roleList"); %>
            <table width="100%">
                <tr>
                    <td align="center"><label>Name : </label><%=HTMLUtility.getList("roleId", String.valueOf(bean.getId()), rolelist, "Name") %>
                    	&emsp;<label>Description :</label> <input type="text"
                        name="description" placeholder="Enter Name"
                        value="<%=ServletUtility.getParameter("name", request)%>">
                        &emsp; <input style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=RoleListCtl.OP_SEARCH %>">
                    </td>
                </tr>
            </table>
            <br>
            <table border="2" width="100%">
                <tr align="center">
                	<th style="width: 100px"><input type="checkbox" name="chk_all" onclick="checkedAll()"/>Select All</th>
                    <th>S.No.</th>
                    <th>Id</th>
                    <th>Name</th>
                    <th>Descriptiop</th>
                    <th>Edit</th>
                </tr>
               

                <%	RoleModel model = new RoleModel();
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize) + 1;

                    RoleBean rBean = null;
                    Iterator<RoleBean> it = list.iterator();
                    while (it.hasNext()) {
                        rBean = it.next();
                %>
                <tr align="center">
                	<td><input type="checkbox" id="sid" name="chk_1" onchange="check()" 
              <% if(rBean.getId()==RoleBean.ADMIN){ %>
              value=" " 
              <%}else{ %>
              value="<%=rBean.getId()%>" 
              <%} %>
              <%=(rBean.getId()==RoleBean.ADMIN)?"disabled":"" %>
              ></td>
                    <td><%=index++%></td>
                    <td><%=rBean.getId()%></td>
                    <td><%=rBean.getName()%></td>
                    <td><%=rBean.getDescription()%></td>
                    <%if(rBean.getId()==RoleBean.ADMIN){ %>
                    <td>----</td><%}else{ %>
                    <td><a href="RoleCtl?id=<%=rBean.getId()%>">Edit</a></td><%} %>
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
                        value="<%=RoleListCtl.OP_PREVIOUS%>" disabled="disabled"></td><%}else{ %>
                        <td><input style="padding: 5px; width: 100px;" type="submit" name="operation"
                        value="<%=RoleListCtl.OP_PREVIOUS%>"></td><%} %>
                        
                    <td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=RoleListCtl.OP_NEW%>"></td>
                    
                    <td align="center"><input style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=RoleListCtl.OP_RESET%>"></td>
                    
                    <td><input style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=RoleListCtl.OP_DELETE%>" <%if(list.size()==0){ %>disabled="disabled"<%} %>></td>
                    
                    <%if(pageSize > list.size() || model.nextPK()-1 == rBean.getId()) { %>
                    <td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
                        value="<%=RoleListCtl.OP_NEXT%>" disabled="disabled"></td><%}else{ %>
                        <td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
                        value="<%=RoleListCtl.OP_NEXT%>"></td><%} %>
                </tr>
            </table>
            <input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
                type="hidden" name="pageSize" value="<%=pageSize%>">
         <%} else { %>
        <input style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=RoleListCtl.OP_BACK%>">
        <%} %>
        </form>
       
    </center>
    <%@include file="Footer.jsp"%>
</body>
</html>