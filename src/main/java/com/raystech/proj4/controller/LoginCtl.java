package com.raystech.proj4.controller;

import com.raystech.proj4.bean.BaseBean;
import com.raystech.proj4.bean.RoleBean;
import com.raystech.proj4.bean.UserBean;
import com.raystech.proj4.exception.ApplicationException;
import com.raystech.proj4.model.RoleModel;
import com.raystech.proj4.model.UserModel;
import com.raystech.proj4.util.DataUtility;
import com.raystech.proj4.util.DataValidator;
import com.raystech.proj4.util.PropertyReader;
import com.raystech.proj4.util.ServletUtility;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

/**
 * Login functionality Controller. Performs operation for Login
 * 
 * @author SunilOS
 * @version 1.0
 * @Copyright (c) SunilOS
 */
@WebServlet(name = "LoginCtl", urlPatterns = { "/LoginCtl" })
public class LoginCtl extends BaseCtl {

	private static final long serialVersionUID = 1L;
	public static final String OP_REGISTER = "Register";
	public static final String OP_SIGN_IN = "SignIn";
	public static final String OP_SIGN_UP = "SignUp";
	public static final String OP_LOG_OUT = "logout";

	private static Logger log = Logger.getLogger(LoginCtl.class);

	/**
	 * Validates the input data entered by user
	 * 
	 * @param request:
	 *            HttpServletRequest object
	 * @return pass: a boolean variable
	 */
	@Override
	protected boolean validate(HttpServletRequest request) {

		log.debug("LoginCtl Method validate Started");

		boolean pass = true;

		String op = request.getParameter("operation");
		if (OP_SIGN_UP.equals(op) || OP_LOG_OUT.equals(op)) {
			return pass;
		}

		String login = request.getParameter("login");

		if (DataValidator.isNull(login)) {
			request.setAttribute("login", PropertyReader.getValue("error.require", "Login Id"));
			pass = false;
		} else if (!DataValidator.isEmail(login)) {
			request.setAttribute("login", PropertyReader.getValue("error.email", "Login "));
			pass = false;
		}
		
		if (DataValidator.isNull(request.getParameter("password"))) {
			request.setAttribute("password", PropertyReader.getValue("error.require", "Password"));
			pass = false;
		}

		log.debug("LoginCtl Method validate Ended");

		return pass;
	}

	/**
	 * Populates UserBean object from request parameters
	 * 
	 * @param request:
	 *            HttpServletRequest object
	 * @return bean: UserBean object
	 */
	@Override
	protected BaseBean populateBean(HttpServletRequest request) {

		log.debug("LoginCtl Method populatebean Started");

		UserBean bean = new UserBean();

		bean.setId(DataUtility.getLong(request.getParameter("id")));
		bean.setLogin(DataUtility.getString(request.getParameter("login")));
		bean.setPassword(DataUtility.getString(request.getParameter("password")));

		log.debug("LoginCtl Method populatebean Ended");

		return bean;
	}

	/**
	 * Display Login form
	 * 
	 * @param request:
	 *            HttpServletRequest object
	 * @param response:
	 *            HttpServletResponse object
	 * @throws ServletException
	 * @throws IOException
	 * 
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(true);
		log.debug(" Method doGet Started");

		String op = DataUtility.getString(request.getParameter("operation"));
		if (OP_LOG_OUT.equals(op)) {
			session = request.getSession();

			session.invalidate();

			ServletUtility.setSuccessMessage("Logged Out Successfully..!!", request);

			ServletUtility.forward(ORSView.LOGIN_VIEW, request, response);

			return;

		}
		// get model
		UserModel model = new UserModel();
		RoleModel role = new RoleModel();

		long id = DataUtility.getLong(request.getParameter("id"));
		if (id > 0) {
			UserBean userbean = null;
			try {
				userbean = model.findByPK(id);
				ServletUtility.setBean(userbean, request);
			} catch (ApplicationException e) {
				log.error(e);
				ServletUtility.handleException(e, request, response);
				return;
			}
		}
		ServletUtility.forward(getView(), request, response);

		log.debug("UserCtl Method doPost Ended");

	}

	/**
	 * Submitting or login action performing
	 * 
	 * @param request:
	 *            HttpServletRequest object
	 * @param response:
	 *            HttpServletResponse object
	 * @throws ServletException
	 * @throws IOException
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(true);
		log.debug(" Method doPost Started");

		String op = DataUtility.getString(request.getParameter("operation"));

		// get model
		UserModel model = new UserModel();
		RoleModel role = new RoleModel();

		long id = DataUtility.getLong(request.getParameter("id"));

		String path = request.getParameter("repath");
		if (OP_SIGN_IN.equalsIgnoreCase(op)) {

			UserBean bean = (UserBean) populateBean(request);

			try {

				bean = model.authenticate(bean.getLogin(), bean.getPassword());

				if (bean != null) {
					session.setAttribute("user", bean);
					long rollId = bean.getRoleId();

					RoleBean rolebean = role.findByPK(rollId);

					if (rolebean != null) {
						session.setAttribute("role", rolebean.getName());
					}
					
					if (path == null &&path.length()<=0) {	
						ServletUtility.forward(ORSView.WELCOME_VIEW, request, response);
					} else {
						ServletUtility.redirect(ORSView.APP_CONTEXT+path, request, response);
					}
					return;
				} else {
					bean = (UserBean) populateBean(request);
					ServletUtility.setBean(bean, request);
					ServletUtility.setErrorMessage("Invalid LoginId And Password", request);
				}

			} catch (ApplicationException e) {
				log.error(e);
				e.printStackTrace();
				ServletUtility.handleException(e, request, response);
				return;
			}

		} else if (OP_SIGN_UP.equalsIgnoreCase(op)) {

			ServletUtility.redirect(ORSView.USER_REGISTRATION_CTL, request, response);
			return;

		}

		ServletUtility.forward(getView(), request, response);

		log.debug("UserCtl Method doPost Ended");
	}

	/**
	 * Returns the VIEW page of LoginCtl
	 * 
	 * @return LoginView.jsp: View page of LoginCtl
	 */
	@Override
	protected String getView() {
		return ORSView.LOGIN_VIEW;
	}

}
