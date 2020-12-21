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

import org.apache.log4j.Logger;

/**
 * Forget Password functionality Controller. Performs operation for Forget
 * Password
 * 
 * @author SunilOS
 * @version 1.0
 * @Copyright (c) SunilOS
 */
@ WebServlet(name="ForgetPasswordCtl",urlPatterns={"/ForgetPasswordCtl"})
public class ForgetPasswordCtl extends BaseCtl {

    private static Logger log = Logger.getLogger(ForgetPasswordCtl.class);

    /**
     * Validates input data entered by user
     * 
     * @param request:
     * 					HttpServletRequest object
     * @return pass:
     * 				a boolean variable
     */
    @Override
    protected boolean validate(HttpServletRequest request) {

        log.debug("ForgetPasswordCtl Method validate Started");

        boolean pass = true;

        String login = request.getParameter("login");

        if (DataValidator.isNull(login)) {
            request.setAttribute("login",
                    PropertyReader.getValue("error.require", "Email Id"));
            pass = false;
        } else if (!DataValidator.isEmail(login)) {
            request.setAttribute("login",
                    PropertyReader.getValue("error.email", "Login "));
            pass = false;
        }
        log.debug("ForgetPasswordCtl Method validate Ended");

        return pass;
    }

    /**
     * Populates UserBean object from request parameters
     * 
     * @param request:
     * 					HttpServletRequest object
     * @return bean:
     * 				UserBean object
     */
    @Override
    protected BaseBean populateBean(HttpServletRequest request) {

        log.debug("ForgetPasswordCtl Method populatebean Started");

        UserBean bean = new UserBean();

        bean.setLogin(DataUtility.getString(request.getParameter("login")));

        log.debug("ForgetPasswordCtl Method populatebean Ended");

        return bean;
    }

    /**
     * Display Forget Password form
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
        log.debug("ForgetPasswordCtl Method doGet Started");

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
        log.debug("ForgetPasswordCtl Method doPost Started");

        String op = DataUtility.getString(request.getParameter("operation"));

        UserBean bean = (UserBean) populateBean(request);

        // get model
        UserModel model = new UserModel();

        if (OP_GO.equalsIgnoreCase(op)) {

            try {
                model.forgetPassword(bean.getLogin());
                ServletUtility.setSuccessMessage(
                        "Password has been sent to your email id.", request);
            } catch (RecordNotFoundException e) {
                ServletUtility.setErrorMessage(e.getMessage(), request);
                log.error(e);
            }catch (ApplicationException e) {
                log.error(e);
                ServletUtility.handleException(e, request, response);
                return;
                
            } catch (MessagingException e) {
            	ServletUtility.setErrorMessage("Please check your internet connection..!!", request);
            	ServletUtility.forward(getView(), request, response);
            	return;
			}
            ServletUtility.forward(getView(), request, response);
        }else if(OP_CANCEL.equalsIgnoreCase(op))
        {
        	ServletUtility.redirect(ORSView.LOGIN_CTL, request, response);
        	return;
        }

        log.debug("ForgetPasswordCtl Method doPost Ended");
    }

    /**
     * Returns the VIEW page of ForgrtPasswordCtl
     * 
     * @return ForgetPasswordView.jsp:
     * 									View page of ForgetPasswordCtl
     */
    @Override
    protected String getView() {
        return ORSView.FORGET_PASSWORD_VIEW;
    }

}
