package com.raystech.proj4.controller;

import com.raystech.proj4.bean.BaseBean;
import com.raystech.proj4.bean.UserBean;
import com.raystech.proj4.exception.ApplicationException;
import com.raystech.proj4.model.RoleModel;
import com.raystech.proj4.model.UserModel;
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
 * User List functionality Controller. Performs operation for list, search and
 * delete operations of User
 * 
 * @author SunilOS
 * @version 1.0
 * @Copyright (c) SunilOS
 */
@ WebServlet(name="UserListCtl",urlPatterns={"/ctl/UserListCtl"})
public class UserListCtl extends BaseCtl {
    private static Logger log = Logger.getLogger(UserListCtl.class);
    
    
    /**
     * Loads list and other data required to display at HTML form
     * 
     * @param request:
     * 					HttpServletRequest object
     */
    @Override
    protected void preload(HttpServletRequest request) {
    	RoleModel roleModel = new RoleModel();
    	try {
			List roleList = roleModel.list();
			request.setAttribute("rolelist", roleList);
		} catch (ApplicationException e) {
			e.printStackTrace();
		}
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
        UserBean bean = new UserBean();

        bean.setFirstName(DataUtility.getString(request
                .getParameter("firstName")));

        bean.setLastName(DataUtility.getString(request.getParameter("lastName")));

        bean.setLogin(DataUtility.getString(request.getParameter("login")));
        
        bean.setRoleId(DataUtility.getLong(request.getParameter("roleId")));

        return bean;
    }

    /**
     * Display User List
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
        log.debug("UserListCtl doGet Start");
        List list = null;
        int pageNo = 1;
        int pageSize = DataUtility.getInt(PropertyReader.getValue("page.size"));
        UserBean bean = (UserBean) populateBean(request);
        String op = DataUtility.getString(request.getParameter("operation"));
        // get the selected checkbox ids array for delete list
        UserModel model = new UserModel();
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
        log.debug("UserListCtl doPOst End");
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
        log.debug("UserListCtl doPost Start");
        
        List list = null;
        int pageNo = DataUtility.getInt(request.getParameter("pageNo"));
        int pageSize = DataUtility.getInt(request.getParameter("pageSize"));
        pageNo = (pageNo == 0) ? 1 : pageNo;
        pageSize = (pageSize == 0) ? DataUtility.getInt(PropertyReader
                .getValue("page.size")) : pageSize;
        UserBean bean = (UserBean) populateBean(request);
        String op = DataUtility.getString(request.getParameter("operation"));
        // get the selected checkbox ids array for delete list
        String[] ids = request.getParameterValues("chk_1");
        UserModel model = new UserModel();
        try {

            if (OP_SEARCH.equalsIgnoreCase(op) || OP_NEXT.equalsIgnoreCase(op)
                    || OP_PREVIOUS.equalsIgnoreCase(op)) {

                if (OP_SEARCH.equalsIgnoreCase(op)) {
                    pageNo = 1;
                } else if (OP_NEXT.equalsIgnoreCase(op)) {
                    pageNo++;
                } else if (OP_PREVIOUS.equalsIgnoreCase(op) && pageNo > 1) {
                    pageNo--;
                }

            } else if (OP_NEW.equalsIgnoreCase(op)) {
                ServletUtility.redirect(ORSView.USER_CTL, request, response);
                return;
            } else if (OP_DELETE.equalsIgnoreCase(op)) {
                pageNo = 1;
                if (ids != null && ids.length > 0) {
                    UserBean deletebean = new UserBean();
                    for (String id : ids) {
                        deletebean.setId(DataUtility.getInt(id));
                        model.delete(deletebean);
                    }
                    ServletUtility.setSuccessMessage("Record deleted successfully", request);
                } else {
                    ServletUtility.setErrorMessage(
                            "Select at least one record", request);
                }
            }else if(OP_RESET.equalsIgnoreCase(op)||OP_BACK.equalsIgnoreCase(op)) {
            	ServletUtility.redirect(ORSView.USER_LIST_CTL, request, response);
            	return;
            }
            
            list = model.search(bean, pageNo, pageSize);
            ServletUtility.setList(list, request);
            if (list == null || list.size() == 0 && !OP_DELETE.equalsIgnoreCase(op) ) {
                ServletUtility.setErrorMessage("No record found ", request);
            }
            ServletUtility.setBean(bean, request);
            ServletUtility.setList(list, request);
            ServletUtility.setPageNo(pageNo, request);
            ServletUtility.setPageSize(pageSize, request);
            ServletUtility.forward(getView(), request, response);

        } catch (ApplicationException e) {
            log.error(e);
            ServletUtility.handleException(e, request, response);
            return;
        }
        log.debug("UserListCtl doGet End");
    }

    /**
     * Returns the view page of UserListCtl
     * 
     * @return UserListView.jsp:
     * 							View page of UserListCtl
     */
    @Override
    protected String getView() {
        return ORSView.USER_LIST_VIEW;
    }

}
