package com.bookstore.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

/**
 * @author yhf
 * @classname IndexController
 **/
@Controller
public class IndexController {
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String customerIndex() {
        return "customers/Home/index";
    }

    @RequestMapping(value = "/admins", method = RequestMethod.GET)
    public String adminIndex() {
        return "admins/index";
    }

    @RequestMapping(value = "/admins/login", method = RequestMethod.GET)
    public String adminToLogin() {
        return "admins/page/login/login";
    }
}
