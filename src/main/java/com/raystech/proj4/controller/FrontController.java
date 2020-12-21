package com.raystech.proj4.controller;

import com.raystech.proj4.util.ServletUtility;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Main Controller performs session checking and logging operations before
 * calling any application controller. It prevents any user to access
 * application without login.
 * 
 * 
 * @author SunilOS
 * @version 1.0
 * @Copyright (c) SunilOS
 */
@ WebFilter(urlPatterns={"/ctl/*","/doc/*"})
public class FrontController implements Filter {

    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp,
            FilterChain chain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;

        HttpSession session = request.getSession(true);  
        

        if (session.getAttribute("user") == null) {
            request.setAttribute("message", "Session Expired..Please Re-Login..!!");
            
        	String path = request.getServletPath();
            request.setAttribute("repath", path);
            ServletUtility.forward(ORSView.LOGIN_VIEW, request, response);
        } else {
            chain.doFilter(request, response);
        }
    }

    public void init(FilterConfig conf) throws ServletException {
    }

}