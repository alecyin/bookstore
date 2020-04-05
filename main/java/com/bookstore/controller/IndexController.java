package com.bookstore.controller;

import com.bookstore.bean.Address;
import com.bookstore.bean.Book;
import com.bookstore.bean.Category;
import com.bookstore.bean.Customer;
import com.bookstore.service.AddressService;
import com.bookstore.service.BookService;
import com.bookstore.service.CategoryService;
import com.bookstore.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
                    book.getIsbn().indexOf(keyword) != -1) {
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
    public ModelAndView toCart() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("customers/Home/cart");
        return mv;
    }

}
