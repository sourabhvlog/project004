package com.raystech.proj4.controller;

import com.raystech.proj4.bean.BaseBean;
import com.raystech.proj4.bean.FacultyBean;
import com.raystech.proj4.exception.ApplicationException;
import com.raystech.proj4.exception.DuplicateRecordException;
import com.raystech.proj4.model.SubjectModel;
import com.raystech.proj4.model.CollegeModel;
import com.raystech.proj4.model.CourseModel;
import com.raystech.proj4.model.FacultyModel;
import com.raystech.proj4.util.DataUtility;
import com.raystech.proj4.util.DataValidator;
import com.raystech.proj4.util.PropertyReader;
import com.raystech.proj4.util.ServletUtility;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

/**
 * Faculty functionality Controller. Performs operation for add, update and
 * get Faculty
 * 
 * @author SunilOS
 * @version 1.0
 * @Copyright (c) SunilOS
 */
@WebServlet(name = "FacultyCtl", urlPatterns = { "/ctl/FacultyCtl" })
public class FacultyCtl extends BaseCtl {

	
	private static final long serialVersionUID = 1L;

	private static Logger log = Logger.getLogger(FacultyCtl.class);

	/**
	 * Loads list and other data required to display at HTML form
	 * 
	 * @param request:
	 * 					HttpServletRequest object
	 */
	@Override
	protected void preload(HttpServletRequest request) {
		CollegeModel collegeModel = new CollegeModel();
		CourseModel courseModel = new CourseModel();
		SubjectModel subjectModel = new SubjectModel();
		try {
			List collegeList = collegeModel.list();
			List courseList = courseModel.list();
			List subjectList = subjectModel.list();
			request.setAttribute("collegeList", collegeList);
			request.setAttribute("courseList", courseList);
			request.setAttribute("subjectList", subjectList);
		} catch (ApplicationException e) {
			log.error(e);
		}

	}

	
	/**
	 * Validates the input data entered by user
	 * 
	 * @param request:
	 * 					HttpServletRequest object
	 * @return pass:
	 * 				a boolean variable
	 */
	@Override
	protected boolean validate(HttpServletRequest request) {

		log.debug("FacultyCtl Method validate Started");
		System.out.println("inside validate of faculty ctl............");
		boolean pass = true;

		String emailId = request.getParameter("emailId");
		String dob = request.getParameter("dob");

		if (DataValidator.isNull(request.getParameter("firstName"))) {
			System.out.println("first null");
			request.setAttribute("firstName", PropertyReader.getValue("error.require", "First Name"));
			pass = false;
		}else if (!DataValidator.isFname(request.getParameter("firstName"))) {
			request.setAttribute("firstName", PropertyReader.getValue("error.fname", "First Name"));
			pass = false;
		}

		if (DataValidator.isNull(request.getParameter("lastName"))) {
			System.out.println("last null");
			request.setAttribute("lastName", PropertyReader.getValue("error.require", "Last Name"));
			pass = false;
		} else if (!DataValidator.isLname(request.getParameter("lastName"))) {
			request.setAttribute("lastName", PropertyReader.getValue("error.lname", "Last Name"));
		}

		if(DataUtility.getString(request.getParameter("gender")).equals("")) {
			request.setAttribute("gender", PropertyReader.getValue("error.select", "gender"));
			pass = false;
		}
       
		if(DataUtility.getInt(request.getParameter("collegeId"))==0) {
			request.setAttribute("collegeId", PropertyReader.getValue("error.select", "college"));
			pass = false;
		}
		
		if(DataUtility.getInt(request.getParameter("courseId"))==0) {
			request.setAttribute("courseId", PropertyReader.getValue("error.select", "course"));
			pass = false;
		}

		if(DataUtility.getInt(request.getParameter("subjectId"))==0) {
			request.setAttribute("subjectId", PropertyReader.getValue("error.select", "subject"));
			pass = false;
		}

		
		if (DataValidator.isNull(request.getParameter("qualification"))) {
			System.out.println(" Qualification");
			request.setAttribute("qualification", PropertyReader.getValue("error.require", "Qualification"));
			pass = false;
		}

		if (DataValidator.isNull(emailId)) {
			System.out.println("email null");
			request.setAttribute("emailId", PropertyReader.getValue("error.require", "Email Id"));
			pass = false;
		} else if (!DataValidator.isEmail(emailId)) {
			System.out.println("isEmail");
			request.setAttribute("emailId", PropertyReader.getValue("error.email", "Email "));
			pass = false;
		}

		if(DataValidator.isNull(request.getParameter("mobNo"))) {
			request.setAttribute("mobNo", PropertyReader.getValue("error.require", "Mobile number"));
			pass = false;
		}
		else if (!DataValidator.isMobileNo(request.getParameter("mobNo"))) {
			request.setAttribute("mobNo", PropertyReader.getValue("error.mono", "Mobile number"));
			System.out.println("mobile num ");
			pass = false;
		}

		if (DataValidator.isNull(dob)) {
			System.out.println("dob null");
			request.setAttribute("dob", PropertyReader.getValue("error.require", "Date Of Birth"));
			System.out.println("dob is null");
			pass = false;
		} else if (!DataValidator.isDate(dob)) {
			System.out.println("dob is date");
			request.setAttribute("dob", PropertyReader.getValue("error.date", "Date Of Birth"));
			pass = false;
		}
		
		log.debug("FacultyCtl Method validate Ended");
		System.out.println("FacultyCtl Method validate Ended");
		System.out.println(pass + " return from validate facultyCtl");

		return pass;
	}

	/**
	 * Populates FacultyBean object from request parameters
	 * 
	 * @param request:
	 * 					HttpServletRequest object
	 * @return bean:
	 * 				FacultyBean object
	 */
	@Override
	protected BaseBean populateBean(HttpServletRequest request) {

		log.debug("FacultyCtl Method populatebean Started");

		FacultyBean bean = new FacultyBean();

		bean.setId(DataUtility.getLong(request.getParameter("id")));

		bean.setFirstName(DataUtility.getString(request.getParameter("firstName")));

		bean.setLastName(DataUtility.getString(request.getParameter("lastName")));

		bean.setCollegeId(DataUtility.getLong(request.getParameter("collegeId")));

		bean.setSubjectId(DataUtility.getLong(request.getParameter("subjectId")));
		
		bean.setCourseId(DataUtility.getLong(request.getParameter("courseId")));

		bean.setQualification(DataUtility.getString(request.getParameter("qualification")));

		bean.setEmailId(DataUtility.getString(request.getParameter("emailId")));

		bean.setMobNo(DataUtility.getString(request.getParameter("mobNo")));
		
		bean.setGender(DataUtility.getString(request.getParameter("gender")));

		bean.setDob(DataUtility.getDate(request.getParameter("dob")));

		populateDTO(bean, request);

		log.debug("FacultyCtl Method populatebean Ended");

		return bean;
	}

	/**
	 * Display Add Faculty and Update faculty form
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
		log.debug("FacultyCtl Method doGet Started");
		System.out.println("inside doget.....................");
		String op = DataUtility.getString(request.getParameter("operation"));
		// get model
		FacultyModel model = new FacultyModel();
		long id = DataUtility.getLong(request.getParameter("id"));
		if (id > 0 || op != null) {
			System.out.println("in id > 0  condition");
			FacultyBean bean;
			try {
				bean = model.findByPK(id);
				ServletUtility.setBean(bean, request);
			} catch (ApplicationException e) {
				log.error(e);
				e.printStackTrace();
				ServletUtility.handleException(e, request, response);
				return;
			}
		}
		System.out.println("inside end doget.....................");

		ServletUtility.forward(getView(), request, response);
		log.debug("FacultyCtl Method doGet Ended");
	}

	/**
	 * Contains Submit logics
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
		log.debug("FacultyCtl Method doPost Started");
		System.out.println("FacultyCtl Method doPost Started");
		String op = DataUtility.getString(request.getParameter("operation"));
		// get model
		FacultyModel model = new FacultyModel();
		long id = DataUtility.getLong(request.getParameter("id"));
		System.out.println("dopost " + id);
		if (OP_SAVE.equalsIgnoreCase(op) || OP_UPDATE.equalsIgnoreCase(op)) {
			FacultyBean bean = (FacultyBean) populateBean(request);

			try {
				if (id > 0) {
					model.update(bean);
					ServletUtility.setBean(bean, request);
					ServletUtility.setSuccessMessage("Data is succesfully updated", request);
				} else {
					long pk = model.add(bean);
					bean.setId(pk);
					// ServletUtility.setBean(bean, request);
					ServletUtility.setSuccessMessage("Data is successfully saved", request);
				}
				
			} catch (ApplicationException e) {
				log.error(e);
				ServletUtility.handleException(e, request, response);
				return;
			} catch (DuplicateRecordException e) {
				ServletUtility.setBean(bean, request);
				ServletUtility.setErrorMessage("Login id already exists", request);
			}
		} else if (OP_DELETE.equalsIgnoreCase(op)) {

			FacultyBean bean = (FacultyBean) populateBean(request);
			try {
				model.delete(bean);
				ServletUtility.redirect(ORSView.FACULTY_LIST_CTL, request, response);
				return;
			} catch (ApplicationException e) {
				log.error(e);
				ServletUtility.handleException(e, request, response);
				return;
			}

		} else if (OP_CANCEL.equalsIgnoreCase(op)) {

			ServletUtility.redirect(ORSView.FACULTY_LIST_CTL, request, response);
			return;
		}
		ServletUtility.forward(getView(), request, response);

		log.debug("FacultyCtl Method doPostEnded");
	}

	
	/**
	 * Returns the VIEW page of FacultyCtll
	 * 
	 * @return FacultyView.jsp:
	 * 							View page of FacultyCtl
	 */
	@Override
	protected String getView() {
		return ORSView.FACULTY_VIEW;
	}

}