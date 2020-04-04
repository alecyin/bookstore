package com.bookstore.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bookstore.bean.Address;
import com.bookstore.bean.Customer;
import com.bookstore.service.AddressService;
import com.bookstore.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/customers")
public class CustomerController {

    @Autowired
    CustomerService customerService;
    @Autowired
    AddressService addressService;
    @RequestMapping(value = "/reg", method = RequestMethod.POST)
    @ResponseBody
    public Map reg(@RequestBody Customer customer) {
        Map<String, Object> map = new HashMap<>();
        map.put("code", customerService.insertSelective(customer));
        return map;
    }

    @RequestMapping(value = "/customerAdd", method = RequestMethod.GET)
    public String customerAdd() {
        return "admins/page/customer/customerAdd";
    }

    @RequestMapping(value = "/del", method = RequestMethod.GET)
    @ResponseBody
    public void del(@RequestParam("ids") String ids) {
        String[] strs = ids.split("-");
        for (String str:strs) {
            if (!StringUtils.isEmpty(str))
                customerService.deleteByPrimaryKey(Long.valueOf(str));
        }
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ModelAndView list() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("admins/page/customer/customerList");
        mv.addObject("customerList", customerService.listCustomers());
        Map<String, Object> map = new HashMap<>();
//        map.put("code", customerService.insertSelective(customer));
        return mv;
    }

    @RequestMapping(value = "/table-data", method = RequestMethod.GET)
    @ResponseBody
    public String listData(
            @RequestParam(value = "key", required = false) String keyword,
            @RequestParam("page") int page,
            @RequestParam("limit") int limit) {
        JSONObject jsonObject = new JSONObject();
        JSONArray jsonArray = new JSONArray();
        Map<String, Object> map = new HashMap<>();
        map.put("keyword", keyword);
        map.put("currentIndex", (page - 1) * page);
        map.put("pageSize", limit);
        for (Customer customer: customerService.listCustomersByPage(map)) {
            JSONObject jsonObject1 = new JSONObject();
            jsonObject1.put("name", customer.getName());
            jsonObject1.put("id", customer.getId());
            int i = 0;
            for (Address address:addressService.listAddressByCustomerId(customer.getId())) {
                jsonObject1.put("address"+(i++), "联系人：" + address.getContacts() + "-手机号：" + address.getPhone()
                    + "-详细地址：" + address.getDetail());
            }
            jsonArray.add(jsonObject1);
        }
        jsonObject.put("code", 0);
        jsonObject.put("data", jsonArray);
        jsonObject.put("count", jsonArray.size());
        return jsonObject.toJSONString();
    }

}
