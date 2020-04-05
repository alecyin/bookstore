package com.bookstore.controller;

import com.bookstore.bean.Address;
import com.bookstore.bean.Category;
import com.bookstore.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/addresses")
public class AddressController {

    @Autowired
    AddressService addressService;

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Map add(@RequestBody Address address, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();
        address.setCustomerId((Long) request.getSession().getAttribute("userId"));
        if (addressService.listAddressByCustomerId(address.getCustomerId()).size() > 2) {
            map.put("code", 0);
        } else {
            map.put("code", addressService.insertSelective(address));
        }
        return map;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ResponseBody
    public Map edit(@RequestBody Address address) {
        Map<String, Object> map = new HashMap<>();
        map.put("code", addressService.updateByPrimaryKeySelective(address));
        return map;
    }

    @RequestMapping(value = "/del", method = RequestMethod.POST)
    @ResponseBody
    public Map del(@RequestBody Address address) {
        Map<String, Object> map = new HashMap<>();
        map.put("code", addressService.deleteByPrimaryKey(address.getId()));
        return map;
    }
}
