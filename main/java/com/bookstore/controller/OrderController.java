package com.bookstore.controller;

import com.bookstore.bean.Msg;
import com.bookstore.bean.Order;
import com.bookstore.service.*;
import com.sun.org.apache.xpath.internal.operations.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/orders")
public class OrderController {
    @Autowired
    CategoryService categoryService;
    @Autowired
    BookService bookService;
    @Autowired
    CustomerService customerService;
    @Autowired
    AddressService addressService;
    @Autowired
    OrderService orderService;

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Map add(@RequestBody Map<String,String> map,
                         HttpServletRequest request) {
        Map<String, Object> res = new HashMap<>();
        String books = map.get("books").substring(1);
        Order order = new Order();
        order.setBooks(books);
        order.setTotal(new BigDecimal(map.get("total")));
        order.setAddressId(Long.valueOf(map.get("addressId")));
        order.setCustomerId((Long) request.getSession().getAttribute("userId"));
        order.setStatus("未发货");
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
        String date = df.format(new Date());
        order.setOrderNumber(date + order.getCustomerId());
        res.put("code", orderService.insertSelective(order));
        return res;
    }

    @RequestMapping(value = "/del", method = RequestMethod.POST)
    @ResponseBody
    public Map del(@RequestBody Order order) {
        Map<String, Object> res = new HashMap<>();
        res.put("code", orderService.deleteByPrimaryKey(order.getId()));
        return res;
    }

    @RequestMapping(value = "/finish", method = RequestMethod.POST)
    @ResponseBody
    public Map finish(@RequestBody Order order) {
        Map<String, Object> res = new HashMap<>();
        order = orderService.selectByPrimaryKey(order.getId());
        order.setStatus("已完结");
        res.put("code", orderService.updateByPrimaryKeySelective(order));
        return res;
    }
}
