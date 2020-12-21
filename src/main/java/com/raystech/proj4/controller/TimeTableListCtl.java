package com.raystech.proj4.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.raystech.proj4.bean.BaseBean;
import com.raystech.proj4.bean.TimeTableBean;
import com.raystech.proj4.exception.ApplicationException;
import com.raystech.proj4.model.CourseModel;
import com.raystech.proj4.model.TimeTableModel;
import com.raystech.proj4.util.DataUtility;
import com.raystech.proj4.util.PropertyReader;
import com.raystech.proj4.util.ServletUtility;
/**
 * Timetable List functionality Controller. Performs operation for list, search
 * and delete operations of Timetables
 * 
 * @author SunilOS
 * @version 1.0
 * @Copyright (c) SunilOS
 */
@WebServlet(name = "TimeTableListCtl", urlPatterns = { "/ctl/TimeTableListCtl" })

public class TimeTableListCtl extends BaseCtl {
	
	/**
	 * Loads list and other data required to display at HTML form
	 * 
	 * @param request:
	 * 					HttpServletRequest object
	 */
	@Override
	protected void preload(HttpServletRequest request) {
		CourseModel cmodel = new CourseModel();
		try {
			List cList = cmodel.list();
			request.setAttribute("courseList", cList);
		} catch (ApplicationException e) {
			e.printStackTrace();
		}
	}
	
	
	/**
     * Display TimeTable List
     * 
     * @param request:
     * 					HttpServletRequest object
     * @param response:
     * 					HttpServletResponse object
     * @throws ServletException
     * @throws IOException
     */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		long id = DataUtility.getLong(request.getParameter("id"));
		int pageNo = 1;
		int pageSize = DataUtility.getInt(PropertyReader.getValue("page.size"));
		TimeTableBean bean = (TimeTableBean) populateBean(request);
		TimeTableModel model = new TimeTableModel();
		List list = null;
		try {
			list = model.search(bean, pageNo, pageSize);
			ServletUtility.setList(list, request);
			if (list == null || list.size() == 0) {
				ServletUtility.setErrorMessage("No Record Found", request);
			}
			ServletUtility.setList(list, request);
			ServletUtility.setPageNo(pageNo, request);
			ServletUtility.setPageSize(pageSize, request);
			ServletUtility.forward(getView(), request, response);
		} catch (ApplicationException e) {
			e.printStackTrace();
			ServletUtility.handleException(e, request, response);
			return;
		}
	}
	
	
	/**
     * Contains submit logics
     * 
     * @param request:
     * 					HttpServletRequest object
     * @param response:
     * 					HttpServletResponse object
     * @throws ServletException
     * @throws IOException
     */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List list = null;

		int pageNo = DataUtility.getInt(request.getParameter("pageNo"));
		int pageSize = DataUtility.getInt(request.getParameter("pageSize"));
		int count=0;
		pageNo = (pageNo == 0) ? 1 : pageNo;
		pageSize = (pageSize == 0) ? DataUtility.getInt(PropertyReader.getValue("page.size")) : pageSize;

		TimeTableBean bean = (TimeTableBean) populateBean(request);
		String op = DataUtility.getString(request.getParameter("operation"));

		String[] ids = request.getParameterValues("chk_1");
		TimeTableModel model = new TimeTableModel();
		try {
			if (OP_SEARCH.equalsIgnoreCase(op) || OP_NEXT.equalsIgnoreCase(op) || OP_PREVIOUS.equalsIgnoreCase(op)) {
				if (OP_SEARCH.equalsIgnoreCase(op)) {
					pageNo = 1;
				} else if (OP_NEXT.equalsIgnoreCase(op)) {
					pageNo++;
				} else if (OP_PREVIOUS.equalsIgnoreCase(op) && pageNo > 1) {
					pageNo--;
				}
			}else if (OP_NEW.equalsIgnoreCase(op)) {
				ServletUtility.redirect(ORSView.TIMETABLE_CTL, request, response);
				return;
			} else if (OP_DELETE.equalsIgnoreCase(op)) {
				
				pageNo=1;
				if (ids != null && ids.length > 0) {
					TimeTableBean deleteBean = new TimeTableBean();
					for (String id : ids) {
						deleteBean.setId(DataUtility.getInt(id));
						model.delete(deleteBean);
						count++;
					}
					ServletUtility.setSuccessMessage("Record deleted successfully", request);
					} else {
					ServletUtility.setErrorMessage("Please Select at least one record ", request);
				}
			} else if (OP_RESET.equalsIgnoreCase(op) || OP_BACK.equalsIgnoreCase(op)) {
				ServletUtility.redirect(ORSView.TIMETABLE_LIST_CTL, request, response);
				return;
			}
			
			list = model.search(bean, pageNo, pageSize);
			ServletUtility.setList(list, request);
			if (list == null || list.size() == 0 && !OP_DELETE.equalsIgnoreCase(op)) {
				ServletUtility.setErrorMessage("No Record Found", request);
			}
			ServletUtility.setBean(bean, request);
			ServletUtility.setList(list, request);
			ServletUtility.setPageNo(pageNo, request);
			ServletUtility.setPageSize(pageSize, request);
			ServletUtility.forward(getView(), request, response);
		} catch (ApplicationException e) {
			e.printStackTrace();
			ServletUtility.handleException(e, request, response);
			return;
		}
	}

	/**
	 * Populates TimeTableBean object from request parameters
	 * 
	 * @param request:
	 * 					HttpServletRequest object
	 * @return bean:
	 * 				TimeTableBean object
	 */
	protected BaseBean populateBean(HttpServletRequest request) {
		TimeTableBean bean = new TimeTableBean();
		bean.setCourseName(DataUtility.getString(request.getParameter("courseName")));
		bean.setCourseId(DataUtility.getLong(request.getParameter("courseId")));
		bean.setSubjectName(DataUtility.getString(request.getParameter("subjectName")));
		bean.setSemester(DataUtility.getString(request.getParameter("semester")));
		bean.setExamDate(DataUtility.getDate(request.getParameter("examDate")));
		
		return bean;
	}
	
	/**
	 * Returns the view page of TimeTableListCtl
	 * 
	 * @return TimeTableListView.jsp:
	 * 									View page of TimeTableListCtl
	 */
	protected String getView() {
		return ORSView.TIMETABLE_LIST_VIEW;
	}
}
