package com.raystech.proj4.controller;

import com.raystech.proj4.bean.BaseBean;
import com.raystech.proj4.bean.UserBean;
import com.raystech.proj4.exception.ApplicationException;
import com.raystech.proj4.exception.RecordNotFoundException;
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
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

/**
 * Change Password functionality Controller. Performs operation for Change
 * Password
 * 
 * @author SunilOS
 * @version 1.0
 * @Copyright (c) SunilOS
 */
@ WebServlet(name="ChangePasswordCtl",urlPatterns={"/ctl/ChangePasswordCtl"})
public class ChangePasswordCtl extends BaseCtl {

    public static final String OP_CHANGE_MY_PROFILE = "Change My Profile";

    private static Logger log = Logger.getLogger(ChangePasswordCtl.class);

    /**
     * Validates input data entered by user on change password form
     * 
     * @param request:
     * 				 HttpServletRequest object
     * @return pass:
     * 				a boolean variable
     */
    @Override
    protected boolean validate(HttpServletRequest request) {

        log.debug("ChangePasswordCtl Method validate Started");

        boolean pass = true;

        String op = request.getParameter("operation");

        if (OP_CHANGE_MY_PROFILE.equalsIgnoreCase(op)) {

            return pass;
        }
        if (DataValidator.isNull(request.getParameter("oldPassword"))) {
            request.setAttribute("oldPassword",
                    PropertyReader.getValue("error.require", "Old Password"));
            pass = false;
        }
        if (DataValidator.isNull(request.getParameter("newPassword"))) {
            request.setAttribute("newPassword",
                    PropertyReader.getValue("error.require", "New Password"));
            pass = false;
        }else if (!DataValidator.isPassword(request.getParameter("newPassword")))
        {
        	request.setAttribute("newPassword", PropertyReader.getValue("error.pass", "Password "));
        	pass = false;
        }
        	
        if (DataValidator.isNull(request.getParameter("confirmPassword"))) {
            request.setAttribute("confirmPassword", PropertyReader.getValue(
                    "error.require", "Confirm Password"));
            pass = false;
        }
        if (!request.getParameter("newPassword").equals(
                request.getParameter("confirmPassword"))
                && !"".equals(request.getParameter("confirmPassword"))) {
            ServletUtility.setErrorMessage(
                    "New and confirm passwords not matched", request);

            pass = false;
        }

        log.debug("ChangePasswordCtl Method validate Ended");

        return pass;
    }

    
    /**
     *  Populates UserBean object from request parameters
     *  
     *  @param request:
     *  				HttpServletRequest object
     *  @return bean:
     *  				UserBean object
     */
    @Override
    protected BaseBean populateBean(HttpServletRequest request) {
        log.debug("ChangePasswordCtl Method populatebean Started");

        UserBean bean = new UserBean();

        bean.setPassword(DataUtility.getString(request
                .getParameter("oldPassword")));

        bean.setConfirmPassword(DataUtility.getString(request
                .getParameter("confirmPassword")));

        populateDTO(bean, request);

        log.debug("ChangePasswordCtl Method populatebean Ended");

        return bean;
    }

    /**
     * Display Change Password form
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
        ServletUtility.forward(getView(), request, response);
    }

    /**
     * Contains submit logic
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

        log.debug("ChangePasswordCtl Method doGet Started");

        String op = DataUtility.getString(request.getParameter("operation"));

        // get model
        UserModel model = new UserModel();

        UserBean bean = (UserBean) populateBean(request);

        UserBean UserBean = (UserBean) session.getAttribute("user");

        String newPassword = (String) request.getParameter("newPassword");

        long id = UserBean.getId();

        if (OP_SAVE.equalsIgnoreCase(op)) {
        	boolean flag=false;
            try {
                flag = model.changePassword(id, bean.getPassword(),
                        newPassword);
                if (flag == true) {
                    bean = model.findByLogin(UserBean.getLogin());
                    session.setAttribute("user", bean);
                    ServletUtility.setBean(bean, request);
                    ServletUtility.setSuccessMessage(
                            "Password has been changed Successfully.", request);
                }
            } catch (ApplicationException e) {
                log.error(e);
               ServletUtility.handleException(e, request, response);
               return;

            } catch (RecordNotFoundException e) {
                ServletUtility.setErrorMessage("Old PassWord is Invalid",
                        request);
            } catch (MessagingException e) {
            	 if(flag==false) {
                 	try {
 						model.changePassword(id, newPassword, bean.getPassword());
 					} catch (RecordNotFoundException e1) {
 						e1.printStackTrace();
 					} catch (ApplicationException e1) {
 						e1.printStackTrace();
 					} catch (MessagingException e1) {
 						e1.printStackTrace();
 					}
                 }
                 ServletUtility.setErrorMessage("Please check your internet connection..!!", request);
             	ServletUtility.forward(getView(), request, response);
             	return;
			}
        } else if (OP_CHANGE_MY_PROFILE.equalsIgnoreCase(op)) {
            ServletUtility.redirect(ORSView.MY_PROFILE_CTL, request, response);
            return;
        }

        ServletUtility.forward(ORSView.CHANGE_PASSWORD_VIEW, request, response);
        log.debug("ChangePasswordCtl Method doGet Ended");
    }

    /**
     * Returns the VIEW page of ChangePasswordCtl
     * 
     * @return ChangePasswordView.jsp:
     * 									VIEW page of ChangePasswordCtl
     */
    @Override
    protected String getView() {
        return ORSView.CHANGE_PASSWORD_VIEW;
    }

}