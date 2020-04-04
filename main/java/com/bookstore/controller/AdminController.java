package com.bookstore.controller;

import com.bookstore.bean.Admin;
import com.bookstore.service.AdminService;
import com.bookstore.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/admins")
public class AdminController {
    @Autowired
    AdminService adminService;
    @Autowired
    CustomerService customerService;
    @RequestMapping(value = "/reg", method = RequestMethod.POST)
    @ResponseBody
    public Map reg(@RequestBody Admin admin) {
        Map<String, Object> map = new HashMap<>();
        map.put("code", adminService.insertSelective(admin));
        return map;
    }
}
