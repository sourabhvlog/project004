package com.raystech.proj4.controller;

import com.raystech.proj4.bean.BaseBean;
import com.raystech.proj4.bean.UserBean;
import com.raystech.proj4.exception.ApplicationException;
import com.raystech.proj4.exception.DuplicateRecordException;
import com.raystech.proj4.model.RoleModel;
import com.raystech.proj4.model.UserModel;
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
 * User functionality Controller. Performs operation for add, update and get User
 * 
 * @author SunilOS
 * @version 1.0
 * @Copyright (c) SunilOS
 */
@ WebServlet(name="UserCtl",urlPatterns={"/ctl/UserCtl"})
public class UserCtl extends BaseCtl {

    private static final long serialVersionUID = 1L;

    private static Logger log = Logger.getLogger(UserCtl.class);
    
    /**
     * Loads list and other data required to display at HTML form
     * 
     * @param request:
     * 					HttpServletRequest object
     */
    @Override
    protected void preload(HttpServletRequest request) {
        RoleModel model = new RoleModel();
        try {
            List l = model.list();
            request.setAttribute("roleList", l);
        } catch (ApplicationException e) {
            log.error(e);
        }

    }

    /**
     * Validates the input data entered 
     * 
     * @param request:
     * 					HttpServletRequest object
     * @return pass:
     * 				a boolean variable
     */
    @Override
    protected boolean validate(HttpServletRequest request) {

        log.debug("UserCtl Method validate Started");

        boolean pass = true;

        String login = request.getParameter("login");
        String dob = request.getParameter("dob");
        

        if (DataValidator.isNull(request.getParameter("firstName"))) {
            request.setAttribute("firstName",PropertyReader.getValue("error.require", "First name"));
            pass = false;
        }else if(!DataValidator.isFname(request.getParameter("firstName")))
        {
        	request.setAttribute("firstName", PropertyReader.getValue("error.fname", "First name "));
        	pass = false;
        }
        
        if (DataValidator.isNull(request.getParameter("lastName"))) {
            request.setAttribute("lastName",PropertyReader.getValue("error.require", "Last name"));
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
        
        if(DataUtility.getInt(request.getParameter("roleId"))==0) {
        	request.setAttribute("roleId", PropertyReader.getValue("error.select", "role"));
        	pass  = false;
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
        
        if (DataValidator.isNull(request.getParameter("contactNo")))
        {
        	request.setAttribute("mno", PropertyReader.getValue("error.require", "Mobile no "));
        	pass = false;
        }else if(!DataValidator.isMobileNo(request.getParameter("contactNo")))
        {
        	request.setAttribute("mno", PropertyReader.getValue("error.mono", "Mobile no"));
        	pass = false;
        }
        
        if (!request.getParameter("password").equals(
                request.getParameter("confirmPassword"))
                && !"".equals(request.getParameter("confirmPassword"))) {
            ServletUtility.setErrorMessage(
                    "Confirm Password not matched...!!", request);
            pass = false;	
        }

        log.debug("UserCtl Method validate Ended");

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

        log.debug("UserCtl Method populatebean Started");

        UserBean bean = new UserBean();

        bean.setId(DataUtility.getLong(request.getParameter("id")));

        bean.setRoleId(DataUtility.getLong(request.getParameter("roleId")));

        bean.setFirstName(DataUtility.getString(request.getParameter("firstName")));

        bean.setLastName(DataUtility.getString(request.getParameter("lastName")));

        bean.setLogin(DataUtility.getString(request.getParameter("login")));

        bean.setPassword(DataUtility.getString(request.getParameter("password")));

        bean.setConfirmPassword(DataUtility.getString(request.getParameter("confirmPassword")));

        bean.setGender(DataUtility.getString(request.getParameter("gender")));

        bean.setDob(DataUtility.getDate(request.getParameter("dob")));
        
        bean.setMobileNo(DataUtility.getString(request.getParameter("contactNo")));

        populateDTO(bean, request);

        log.debug("UserCtl Method populatebean Ended");

        return bean;
    }

    /**
     * Display Add User and Update user form
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
        log.debug("UserCtl Method doGet Started");
        String op = DataUtility.getString(request.getParameter("operation"));
        // get model
        UserModel model = new UserModel();
        long id = DataUtility.getLong(request.getParameter("id"));
        if (id > 0 || op != null) {
            System.out.println("in id > 0  condition");
            UserBean bean;
            try {
                bean = model.findByPK(id);
                ServletUtility.setBean(bean, request);
            } catch (ApplicationException e) {
                log.error(e);
                ServletUtility.handleException(e, request, response);
                return;
            }
        }

        ServletUtility.forward(getView(), request, response);
        log.debug("UserCtl Method doGet Ended");
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
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        log.debug("UserCtl Method doPost Started");
        String op = DataUtility.getString(request.getParameter("operation"));
        // get model
        UserModel model = new UserModel();
        long id = DataUtility.getLong(request.getParameter("id"));
        if (OP_SAVE.equalsIgnoreCase(op) || OP_UPDATE.equalsIgnoreCase(op)) {
            UserBean bean = (UserBean) populateBean(request);

            try {
                if (id > 0) {
                    model.update(bean);
                    ServletUtility.setBean(bean, request);
                    ServletUtility.setSuccessMessage("Data is successfully updated",
                            request);
                } else {
                    long pk = model.add(bean);
                    bean.setId(pk);
                    ServletUtility.setSuccessMessage("Data is successfully saved",
                            request);
                }
               
            } catch (ApplicationException e) {
                log.error(e);
                e.printStackTrace();
                ServletUtility.handleException(e, request, response);
                return;
            } catch (DuplicateRecordException e) {
                ServletUtility.setBean(bean, request);
                ServletUtility.setErrorMessage("Login id already exists",
                        request);
            }
        } else if (OP_DELETE.equalsIgnoreCase(op)) {

            UserBean bean = (UserBean) populateBean(request);
            try {
                model.delete(bean);
                ServletUtility.redirect(ORSView.USER_LIST_CTL, request,
                        response);
                return;
            } catch (ApplicationException e) {
                log.error(e);
                ServletUtility.handleException(e, request, response);
                return;
            }

        } else if (OP_CANCEL.equalsIgnoreCase(op)) {

            ServletUtility.redirect(ORSView.USER_LIST_CTL, request, response);
            return;
        }
        
        
        ServletUtility.forward(getView(), request, response);

        log.debug("UserCtl Method doPostEnded");
    }

    /**
     * Returns the view page of UserCtl
     * 
     * @return UserView.jsp:
     * 						View page of UserCtl
     */
    @Override
    protected String getView() {
        return ORSView.USER_VIEW;
    }

}
