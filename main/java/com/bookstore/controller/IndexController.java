package com.bookstore.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bookstore.bean.*;
import com.bookstore.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.*;

/**
 * @author yhf
 * @classname IndexController
 **/
@Controller
public class IndexController {

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

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView customerIndex() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("customers/Home/index");
        List<Category> caList = categoryService.listCategories();
        List<Book> bList = bookService.listBooksByCategory(caList.get(0).getId());
        mv.addObject("caList", caList.size() > 9 ? caList.subList(0,9) : caList);
        mv.addObject("bList", bList.size() > 12 ? bList.subList(0,12) : bList);
        mv.addObject("actived", caList.get(0).getId());
        return mv;
    }

    @RequestMapping(value = "/r/{categoryId}", method = RequestMethod.GET)
    public ModelAndView customerCategoryIndex(@PathVariable("categoryId") Long categoryId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("customers/Home/index");
        List<Category> caList = categoryService.listCategories();
        List<Book> bList = bookService.listBooksByCategory(categoryId);
        mv.addObject("caList", caList.size() > 9 ? caList.subList(0,9) : caList);
        mv.addObject("bList", bList.size() > 12 ? bList.subList(0,12) : bList);
        mv.addObject("actived", categoryId);
        return mv;
    }

    @RequestMapping(value = "/r/{categoryId}/p/{page}", method = RequestMethod.GET)
    public ModelAndView customerCategoryPageIndex(@PathVariable("categoryId") Long categoryId,
                                                  @PathVariable("page") int page) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("customers/Home/index");
        List<Category> caList = categoryService.listCategories();
        List<Book> bList = bookService.listBooksByCategory(categoryId);
        mv.addObject("caList", caList.size() > 9 ? caList.subList(0,9) : caList);
        mv.addObject("bList",
                bList.size() > (page - 1) * 12 + 12?
                        bList.subList((page - 1) * 12, (page - 1) * 12 + 12) :
                            bList.size() > (page - 1) * 12 ? bList.subList((page - 1) * 12, bList.size()) :
                               null );
        mv.addObject("actived", categoryId);
        return mv;
    }

    @RequestMapping(value = "/more/{categoryId}", method = RequestMethod.GET)
    public ModelAndView customerMoreIndex(@PathVariable("categoryId") Long categoryId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("customers/Home/more");
        List<Category> caList = categoryService.listCategories();
        List<Book> bList = bookService.listBooksByCategory(categoryId);
        mv.addObject("bList", bList);
        mv.addObject("caList", caList);
        mv.addObject("actived", categoryId);
        return mv;
    }

    @RequestMapping(value = "/more", method = RequestMethod.GET)
    public ModelAndView customerMore() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("customers/Home/more");
        List<Category> caList = categoryService.listCategories();
        List<Book> bList = bookService.listBooksByCategory(caList.get(0).getId());
        mv.addObject("bList", bList);
        mv.addObject("caList", caList);
        mv.addObject("actived", caList.get(0).getId());
        return mv;
    }

    @RequestMapping(value = "/more/{categoryId}/keyword/{keyword}", method = RequestMethod.GET)
    public ModelAndView customerMoreKeyIndex(@PathVariable("categoryId") Long categoryId,
                                             @PathVariable("keyword") String keyword) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("customers/Home/more");
        List<Category> caList = categoryService.listCategories();
        List<Book> bList = bookService.listBooks();
        List<Book> res = new ArrayList<>();
        for (Book book : bList) {
            if (book.getName().indexOf(keyword) != -1 ||
                    book.getAuthor().indexOf(keyword) != -1 ||
                    book.getIsbn().indexOf(keyword) != -1 ||
                    (book.getPublish() != null && book.getPublish().indexOf(keyword) != -1)) {
                    res.add(book);
            }
        }
        mv.addObject("bList", res);
        mv.addObject("caList", caList);
        mv.addObject("actived", -1);
        return mv;
    }

    @RequestMapping(value = "/admins", method = RequestMethod.GET)
    public String adminIndex() {
        return "admins/index";
    }

    @RequestMapping(value = "/admins/login", method = RequestMethod.GET)
    public String adminToLogin() {
        return "admins/page/login/login";
    }

    @RequestMapping(value = "/c/login", method = RequestMethod.GET)
    public String cIndex() {
        return "customers/Home/login";
    }

    @RequestMapping(value = "/c/reg", method = RequestMethod.GET)
    public String cToLogin() {
        return "customers/Home/register";
    }

    @RequestMapping(value = "/c/info", method = RequestMethod.GET)
    public ModelAndView cToInfo(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        Customer customer = customerService
                .selectByPrimaryKey((Long) request.getSession().getAttribute("userId"));
        mv.setViewName("customers/Home/userInfo");
        mv.addObject("addressList", addressService.listAddressByCustomerId(customer.getId()));
        return mv;
    }

    @RequestMapping(value = "/c/editPass", method = RequestMethod.POST)
    @ResponseBody
    public Map cEditPass(@RequestBody Map map1, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();
        Customer customer = customerService
                .selectByPrimaryKey((Long) request.getSession().getAttribute("userId"));
        if (!customer.getPwd().equals(DigestUtils.md5DigestAsHex(((String)map1.get("oldPass")).getBytes()))) {
            map.put("code", 0);
        } else {
            customer.setPwd(DigestUtils.md5DigestAsHex(
                    ((String)map1.get("newPass")).getBytes()
            ));
            map.put("code", customerService.updateByPrimaryKeySelective(customer));
        }
        return map;
    }

    @RequestMapping(value = "/c/cart", method = RequestMethod.GET)
    public ModelAndView toCart(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("customers/Home/cart");
        mv.addObject("addressList",
                addressService.listAddressByCustomerId((Long) request.getSession().getAttribute("userId")));
        return mv;
    }

    @RequestMapping(value = "/c/order", method = RequestMethod.GET)
    public ModelAndView toOrder(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("customers/Home/order");
        mv.addObject("orderList",
                orderService.listOrdersByCustomerId((Long) request.getSession().getAttribute("userId")));
        return mv;
    }

    @RequestMapping(value = "/c/orderInfo/{orderId}", method = RequestMethod.GET)
    public ModelAndView toOrderInfo(@PathVariable("orderId") Long orderId,
                                    HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("customers/Home/orderInfo");
        Order order = orderService.selectByPrimaryKey(orderId);
        JSONObject res = new JSONObject();
        res.put("orderNumber", order.getOrderNumber());
        res.put("finish", order.getFinish());
        res.put("status", order.getStatus());
        res.put("id", order.getId());
        res.put("total", order.getTotal());
        Address address = addressService.selectByPrimaryKey(order.getAddressId());
        res.put("contacts", address.getContacts());
        res.put("phone", address.getPhone());
        res.put("detail", address.getDetail());
        JSONArray jsonArray = new JSONArray();
        String[] bookStrs = order.getBooks().split("\\|");
        int amountAll = 0;
        for (String str : bookStrs) {
            Long bookId = Long.valueOf(str.split("-")[0]);
            Book book = bookService.selectByPrimaryKey(bookId);
            JSONObject jsonObject1 = new JSONObject();
            jsonObject1.put("bookName", book.getName());
            jsonObject1.put("price", book.getPrice());
            jsonObject1.put("amount", Long.valueOf(str.split("-")[1]));
            amountAll += Integer.valueOf(str.split("-")[1]);
            jsonObject1.put("smallCnt", book.getPrice().multiply(new BigDecimal(str.split("-")[1])));
            jsonArray.add(jsonObject1);
        }
        res.put("amountAll", amountAll);
        res.put("book", jsonArray);
        mv.addObject("orderDetail",res);
        return mv;
    }

    @RequestMapping(value = "/c/recommend", method = RequestMethod.GET)
    public ModelAndView recommend(HttpServletRequest request) {
        List<Order> orderList = orderService.
                listOrdersByCustomerId((Long) request.getSession().getAttribute("userId"));
        Map<Long, Integer> map = new HashMap<>();
        if (orderList != null && orderList.size() != 0) {
            for (Order order : orderList) {
                String[] books = order.getBooks().split("\\|");
                for (String str : books) {
                    Long categoryId = bookService.
                            selectByPrimaryKey(Long.valueOf(str.split("-")[0])).getCategoryId();
                    int amount = Integer.valueOf(str.split("-")[1]);
                    map.put(categoryId, map.getOrDefault(categoryId, 0) + amount);
                }
            }
        } else {
            for (Category category: categoryService.listCategories()) {
                map.put(category.getId(), 0);
            }
        }
        List<Map.Entry<Long, Integer>> list = new ArrayList<>(map.entrySet());
        Collections.sort(list, (o1, o2) -> o2.getValue().compareTo(o1.getValue()));
        JSONArray jsonArray = new JSONArray();
        for (Map.Entry<Long, Integer> e: list) {
            Long categoryId = e.getKey();
            for (Book book: bookService.listBooksByCategory(categoryId)) {
                JSONObject jsonObject1 = new JSONObject();
                jsonObject1.put("book", book);
                jsonObject1.put("categoryName", categoryService.selectByPrimaryKey(book.getCategoryId()).getName());
                jsonArray.add(jsonObject1);
            }
        }
        ModelAndView mv = new ModelAndView();
        mv.setViewName("customers/Home/recommend");
        mv.addObject("recommendList", jsonArray);
        return mv;
    }

}
