
package com.raystech.proj4.controller;

import com.raystech.proj4.bean.BaseBean;
import com.raystech.proj4.bean.RoleBean;
import com.raystech.proj4.exception.ApplicationException;
import com.raystech.proj4.model.RoleModel;
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
 * Role List functionality Controller. Performs operation for list, search
 * operations of Role
 * 
 * @author SunilOS
 * @version 1.0
 * @Copyright (c) SunilOS
 */
@ WebServlet(name="RoleListCtl",urlPatterns={"/ctl/RoleListCtl"})
public class RoleListCtl extends BaseCtl {
    private static Logger log = Logger.getLogger(RoleListCtl.class);
    
    @Override
    protected void preload(HttpServletRequest request) {
    	RoleModel model = new RoleModel();
    	try {
			List roleList = model.list();
			request.setAttribute("roleList", roleList);
		} catch (ApplicationException e) {
			e.printStackTrace();
		}
    }

    /**
     * Populates RoleBean object from request parameters
     * 
     * @param request:
     * 					HttpServletRequest object
     * @return bean:
     * 				RoleBean object
     */
    @Override
    protected BaseBean populateBean(HttpServletRequest request) {
        RoleBean bean = new RoleBean();
        bean.setId(DataUtility.getLong(request.getParameter("roleId")));
        bean.setDescription(DataUtility.getString(request.getParameter("description")));

        return bean;
    }

    /**
     * Display Role List
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
        log.debug("RoleListCtl doGet Start");
        List list = null;
        int pageNo = 1;
        int pageSize = DataUtility.getInt(PropertyReader.getValue("page.size"));
        RoleBean bean = (RoleBean) populateBean(request);
        String op = DataUtility.getString(request.getParameter("operation"));
        RoleModel model = new RoleModel();
        try {
            list = model.search(bean, pageNo, pageSize);
            ServletUtility.setList(list, request);
            if (list == null || list.size() == 0) {
                ServletUtility.setErrorMessage("No record found ", request);
            }
            ServletUtility.setList(list, request);
            ServletUtility.setPageNo(pageNo, request);
            ServletUtility.setPageSize(pageSize, request);
            ServletUtility.forward(getView(), request, response);
        } catch (ApplicationException e) {
            log.error(e);
            ServletUtility.handleException(e, request, response);
            return;
        }
        log.debug("RoleListCtl doGet End");
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
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        log.debug("RoleListCtl doPost Start");
        List list = null;
        int pageNo = DataUtility.getInt(request.getParameter("pageNo"));
        int pageSize = DataUtility.getInt(request.getParameter("pageSize"));
        pageNo = (pageNo == 0) ? 1 : pageNo;
        pageSize = (pageSize == 0) ? DataUtility.getInt(PropertyReader
                .getValue("page.size")) : pageSize;
        RoleBean bean = (RoleBean) populateBean(request);
        String op = DataUtility.getString(request.getParameter("operation"));
        String[] ids = request.getParameterValues("chk_1");
        RoleModel model = new RoleModel();

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

            }else if(OP_NEW.equalsIgnoreCase(op)) {
            	ServletUtility.redirect(ORSView.ROLE_CTL, request, response);
            	return;
            }else if(OP_RESET.equalsIgnoreCase(op) || OP_BACK.equalsIgnoreCase(op)){
            	ServletUtility.redirect(ORSView.ROLE_LIST_CTL, request, response);
            	return;
            }else if (OP_DELETE.equalsIgnoreCase(op)) { 
                pageNo = 1;
                if (ids != null && ids.length > 0) {
                    RoleBean deletebean = new RoleBean();
                    for (String id : ids) {
                        deletebean.setId(DataUtility.getInt(id));
                        model.delete(deletebean);
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
        log.debug("RoleListCtl doPost End");
    }

    /**
     * Returns the view page of RoleListCtl
     * 
     * @return RoleListView.jsp:
     * 							View page of RoleListCtl
     */
    @Override
    protected String getView() {
        return ORSView.ROLE_LIST_VIEW;
    }

}