
package com.raystech.proj4.controller;

import com.raystech.proj4.bean.BaseBean;
import com.raystech.proj4.bean.MarksheetBean;
import com.raystech.proj4.exception.ApplicationException;
import com.raystech.proj4.model.MarksheetModel;
import com.raystech.proj4.util.DataUtility;
import com.raystech.proj4.util.DataValidator;
import com.raystech.proj4.util.PropertyReader;
import com.raystech.proj4.util.ServletUtility;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

/**
 * Get Marksheet functionality Controller. Performs operation for Get Marksheet
 * 
 * @author SunilOS
 * @version 1.0
 * @Copyright (c) SunilOS
 */
@ WebServlet(name="GetMarksheetCtl",urlPatterns={"/ctl/GetMarksheetCtl"})
public class GetMarksheetCtl extends BaseCtl {

	private static Logger log = Logger.getLogger(GetMarksheetCtl.class);

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

        log.debug("GetMarksheetCTL Method validate Started");

        boolean pass = true;

        if (DataValidator.isNull(request.getParameter("rollNo"))) {
            request.setAttribute("rollNo",
                    PropertyReader.getValue("error.require", "Roll Number"));
            pass = false;
        }

        log.debug("GetMarksheetCTL Method validate Ended");

        return pass;
    }

    /**
     * Populates MarksheetBean object from request parameters
     * 
     * @param request:
     * 					HttpServletRequest object
     * @return bean:
     * 				MarksheetBean object
     */
    @Override
    protected BaseBean populateBean(HttpServletRequest request) {

        log.debug("GetMarksheetCtl Method populatebean Started");

        MarksheetBean bean = new MarksheetBean();

        bean.setId(DataUtility.getLong(request.getParameter("id")));

        bean.setRollNo(DataUtility.getString(request.getParameter("rollNo")));

        bean.setName(DataUtility.getString(request.getParameter("name")));

        bean.setPhysics(DataUtility.getInt(request.getParameter("physics")));

        bean.setChemistry(DataUtility.getInt(request.getParameter("chemistry")));

        bean.setMaths(DataUtility.getInt(request.getParameter("maths")));

        log.debug("GetMarksheetCtl Method populatebean Ended");

        return bean;
    }

    /**
     * Display Get Marksheet Form
     * 
     * @param request:
     * 					HttpServletRequest object
     * @param response:
     * 					HttpServletResponse object
     * @throws ServletException
     * @throws IOException
     * 
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
     * 
     */
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        log.debug("GetMarksheetCtl Method doGet Started");
        String op = DataUtility.getString(request.getParameter("operation"));

        // get model
        MarksheetModel model = new MarksheetModel();

        MarksheetBean bean = (MarksheetBean) populateBean(request);

        long id = DataUtility.getLong(request.getParameter("id"));

        if (OP_GO.equalsIgnoreCase(op)) {

            try {
                bean = model.findByRollNo(bean.getRollNo());
                if (bean != null) {
                    ServletUtility.setBean(bean, request);
                } else {
                    ServletUtility.setErrorMessage("RollNo does not exist",
                            request);
                }
            } catch (ApplicationException e) {
                log.error(e);
                ServletUtility.handleException(e, request, response);
                return;
            }

        }else if(OP_RESET.equalsIgnoreCase(op)) {
        	ServletUtility.redirect(ORSView.GET_MARKSHEET_CTL, request, response);
        	return;
        }
        ServletUtility.forward(getView(), request, response);
        log.debug("MarksheetCtl Method doGet Ended");
    }

    
    /**
     * Returns the VIEW page of GetMarksheetCtl
     * 
     * @return GetMarksheetView.jsp:
     * 								View page of GetMarksheetCtl
     */
    @Override
    protected String getView() {
        return ORSView.GET_MARKSHEET_VIEW;
    }

}