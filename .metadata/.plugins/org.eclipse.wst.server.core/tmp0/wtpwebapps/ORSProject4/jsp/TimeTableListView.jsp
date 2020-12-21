
<%@page import="com.raystech.proj4.util.HTMLUtility"%>
<%@page import="com.raystech.proj4.model.TimeTableModel"%>
<%@page import="com.raystech.proj4.controller.TimeTableCtl"%>
<%@page import="com.raystech.proj4.controller.ORSView"%>
<%@page import="com.raystech.proj4.controller.TimeTableListCtl"%>
<%@page import="com.raystech.proj4.bean.TimeTableBean"%>
<%@page import="com.raystech.proj4.bean.CourseBean"%>
<%@page import="com.raystech.proj4.util.ServletUtility"%>
<%@page import="com.raystech.proj4.util.DataUtility"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="javax.servlet.ServletContext"%>
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
	var en=document.forms[0].elements[5].name;
	if(en!=undefined & en.indexOf("chk_")!=-1)
	{	
		document.forms[0].elements[5].checked=document.frm.chk_all.unchecked;
	}	
}
</script>
<script type="text/javascript">
	  $(function() {
		
		$("#datepicker2").datepicker({
			dateFormat : 'mm/dd/yy',
			minDate: new Date(),
			maxDate: "12/31/2019",
			changeMonth : true,
			changeYear : true,
			yearRange : "2018:2019" 
		});
	}); 
</script>
<link rel="stylesheet" type="text/css" href="../format.css"></link>
</head>
<div id="header">
	<%@ include file="Header.jsp"%>
</div>

<body>
<jsp:useBean id="cBean" class="com.raystech.proj4.bean.CourseBean" scope="request"></jsp:useBean>
<jsp:useBean id="bean" class="com.raystech.proj4.bean.TimeTableBean" scope="request"></jsp:useBean>
	<form action="<%=ORSView.TIMETABLE_LIST_CTL%>" name="frm" method="post">
	
		<h1 align="center">Timetable List</h1>
		<center>
		<h3>
			<font color="red"><%=ServletUtility.getErrorMessage(request)%></font>
			<font color="green"><%=ServletUtility.getSuccessMessage(request)%></font>
		</h3>
		
		<%List list = ServletUtility.getList(request);
		Integer i = (Integer)request.getAttribute("var");%>
	<%if(list.size()!=0){%>
	<%List courseList = (List)request.getAttribute("courseList"); %>
		<table width="100%">

			<tr>
				<td align="center"><label>Course Name : </label>
					<%=HTMLUtility.getList("courseId", String.valueOf(bean.getCourseId()), courseList, "Course") %>
					&emsp;<label>Semester : </label><%
							HashMap map = new HashMap();

							map.put("I", "I");
							map.put("II", "II");
							map.put("III", "III");
							map.put("IV", "IV");
							map.put("V", "V");
							map.put("VI", "VI");
							map.put("VII", "VII");
							map.put("VIII", "VIII");

							String htmlList = HTMLUtility.getList("semester", bean.getSemester(), map, "Semester");
							DataUtility.getString("semester");
						%> <%=htmlList%>
					&emsp;<label>Subject Name : </label><input type="text"
					name="subjectName" placeholder="Enter Subject Name"
					value="<%=ServletUtility.getParameter("subjectName", request)%>">
					&emsp;<label>Exam Date : </label><input type="text" name="examDate"
						 id="datepicker2" placeholder="Date Of Exam(Click Here)" readonly="readonly"
						value="<%=ServletUtility.getParameter("examDate", request)%>">
					&emsp;<input style="padding: 5px; width: 100px;" type="submit" name="operation"
					value="<%=TimeTableListCtl.OP_SEARCH%>"> </td>
			</tr>
		</table>
		<br>
		<table border="1" width="100%" align="center">

			<tr>
				<th style="width: 100px"><input type="checkbox" name="chk_all" onclick="checkedAll()"/>Select All</th>
				<th>S.No</th>
				<th>Course Name</th>
				<th>Subject Name</th>
				<th>Semester</th>
				<th>Date</th>
				<th>Time</th>
				<th>Edit</th>
			</tr>
			<%
					TimeTableModel model = new TimeTableModel();
					int pageNo = ServletUtility.getPageNo(request);
					int pageSize = ServletUtility.getPageSize(request);
					int index = ((pageNo - 1) * pageSize) + 1;
					
					Iterator<TimeTableBean> it = list.iterator();
					TimeTableBean tbean= null;
					while (it.hasNext()) {
					 tbean = it.next();
			%>
			<tr align="center">
				<td><input type="checkbox" id="sid" name="chk_1" onchange="check()" value="<%=tbean.getId()%>"></td>
                <td><%=index++ %></td>
				<td><%=tbean.getCourseName()%>
				<td><%=tbean.getSubjectName()%></td>
				<td><%=tbean.getSemester()%></td>
				<td><%=tbean.getExamDate()%>
				<td><%=tbean.getTime()%>
				<td><a href="TimeTableCtl?id=<%=tbean.getId()%>">Edit</a></td>
			</tr>
			<%
				}
			%>
		</table>
		<br>
		<table width="100%" align="center">
			<tr>
				<td><input style="padding: 5px; width: 100px;" type="submit" name="operation"
					value="<%=TimeTableCtl.OP_PREVIOUS%>" <%if (pageNo == 1) {%>
					disabled="disabled" <%}%>></td>
				<td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
					value="<%=TimeTableCtl.OP_NEW%>"></td>
				<td align="center"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
					value="<%=TimeTableCtl.OP_RESET%>"></td>
				<td><input style="padding: 5px; width: 100px;" type="submit" name="operation"
					value="<%=TimeTableCtl.OP_DELETE%>" <%if(list.size()==0){ %>disabled="disabled"<%} %>></td><td></td>
				<td align="right"><input style="padding: 5px; width: 100px;" type="submit" name="operation"
					value="<%=TimeTableCtl.OP_NEXT%>" <%if (list.size() < pageSize || model.nextPK()-1 == tbean.getId()) {%>
					disabled="disabled" <%}%>></td>
			</tr>
		</table>
		<input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
			type="hidden" name="pageSize" value="<%=pageSize%>">
			<%} else{ %>
			<input style="padding: 5px; width: 100px;" type="submit" name="operation" value="<%=TimeTableListCtl.OP_BACK%>">
			<%} %>
			</center>
	</form>
	

</body>
<div id="footer">
	<%@ include file="Footer.jsp"%></div>

</html>