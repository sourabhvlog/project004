package com.raystech.proj4.controller;

import com.raystech.proj4.bean.BaseBean;
import com.raystech.proj4.bean.CollegeBean;
import com.raystech.proj4.exception.ApplicationException;
import com.raystech.proj4.model.CollegeModel;
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
 * College List functionality Controller. Performs operation for list, search
 * and delete operations of College
 * 
 * @author SunilOS
 * @version 1.0
 * @Copyright (c) SunilOS
 */
@ WebServlet(name="CollegeListCtl",urlPatterns={"/ctl/CollegeListCtl"})
public class CollegeListCtl extends BaseCtl {

    private static Logger log = Logger.getLogger(CollegeListCtl.class);

    /**
     * Loads list and other data required to display at HTML form
     * 
     * @param request:
     * 					HttpServletRequest object
     */
    @Override
    protected void preload(HttpServletRequest request) {
    	CollegeModel cmodel = new CollegeModel();
    	try {
			List clist = cmodel.list();
			request.setAttribute("collegeList", clist);
		} catch (ApplicationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    
    /**
     * Populates CollegeBean object from request parameters
     * 
     * @param request:
     * 					HttpServletRequest object
     * @return bean:
     * 				CollegeBean object
     */
    @Override
    protected BaseBean populateBean(HttpServletRequest request) {
        CollegeBean bean = new CollegeBean();

        bean.setId(DataUtility.getLong(request.getParameter("collegeId")));
        bean.setCity(DataUtility.getString(request.getParameter("city")));

        return bean;
    }

    /**
     * Display College list
     * 
     * @param request:
     * 					HttpServletRequest object
     * @param response:
     * 					HttpServletResponse object
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        int pageNo = 1;
        int pageSize = DataUtility.getInt(PropertyReader.getValue("page.size"));

        CollegeBean bean = (CollegeBean) populateBean(request);
        CollegeModel model = new CollegeModel();

        List list = null;

        try {
            list = model.search(bean, pageNo, pageSize);
        } catch (ApplicationException e) {
            log.error(e);
            ServletUtility.handleException(e, request, response);
            return;
        }

        if (list == null || list.size() == 0) {
            ServletUtility.setErrorMessage("No record found ", request);
        }

        ServletUtility.setList(list, request);
        ServletUtility.setPageNo(pageNo, request);
        ServletUtility.setPageSize(pageSize, request);
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
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        log.debug("CollegeListCtl doPost Start");

        List list = null;

        int pageNo = DataUtility.getInt(request.getParameter("pageNo"));
        int pageSize = DataUtility.getInt(request.getParameter("pageSize"));

        pageNo = (pageNo == 0) ? 1 : pageNo;

        pageSize = (pageSize == 0) ? DataUtility.getInt(PropertyReader
                .getValue("page.size")) : pageSize;

        CollegeBean bean = (CollegeBean) populateBean(request);

        String op = DataUtility.getString(request.getParameter("operation"));

        CollegeModel model = new CollegeModel();
        
        String[] ids = request.getParameterValues("chk_1");
        CollegeModel collegemodel = new CollegeModel();

        try {

            if (OP_SEARCH.equalsIgnoreCase(op) || "Next".equalsIgnoreCase(op)
                    || "Previous".equalsIgnoreCase(op)) {

                if (OP_SEARCH.equalsIgnoreCase(op)) {
                    pageNo = 1;
                } else if (OP_NEXT.equalsIgnoreCase(op)) {
                    pageNo++;
                } else if (OP_PREVIOUS.equalsIgnoreCase(op) && pageNo > 1) {
                    pageNo--;
                }

            }else if(OP_RESET.equalsIgnoreCase(op) || OP_BACK.equalsIgnoreCase(op)) {
            	ServletUtility.redirect(ORSView.COLLEGE_LIST_CTL, request, response);
				return;
            }else if(OP_NEW.equalsIgnoreCase(op)) {
            	ServletUtility.redirect(ORSView.COLLEGE_CTL, request, response);
            	return;
            }else if(OP_DELETE.equalsIgnoreCase(op)) {
            	pageNo = 1;
                if (ids != null && ids.length > 0) {
                    CollegeBean deletebean = new CollegeBean();
                    for (String id : ids) {
                        deletebean.setId(DataUtility.getInt(id));
                        collegemodel.delete(deletebean);
                    }
                    ServletUtility.setSuccessMessage("Record deleted successfully", request);
                } else {
                    ServletUtility.setErrorMessage(
                            "Select at least one record", request);
                }
            }
            list = model.search(bean, pageNo, pageSize);
            ServletUtility.setList(list, request);
            if (list == null || list.size() == 0 && !OP_DELETE.equalsIgnoreCase(op)) {
                ServletUtility.setErrorMessage("No record found ", request);
            }
            ServletUtility.setList(list, request);
            ServletUtility.setBean(bean, request);
            ServletUtility.setPageNo(pageNo, request);
            ServletUtility.setPageSize(pageSize, request);
            ServletUtility.forward(getView(), request, response);

        } catch (ApplicationException e) {
            log.error(e);
            ServletUtility.handleException(e, request, response);
            return;
        }
        log.debug("CollegeListCtl doGet End");
    }

    /**
     * Returns the VIEW page of CollegeListCtl
     * 
     * @return CollegeListView.jsp:
     * 								View page of CollegeListCtl
     */
    @Override
    protected String getView() {
        return ORSView.COLLEGE_LIST_VIEW;
    }
}