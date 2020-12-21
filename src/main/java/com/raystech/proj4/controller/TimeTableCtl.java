package com.raystech.proj4.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.raystech.proj4.bean.BaseBean;
import com.raystech.proj4.bean.TimeTableBean;
import com.raystech.proj4.exception.ApplicationException;
import com.raystech.proj4.exception.DuplicateRecordException;
import com.raystech.proj4.model.CourseModel;
import com.raystech.proj4.model.SubjectModel;
import com.raystech.proj4.model.TimeTableModel;
import com.raystech.proj4.util.DataUtility;
import com.raystech.proj4.util.DataValidator;
import com.raystech.proj4.util.PropertyReader;
import com.raystech.proj4.util.ServletUtility;

/**
 * TimeTable functionality Controller. Performs operation for add, update, delete
 * and get TimeTable
 * 
 * @author SunilOS
 * @version 1.0
 * @Copyright (c) SunilOS
 */
@WebServlet(name = "TimeTableCtl", urlPatterns = { "/ctl/TimeTableCtl" })

public class TimeTableCtl extends BaseCtl {

	private static Logger log = Logger.getLogger(TimeTableCtl.class);

	/**
	 * Loads list and other data required to display at HTML form
	 * 
	 * @param request:	
	 * 					HttpServletRequest object
	 */
	protected void preload(HttpServletRequest request) {
		CourseModel courseModel = new CourseModel();
		System.out.println("in preload");
		try {
			List listCourse = courseModel.list();
			request.setAttribute("courseList", listCourse);

		} catch (ApplicationException e) {
			log.error(e);
		}
		SubjectModel subjectModel = new SubjectModel();
		try {
			List listSubject = subjectModel.list();
			request.setAttribute("subjectList", listSubject);
		} catch (ApplicationException e) {
			log.error(e);
		}
	}

	/**
	 * Validates the input data entered by the user
	 * 
	 * @param request:
	 * 					HttpServletRequest object
	 * @return pass:
	 * 				a boolean variable
	 */
	protected boolean validate(HttpServletRequest request) {

		log.debug("TimeTableCtlMethod validate started");
		boolean pass = true;
		String op = DataUtility.getString(request.getParameter("operation"));

		if(DataUtility.getInt(request.getParameter("courseId"))==0) {
			request.setAttribute("courseId", PropertyReader.getValue("error.select", "course"));
			pass = false;
		}
		
		if(DataUtility.getInt(request.getParameter("subjectId"))==0) {
			request.setAttribute("subjectId", PropertyReader.getValue("error.select", "subject"));
			pass = false;
		}

		if(DataUtility.getString(request.getParameter("semester")).equals("")) {
			request.setAttribute("semester", PropertyReader.getValue("error.select", "semester"));
		}
		
		if (DataValidator.isNull(request.getParameter("examDate"))) {
			request.setAttribute("examDate", PropertyReader.getValue("error.require", "Date of exam"));
			pass = false;
		} else if (!DataValidator.isDate(request.getParameter("examDate"))) {
			request.setAttribute("examDate", PropertyReader.getValue("error.date", "Date of exam"));
			pass = false;
		}else if (DataUtility.getDate(request.getParameter("examDate")).getDay() == 0) {
			request.setAttribute("examDate", "Exam can't be scheduled on sunday");
			pass = false;

		}
		
		if(DataUtility.getString(request.getParameter("time")).equals("")) {
			request.setAttribute("time", PropertyReader.getValue("error.select", "time"));
			pass = false;
		}

		System.out.println("Validate method");
		log.debug("TimeTableCtl Method validate Ended");
		return pass;

	}

	/**
	 * Populates the TimeTableBean object from request parameters
	 * 
	 * @param request:
	 * 					HttpServletRequest object
	 * @return bean:
	 * 				TmeTableBean object
	 */
	protected BaseBean populateBean(HttpServletRequest request) {
		log.debug("TimeTableCtl Method populatebean Started");

		TimeTableBean bean = new TimeTableBean();

		bean.setId(DataUtility.getLong(request.getParameter("id")));
		bean.setCourseId(DataUtility.getLong(request.getParameter("courseId")));
		bean.setCourseName(DataUtility.getString(request.getParameter("courseName")));
		bean.setSubjectId(DataUtility.getLong(request.getParameter("subjectId")));
		bean.setSubjectName(DataUtility.getString(request.getParameter("subjectName")));
		bean.setSemester(DataUtility.getString(request.getParameter("semester")));
		bean.setExamDate(DataUtility.getDate(request.getParameter("examDate")));
		bean.setTime(DataUtility.getString(request.getParameter("time")));
		System.out.println("time...." + bean.getTime());

		populateDTO(bean, request);

		log.debug("TimeTableCtl Method populatebean Ended");
		return bean;

	}

	/**
	 * Display Add TimeTable and Update TimeTable form
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
		log.debug("TimeTableCtl Method doGet Started");
		// System.out.println("In do get");
		String op = DataUtility.getString(request.getParameter("operation"));
		long id = DataUtility.getLong(request.getParameter("id"));
		// System.err.println("bbd.b" + op);
		// get model
		TimeTableModel model = new TimeTableModel();
		if (id > 0 || op != null) {
			TimeTableBean bean;
			try {
				bean = model.findByPK(id);
				ServletUtility.setBean(bean, request);
			} catch (ApplicationException e) {
				e.printStackTrace();
				log.error(e);
				ServletUtility.handleException(e, request, response);
				return;
			}
		}
		// System.out.println("do get rrrrrrr");
		ServletUtility.forward(getView(), request, response);
		// System.out.println("after view method");
		log.debug("TimeTableCtl Method doGet Ended");
	}

	/**
	 * Contains Submit logic
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
		log.debug("TimeTableCtl Method doPost Started");
		String op = DataUtility.getString(request.getParameter("operation"));
		// get model

		TimeTableModel model = new TimeTableModel();
		long id = DataUtility.getLong(request.getParameter("id"));
		if (OP_SAVE.equalsIgnoreCase(op) || OP_UPDATE.equalsIgnoreCase(op)) {
			TimeTableBean bean = (TimeTableBean) populateBean(request);
			try {
				if (id > 0) {
					model.update(bean);
					ServletUtility.setBean(bean, request);
					ServletUtility.setSuccessMessage("Data is successfully updated", request);
				} else {
					long pk = model.add(bean);
					bean.setId(pk);
					// ServletUtility.setBean(bean, request);
					ServletUtility.setSuccessMessage("Data is successfully added", request);
				}
			} catch (ApplicationException e) {
				log.error(e);
				e.printStackTrace();
				ServletUtility.handleException(e, request, response);
				return;
			} catch (DuplicateRecordException e) {
				ServletUtility.setBean(bean, request);
				ServletUtility.setErrorMessage("TimeTable is already exists", request);
			}
		} else if (OP_DELETE.equalsIgnoreCase(op)) {

			TimeTableBean bean = (TimeTableBean) populateBean(request);
			try {
				model.delete(bean);
				ServletUtility.redirect(ORSView.TIMETABLE_LIST_CTL, request, response);
				return;
			} catch (ApplicationException e) {
				log.error(e);
				ServletUtility.handleException(e, request, response);
				return;
			}

		} else if (OP_RESET.equalsIgnoreCase(op)) {

			ServletUtility.redirect(ORSView.TIMETABLE_CTL, request, response);
			return;

		} else if (OP_CANCEL.equalsIgnoreCase(op)) {

			ServletUtility.redirect(ORSView.TIMETABLE_LIST_CTL, request, response);
			return;

		}
		ServletUtility.forward(getView(), request, response);

		log.debug("TimeTableCtl Method doPost Ended");
	}

	/**
	 * Returns the view page of TimeTableCtl
	 * 
	 * @return TimeTableView.jsp:
	 * 							View page of TimeTableCtl
	 */
	@Override
	protected String getView() {
		// TODO Auto-generated method stub
		return ORSView.TIMETABLE_VIEW;
	}

}
