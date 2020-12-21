package com.raystech.proj4.controller;

import com.raystech.proj4.bean.BaseBean;
import com.raystech.proj4.bean.RoleBean;
import com.raystech.proj4.bean.UserBean;
import com.raystech.proj4.exception.ApplicationException;
import com.raystech.proj4.exception.DatabaseException;
import com.raystech.proj4.exception.DuplicateRecordException;
import com.raystech.proj4.model.UserModel;
import com.raystech.proj4.util.DataUtility;
import com.raystech.proj4.util.DataValidator;
import com.raystech.proj4.util.PropertyReader;
import com.raystech.proj4.util.ServletUtility;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

/**
 * User registration functionality Controller. Performs operation for User
 * Registration
 * 
 * @author SunilOS
 * @version 1.0
 * @Copyright (c) SunilOS
 */
@ WebServlet(name="UserRegistrationCtl",urlPatterns={"/UserRegistrationCtl"})
public class UserRegistrationCtl extends BaseCtl {

    public static final String OP_SIGN_UP = "SignUp";

    private static Logger log = Logger.getLogger(UserRegistrationCtl.class);

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

        log.debug("UserRegistrationCtl Method validate Started");

        boolean pass = true;

        String login = request.getParameter("login");
        String dob = request.getParameter("dob");

        if (DataValidator.isNull(request.getParameter("firstName"))) {
            request.setAttribute("firstName",
                    PropertyReader.getValue("error.require", "First name"));
            pass = false;
        }else if(!DataValidator.isFname(request.getParameter("firstName")))
        {
        	request.setAttribute("firstName", PropertyReader.getValue("error.fname", "First name "));
        	pass = false;
        }
        
        
        
        if (DataValidator.isNull(request.getParameter("lastName"))) {
            request.setAttribute("lastName",
                    PropertyReader.getValue("error.require", "Last name"));
            pass = false;
        }else if(!DataValidator.isLname(request.getParameter("lastName")))
        {
        	request.setAttribute("lastName", PropertyReader.getValue("error.lname", "Last name"));
        	pass = false;
        }
        
        
        
        if (DataValidator.isNull(login)) {
            request.setAttribute("login",
                    PropertyReader.getValue("error.require", "Login Id"));
            pass = false;
        } else if (!DataValidator.isEmail(login)) {
            request.setAttribute("login",
                    PropertyReader.getValue("error.email", "Login "));
            pass = false;
        }
        if (DataValidator.isNull(request.getParameter("password"))) {
            request.setAttribute("password",
                    PropertyReader.getValue("error.require", "Password"));
            pass = false;
        }else if(!DataValidator.isPassword(request.getParameter("password")))
        {
        	request.setAttribute("password", PropertyReader.getValue("error.pass", "Password "));
        	pass = false;
        }
        
        
        
        if (DataValidator.isNull(request.getParameter("confirmPassword"))) {
            request.setAttribute("confirmPassword", PropertyReader.getValue(
                    "error.require", "Confirm Password"));
            pass = false;
        }
        if (DataUtility.getString(request.getParameter("gender")).equals("")) {
            request.setAttribute("gender",
                    PropertyReader.getValue("error.select", "gender"));
            pass = false;
        }
        if (DataValidator.isNull(dob)) {
            request.setAttribute("dob",
                    PropertyReader.getValue("error.require", "Date Of Birth"));
            pass = false;
        } else if (!DataValidator.isDate(dob)) {
            request.setAttribute("dob",
                    PropertyReader.getValue("error.date", "Date Of Birth"));
            pass = false;
        }
        
        if(DataValidator.isNull(request.getParameter("contactNo")))
        {
        	request.setAttribute("contactNo", PropertyReader.getValue("error.require", "Mobile no "));
        	pass = false;
        }else if(!DataValidator.isMobileNo(request.getParameter("contactNo")))
        {
        	request.setAttribute("contactNo", PropertyReader.getValue("error.mono", "Mobile no"));
        	pass = false;
        }
        
        if (!request.getParameter("password").equals(
                request.getParameter("confirmPassword"))
                && !"".equals(request.getParameter("confirmPassword"))) {
            ServletUtility.setErrorMessage(
                    "Confirm Password not matched...!!", request);

            pass = false;
        }
        log.debug("UserRegistrationCtl Method validate Ended");

        return pass;
    }

    /**
     * Populates the UserBean object from request parameters
     * 
     * @param request:
     * 					HttpServletRequest object
     * @return bean:
     * 				UserBean object
     */
    @Override
    protected BaseBean populateBean(HttpServletRequest request) {

        log.debug("UserRegistrationCtl Method populatebean Started");

        UserBean bean = new UserBean();

        bean.setId(DataUtility.getLong(request.getParameter("id")));

        bean.setRoleId(RoleBean.STUDENT);

        bean.setFirstName(DataUtility.getString(request
                .getParameter("firstName")));

        bean.setLastName(DataUtility.getString(request.getParameter("lastName")));

        bean.setLogin(DataUtility.getString(request.getParameter("login")));

        bean.setPassword(DataUtility.getString(request.getParameter("password")));

        bean.setConfirmPassword(DataUtility.getString(request
                .getParameter("confirmPassword")));

        bean.setGender(DataUtility.getString(request.getParameter("gender")));

        bean.setDob(DataUtility.getDate(request.getParameter("dob")));
        
        bean.setMobileNo(DataUtility.getString(request.getParameter("contactNo")));

        populateDTO(bean, request);

        log.debug("UserRegistrationCtl Method populatebean Ended");

        return bean;
    }

    /**
     * Display User Registration form
     * 
     * @param request:
     * 					HttpServletRequest object
     * @param response:
     * 					HttpServletResponse object
     * @throws ServletException
     * @throws IOException
     */
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        log.debug("UserRegistrationCtl Method doGet Started");
        ServletUtility.forward(getView(), request, response);

    }

    /**
     * Submit concept of user registration
     * 
     * @param request:
     * 					HttpServletRequest object
     * @param response:
     * 					HttpServletResponse object
     * @throws ServletException
     * @throws IOException
     */
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        System.out.println("in get method");
        log.debug("UserRegistrationCtl Method doPost Started");
        String op = DataUtility.getString(request.getParameter("operation"));
        // get model
        UserModel model = new UserModel();
        long id = DataUtility.getLong(request.getParameter("id"));
        if (OP_SIGN_UP.equalsIgnoreCase(op)) {
            UserBean bean = (UserBean) populateBean(request);
            long pk=0;
            try {
                pk = model.registerUser(bean);
                bean.setId(pk);
                request.getSession().setAttribute("UserBean", bean);
                ServletUtility.redirect(ORSView.LOGIN_CTL, request, response);
                return;
            
            } catch (ApplicationException e) {
                log.error(e);
                
                ServletUtility.handleException(e, request, response);
            	return;
                
            } catch (DuplicateRecordException e) {
                log.error(e);
                ServletUtility.setBean(bean, request);
                ServletUtility.setErrorMessage("Login id already exists",
                        request);
                ServletUtility.forward(getView(), request, response);
            } catch (MessagingException e) {
            	System.out.println("PK in messaging exception=="+pk);
            	 if(pk==0) {
                 	int lastpk;
                 	UserBean delbean = new UserBean();
                 	try {
 						lastpk=model.nextPK()-1;
 						delbean.setId(lastpk);
 						try {
 							model.delete(delbean);
 						} catch (ApplicationException e1) {
 							e1.printStackTrace();
 						}
 					} catch (DatabaseException e1) {
 						e1.printStackTrace();
 					}
                 }
                 
                 ServletUtility.setErrorMessage("Please check your internet connection..!!", request);
                 ServletUtility.setBean(bean, request);
             	ServletUtility.forward(getView(), request, response);
             	return;
			}
        }else if(OP_CANCEL.equalsIgnoreCase(op))
        {
        	ServletUtility.redirect(ORSView.LOGIN_CTL, request, response);
        	return;
        }
        log.debug("UserRegistrationCtl Method doPost Ended");
    }

    /**
     * Returns the view page of UserRegistrationCtl
     * 
     * @return UserRegistrationView.jsp:
     * 									View page of UserRegistrationCtl
     */
    @Override
    protected String getView() {
        return ORSView.USER_REGISTRATION_VIEW;
    }

}