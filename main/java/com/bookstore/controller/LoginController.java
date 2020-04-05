package com.bookstore.controller;

import com.bookstore.bean.Admin;
import com.bookstore.bean.Customer;
import com.bookstore.service.AdminService;
import com.bookstore.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/login")
public class LoginController {

    @Autowired
    CustomerService customerService;
    @Autowired
    AdminService adminService;

    @RequestMapping(value = "/customers", method = RequestMethod.POST)
    @ResponseBody
    public Map customersLogin(@RequestBody Customer customer,
                              HttpServletRequest request) {
        Customer customer1;
        Map<String, Object> map = new HashMap<>();
        if ((customer1 = customerService.selectByName(customer.getName())) != null &&
                customer1.getPwd().equals(DigestUtils.md5DigestAsHex(customer.getPwd().getBytes()))) {
            map.put("code", 1);
            map.put("data", customer1);
            HttpSession session = request.getSession();
            session.setAttribute("role","customer");
            session.setAttribute("userId", customer1.getId());
        } else {
            map.put("code", 0);
        }
        return map;
    }

    @RequestMapping(value = "/admins", method = RequestMethod.POST)
    @ResponseBody
    public Map adminsLogin(@RequestBody Admin admin, HttpServletRequest request) {
        Admin admin1;
        Map<String, Object> map = new HashMap<>();
        if ((admin1 = adminService.selectByName(admin.getName())) != null &&
                admin1.getPwd().equals(DigestUtils.md5DigestAsHex(admin.getPwd().getBytes()))) {
            map.put("code", 1);
            map.put("data", admin1);
            HttpSession session = request.getSession();
            session.setAttribute("role","admin");
            session.setAttribute("userId",admin1.getId());
        } else {
            map.put("code", 0);
        }
        return map;
    }
}
