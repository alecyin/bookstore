package com.bookstore.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bookstore.bean.*;
import com.bookstore.service.*;
import com.sun.org.apache.xpath.internal.operations.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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
        order.setFinish(new Date());
        order.setStatus("已完结");
        updateSales(order);
        res.put("code", orderService.updateByPrimaryKeySelective(order));
        return res;
    }

    public void updateSales(Order order) {
        String[] books = orderService.selectByPrimaryKey(order.getId()).getBooks().split("\\|");
        for (String str : books) {
            int amount = Integer.valueOf(str.split("-")[1]);
            Book book = bookService.selectByPrimaryKey(Long.valueOf(str.split("-")[0]));
            book.setSales(book.getSales() == null ? amount : book.getSales() + amount);
            bookService.updateByPrimaryKeySelective(book);
        }
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ResponseBody
    public void edit(@RequestBody Order order) {
        if (!orderService.selectByPrimaryKey(order.getId()).getStatus().equals("已完结")
                && order.getStatus().equals("已完结")) {
            order.setFinish(new Date());
            updateSales(order);
        }
        orderService.updateByPrimaryKeySelective(order);
    }



    @RequestMapping(value = "/orderEdit/{id}", method = RequestMethod.GET)
    public ModelAndView categoryEdit(@PathVariable("id") Long id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("admins/page/order/orderEdit");
        mv.addObject("oldStatus", orderService.selectByPrimaryKey(id).getStatus());
        return mv;
    }

    @RequestMapping(value = "/del", method = RequestMethod.GET)
    @ResponseBody
    public void del(@RequestParam("ids") String ids) {
        String[] strs = ids.split("-");
        for (String str:strs) {
            if (!StringUtils.isEmpty(str))
                orderService.deleteByPrimaryKey(Long.valueOf(str));
        }
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list() {
        return "admins/page/order/orderList";
    }

    @RequestMapping(value = "/detail/{id}", method = RequestMethod.GET)
    public ModelAndView detail(@PathVariable("id") Long id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("admins/page/order/orderDetail");
        mv.addObject("id", id);
        return mv;
    }

    @RequestMapping(value = "/getDetail/{id}", method = RequestMethod.GET)
    @ResponseBody
    public String getDetail(@PathVariable("id") Long id) {
        JSONObject jsonObject = new JSONObject();
        Order order = orderService.selectByPrimaryKey(id);
        JSONArray jsonArray = new JSONArray();
        String[] bookStrs = order.getBooks().split("\\|");
        int amountAll = 0;
        for (String str : bookStrs) {
            Long bookId = Long.valueOf(str.split("-")[0]);
            Book book = bookService.selectByPrimaryKey(bookId);
            JSONObject jsonObject1 = new JSONObject();
            jsonObject1.put("name", book.getName());
            jsonObject1.put("author", book.getAuthor());
            jsonObject1.put("price", book.getPrice());
            jsonObject1.put("isbn", book.getIsbn());
            jsonObject1.put("publish", book.getPublish());
            jsonObject1.put("pubdate", book.getPubdate());
            jsonObject1.put("categoryName", categoryService.selectByPrimaryKey(book.getCategoryId()).getName());
            jsonObject1.put("amount", Long.valueOf(str.split("-")[1]));
            amountAll += Integer.valueOf(str.split("-")[1]);
            jsonObject1.put("thumbnail", book.getThumbnail());
            jsonObject1.put("smallCnt", book.getPrice().multiply(new BigDecimal(str.split("-")[1])));
            jsonArray.add(jsonObject1);
        }
        jsonObject.put("code", 0);
        jsonObject.put("data", jsonArray);
        jsonObject.put("count", jsonArray.size());
        return jsonObject.toJSONString();
    }

    @RequestMapping(value = "/table-data", method = RequestMethod.GET)
    @ResponseBody
    public String listData(
            @RequestParam(value = "key", required = false) String keyword,
            @RequestParam("page") int page,
            @RequestParam("limit") int limit) {
        //订单号，订单状态，顾客名称，收货地址，总价格，Id
        JSONObject jsonObject = new JSONObject();
        Map<String, Object> map = new HashMap<>();
        map.put("keyword", keyword);
        map.put("currentIndex", (page - 1) * limit);
        map.put("pageSize", limit);
        List<Order> oList = orderService.listOrdersByPage(map);
        jsonObject.put("code", 0);
        JSONArray jsonArray = new JSONArray();
        for (Order order : oList) {
            JSONObject jsonObject1 = new JSONObject();
            jsonObject1.put("id", order.getId());
            jsonObject1.put("total", order.getTotal());
            jsonObject1.put("status", order.getStatus());
            jsonObject1.put("orderNumber", order.getOrderNumber());
            jsonObject1.put("finish", order.getFinish());
            Customer customer = customerService.selectByPrimaryKey(order.getCustomerId());
            jsonObject1.put("customerName", customer.getName());
            Address address = addressService.selectByPrimaryKey(order.getAddressId());
            jsonObject1.put("address",  "联系人：" + address.getContacts() + "-手机号：" + address.getPhone()
                    + "-详细地址：" + address.getDetail());
            jsonArray.add(jsonObject1);
        }
        jsonObject.put("data", jsonArray);
        jsonObject.put("count", orderService.listOrders().size());
        return jsonObject.toJSONString();
    }
}
