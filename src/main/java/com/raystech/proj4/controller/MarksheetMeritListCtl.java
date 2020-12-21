package com.raystech.proj4.controller;

import com.raystech.proj4.bean.BaseBean;
import com.raystech.proj4.bean.MarksheetBean;
import com.raystech.proj4.exception.ApplicationException;
import com.raystech.proj4.model.MarksheetModel;
import com.raystech.proj4.util.DataUtility;
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
 * Marksheet Merit List functionality Controller. Performance operation of
 * Marksheet Merit List
 * 
 * @author SunilOS
 * @version 1.0
 * @Copyright (c) SunilOS
 */
@ WebServlet(name="MarksheetMeritListCtl",urlPatterns={"/ctl/MarksheetMeritListCtl"})
public class MarksheetMeritListCtl extends BaseCtl {

    private static Logger log = Logger.getLogger(MarksheetMeritListCtl.class);

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
        MarksheetBean bean = new MarksheetBean();

        return bean;
    }

    /**
     * Display Marksheet Merit List
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

        log.debug("MarksheetMeritListCtl doGet Start");

        int pageNo = 1;

        int pageSize = DataUtility.getInt(PropertyReader.getValue("page.size"));

        MarksheetBean bean = (MarksheetBean) populateBean(request);

        String op = DataUtility.getString(request.getParameter("operation"));

        MarksheetModel model = new MarksheetModel();
        List list = null;
        try {
            list = model.getMeritList(pageNo, pageSize);
            ServletUtility.setList(list, request);
            if (list == null || list.size() == 0) {
                ServletUtility.setErrorMessage("No record found ", request);
            }
            ServletUtility.setList(list, request);
            ServletUtility.setPageNo(pageNo, request);
            ServletUtility.setPageSize(pageSize, request);
            ServletUtility.forward(ORSView.MARKSHEET_MERIT_LIST_VIEW, request,
                    response);
        } catch (ApplicationException e) {
            log.error(e);
            ServletUtility.handleException(e, request, response);
            return;
        }
        log.debug("MarksheetMeritListCtl doGet End");
    }

    /**
     * Contains Submit logics
     * 
     * @param request:
     * 					HttpServletRequest object
     * @param response:
     * 					HttpServletResonse object
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        log.debug("MarksheetMeritListCtl doGet Start");
        List list = null;
        int pageNo = DataUtility.getInt(request.getParameter("pageNo"));
        int pageSize = DataUtility.getInt(request.getParameter("pageSize"));
        pageNo = (pageNo == 0) ? 1 : pageNo;
        pageSize = (pageSize == 0) ? DataUtility.getInt(PropertyReader
                .getValue("page.size")) : pageSize;
        MarksheetBean bean = (MarksheetBean) populateBean(request);
        String op = DataUtility.getString(request.getParameter("operation"));
        MarksheetModel model = new MarksheetModel();
        try {
            if (OP_BACK.equalsIgnoreCase(op)) {
                ServletUtility.redirect(ORSView.WELCOME_CTL, request, response);
                return;
            }
            list = model.getMeritList(pageNo, pageSize);
            ServletUtility.setList(list, request);
            if (list == null || list.size() == 0) {
                ServletUtility.setErrorMessage("No record found ", request);
            }
            ServletUtility.setList(list, request);
            ServletUtility.setPageNo(pageNo, request);
            ServletUtility.setPageSize(pageSize, request);
            ServletUtility.forward(ORSView.MARKSHEET_MERIT_LIST_VIEW, request,
                    response);
        } catch (ApplicationException e) {
            log.error(e);
            ServletUtility.handleException(e, request, response);
            return;
        }
        log.debug("MarksheetMeritListCtl doPost End");
    }

    /**
     * Return the view page of MarksheetMeritListCtl
     * 
     * @return MarksheetMeritListView.jsp:
     * 										View page of MarksheetMeritListCtl
     */
    @Override
    protected String getView() {
        return ORSView.MARKSHEET_MERIT_LIST_VIEW;
    }
}