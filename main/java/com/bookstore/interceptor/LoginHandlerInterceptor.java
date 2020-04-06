package com.bookstore.interceptor;


import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

@Component
public class LoginHandlerInterceptor implements HandlerInterceptor {
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        Object role = request.getSession().getAttribute("role");
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        Object role = request.getSession().getAttribute("role");
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Object role = request.getSession().getAttribute("role");
        if (role == null) {
            request.getRequestDispatcher("/c/login").forward(request, response);
            return false;
        }
        if (request.getRequestURI().indexOf("/admins") != -1 && role.equals("customer")) {
            request.getRequestDispatcher("/c/login").forward(request, response);
            return false;
        }
        return true;
    }

}
