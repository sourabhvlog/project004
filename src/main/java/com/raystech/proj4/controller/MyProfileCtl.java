package com.raystech.proj4.controller;

import com.raystech.proj4.bean.BaseBean;
import com.raystech.proj4.bean.UserBean;
import com.raystech.proj4.exception.ApplicationException;
import com.raystech.proj4.exception.DuplicateRecordException;
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
 * My Profile functionality Controller. Performs operation for update your
 * Profile
 * 
 * @author SunilOS
 * @version 1.0
 * @Copyright (c) SunilOS
 */



@ WebServlet(name="MyProfileCtl",urlPatterns={"/ctl/MyProfileCtl"})
public class MyProfileCtl extends BaseCtl {

    public static final String OP_CHANGE_MY_PASSWORD = "ChangePassword";

    private static Logger log = Logger.getLogger(MyProfileCtl.class);
  
    /**
     * Validates the input data entered by the user
     * 
     * @param request:
     * 					HttpServletRequest object
     * @return pass:
     * 					a boolean variable
     */
    @Override
    protected boolean validate(HttpServletRequest request) {

        log.debug("MyProfileCtl Method validate Started");

        boolean pass = true;

        String op = DataUtility.getString(request.getParameter("operation"));

        if (OP_CHANGE_MY_PASSWORD.equalsIgnoreCase(op) || op == null) {

            return pass;
        }

        if (DataValidator.isNull(request.getParameter("firstName"))) {
            System.out.println("firstName" + request.getParameter("firstName"));
            request.setAttribute("firstName",
                    PropertyReader.getValue("error.require", "First Name"));
            pass = false;
        }else if(!DataValidator.isFname(request.getParameter("firstName")))
			{
				request.setAttribute("firstName", PropertyReader.getValue("error.fname", "First Name"));
				pass = false;
			}

        if (DataValidator.isNull(request.getParameter("lastName"))) {
            request.setAttribute("lastName",
                    PropertyReader.getValue("error.require", "Last Name"));
            pass = false;
        }else if(!DataValidator.isLname(request.getParameter("lastName")))
        {
        	request.setAttribute("lastName", PropertyReader.getValue("error.lname", "Last name"));
        	pass = false;
        }

        if(DataUtility.getString(request.getParameter("gender")).equals("")) {
        	request.setAttribute("gender", PropertyReader.getValue("error.select", "gender"));
        	pass = false;
        }
        
        
        if (DataValidator.isNull(request.getParameter("mobileNo"))) {
            request.setAttribute("mobileNo",
                    PropertyReader.getValue("error.require", "Mobile no"));
            pass = false;
        }else if(!DataValidator.isMobileNo(request.getParameter("mobileNo")))
        {
        	request.setAttribute("mobileNo", PropertyReader.getValue("error.mono", "Mobile no"));
        	pass = false;
        }
        	
        	
        	

        if (DataValidator.isNull(request.getParameter("dob"))) {
            request.setAttribute("dob",
                    PropertyReader.getValue("error.require", "Date Of Birth"));
            pass = false;
        }

        log.debug("MyProfileCtl Method validate Ended");

        return pass;

    }

    /**
     * Populates the UserBean object form request parameters
     * 
     * @param request:
     * 					HttpServletRequest object
     * @return bean:
     * 				UserBean object
     */
    @Override
    protected BaseBean populateBean(HttpServletRequest request) {
        log.debug("MyProfileCtl Method populatebean Started");

        UserBean bean = new UserBean();

        bean.setId(DataUtility.getLong(request.getParameter("id")));

        bean.setLogin(DataUtility.getString(request.getParameter("login")));

        bean.setFirstName(DataUtility.getString(request
                .getParameter("firstName")));

        bean.setLastName(DataUtility.getString(request.getParameter("lastName")));

        bean.setMobileNo(DataUtility.getString(request.getParameter("mobileNo")));

        bean.setGender(DataUtility.getString(request.getParameter("gender")));

        bean.setDob(DataUtility.getDate(request.getParameter("dob")));

        populateDTO(bean, request);

        return bean;
    }

    /**
     * Display My Profile page 
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
        HttpSession session = request.getSession(true);
        log.debug("MyprofileCtl Method doGet Started");

        UserBean UserBean = (UserBean) session.getAttribute("user");
        long id = UserBean.getId();
        String op = DataUtility.getString(request.getParameter("operation"));

        // get model
        UserModel model = new UserModel();
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

        log.debug("MyProfileCtl Method doGet Ended");
    }

    /**
     * Contains the submit logic
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
        HttpSession session = request.getSession(true);
        log.debug("MyprofileCtl Method doPost Started");

        UserBean UserBean = (UserBean) session.getAttribute("user");
        long id = UserBean.getId();
        String op = DataUtility.getString(request.getParameter("operation"));

        // get model
        UserModel model = new UserModel();

        if (OP_SAVE.equalsIgnoreCase(op)) {
            UserBean bean = (UserBean) populateBean(request);
            try {
                if (id > 0) {
                    UserBean.setFirstName(bean.getFirstName());
                    UserBean.setLastName(bean.getLastName());
                    UserBean.setGender(bean.getGender());
                    UserBean.setMobileNo(bean.getMobileNo());
                    UserBean.setDob(bean.getDob());
                    model.update(UserBean);

                }
                ServletUtility.setBean(bean, request);
                ServletUtility.setSuccessMessage(
                        "Profile has been updated Successfully", request);
            } catch (ApplicationException e) {
                log.error(e);
                ServletUtility.handleException(e, request, response);
                return;
            } catch (DuplicateRecordException e) {
                ServletUtility.setBean(bean, request);
                ServletUtility.setErrorMessage("Login id already exists",
                        request);
            }
        } else if (OP_CHANGE_MY_PASSWORD.equalsIgnoreCase(op)) {

            ServletUtility.redirect(ORSView.CHANGE_PASSWORD_CTL, request,
                    response);
            return;

        }

        ServletUtility.forward(getView(), request, response);

        log.debug("MyProfileCtl Method doPost Ended");
    }

    /**
     * Returns the view page of MyProfileCtl
     * 
     * @return MyProfileView.jsp:
     * 								View page of MyProfileCtl
     */
    @Override
    protected String getView() {
        return ORSView.MY_PROFILE_VIEW;
    }

}