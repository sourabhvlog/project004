package com.raystech.proj4.controller;

import com.raystech.proj4.bean.BaseBean;
import com.raystech.proj4.bean.MarksheetBean;
import com.raystech.proj4.exception.ApplicationException;
import com.raystech.proj4.exception.DuplicateRecordException;
import com.raystech.proj4.model.MarksheetModel;
import com.raystech.proj4.model.StudentModel;
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
 * Marksheet functionality Controller. Performs operation for add, update,
 * delete and get Marksheet
 * 
 * @author SunilOS
 * @version 1.0
 * @Copyright (c) SunilOS
 */
@ WebServlet(name="MarksheetCtl",urlPatterns={"/ctl/MarksheetCtl"})
public class MarksheetCtl extends BaseCtl {

    private static Logger log = Logger.getLogger(MarksheetCtl.class);

    
    /**
     * Loads list and other data required to display at HTML form
     * 
     * @param request:
     * 					HttpServletRequest object
     */
    @Override
    protected void preload(HttpServletRequest request) {
        StudentModel model = new StudentModel();
        try {
            List l = model.list();
            request.setAttribute("studentList", l);
        } catch (ApplicationException e) {
            log.error(e);
        }

    }

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

        log.debug("MarksheetCtl Method validate Started");

        boolean pass = true;

        if (DataValidator.isNull(request.getParameter("rollNo"))) {
            request.setAttribute("rollNo", PropertyReader.getValue("error.require", "Roll Number"));
            pass = false;
        }else if(!DataValidator.isRollNo(request.getParameter("rollNo"))) {
        	request.setAttribute("rollNo", PropertyReader.getValue("error.roll", "Roll Number"));
        	pass = false;
        }
        
        if(DataUtility.getInt(request.getParameter("studentId"))==0) {
        	request.setAttribute("stname", PropertyReader.getValue("error.select", "Student name"));
        	pass = false;
        }
        
        if (DataValidator.isNull(request.getParameter("physics"))) {
        	request.setAttribute("physics", PropertyReader.getValue("error.require", "Physics marks"));
        	pass = false;
        }else if(DataUtility.getInt(request.getParameter("physics"))>100) {
        	request.setAttribute("physics", "Marks can not be more than 100");
        	pass = false;
        }
        
        if (DataValidator.isNull(request.getParameter("chemistry"))) {
        	request.setAttribute("chemistry", PropertyReader.getValue("error.require", "Chemistry marks"));
        	pass = false;
        }else if(DataUtility.getInt(request.getParameter("chemistry"))>100) {
        	request.setAttribute("chemistry", "Marks can not be more than 100");
        	pass = false;
        }

        if (DataValidator.isNull(request.getParameter("maths"))) {
        	request.setAttribute("maths", PropertyReader.getValue("error.require", "Maths marks"));
        	pass = false;
        }else if(DataUtility.getInt(request.getParameter("maths"))>100) {
        	request.setAttribute("maths", "Marks can not be more than 100");
        	pass = false;
        }
        

        log.debug("MarksheetCtl Method validate Ended");

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

        log.debug("MarksheetCtl Method populatebean Started");

        MarksheetBean bean = new MarksheetBean();

        bean.setId(DataUtility.getLong(request.getParameter("id")));

        bean.setRollNo(DataUtility.getString(request.getParameter("rollNo")));

        bean.setName(DataUtility.getString(request.getParameter("name")));
        
        if(DataValidator.isNotNull(request.getParameter("physics"))) {
        bean.setPhysics(DataUtility.getInt(request.getParameter("physics")));
        }

        if(DataValidator.isNotNull(request.getParameter("chemistry"))) {
        bean.setChemistry(DataUtility.getInt(request.getParameter("chemistry")));
        }
        
        if(DataValidator.isNotNull(request.getParameter("maths"))) {
        bean.setMaths(DataUtility.getInt(request.getParameter("maths")));
        }

        bean.setStudentId(DataUtility.getLong(request.getParameter("studentId")));

        populateDTO(bean, request);

        System.out.println("Population done");

        log.debug("MarksheetCtl Method populatebean Ended");

        return bean;
    }

    /**
     * Display Add Marksheet and Update Marksheet form
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
        log.debug("MarksheetCtl Method doGet Started");

        String op = DataUtility.getString(request.getParameter("operation"));
        MarksheetModel model = new MarksheetModel();
        long id = DataUtility.getLong(request.getParameter("id"));
        if (id > 0) {
            MarksheetBean bean;
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
        log.debug("MarksheetCtl Method doGet Ended");
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

        log.debug("MarksheetCtl Method doPost Started");

        String op = DataUtility.getString(request.getParameter("operation"));
        // get model
        MarksheetModel model = new MarksheetModel();

        long id = DataUtility.getLong(request.getParameter("id"));

        if (OP_SAVE.equalsIgnoreCase(op) || OP_UPDATE.equalsIgnoreCase(op)) {

            MarksheetBean bean = (MarksheetBean) populateBean(request);
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
                ServletUtility.setErrorMessage("Roll no already exists",
                        request);
            }

        } else if (OP_DELETE.equalsIgnoreCase(op)) {

            MarksheetBean bean = (MarksheetBean) populateBean(request);
            System.out.println("in try");
            try {
                model.delete(bean);
                ServletUtility.redirect(ORSView.MARKSHEET_LIST_CTL, request,
                        response);
                System.out.println("in try");
                return;
            } catch (ApplicationException e) {
                System.out.println("in catch");
                log.error(e);
                ServletUtility.handleException(e, request, response);
                return;
            }

        } else if (OP_CANCEL.equalsIgnoreCase(op)) {

            ServletUtility.redirect(ORSView.MARKSHEET_LIST_CTL, request,
                    response);
            return;

        }
        ServletUtility.forward(getView(), request, response);

        log.debug("MarksheetCtl Method doPost Ended");
    }

    /**
     * Returns the VIEW page of MarksheetCtl
     * 
     * @return MarksheetView.jsp:
     * 							View page of MarksheetCtl
     */
    @Override
    protected String getView() {
        return ORSView.MARKSHEET_VIEW;
    }

}
