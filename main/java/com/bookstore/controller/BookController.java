package com.bookstore.controller;

import com.alibaba.fastjson.JSONObject;
import com.bookstore.bean.Book;
import com.bookstore.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/books")
public class BookController {
    @Autowired
    BookService bookService;

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Map add(@RequestBody Book book) {
        Map<String, Object> map = new HashMap<>();
        map.put("code", bookService.insertSelective(book));
        return map;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ResponseBody
    public Map edit(@RequestBody Book book) {
        Map<String, Object> map = new HashMap<>();
        map.put("code", bookService.updateByPrimaryKeySelective(book));
        return map;
    }

    @RequestMapping(value = "/bookAdd", method = RequestMethod.GET)
    public String bookAdd() {
        return "admins/page/book/bookAdd";
    }

    @RequestMapping(value = "/bookEdit", method = RequestMethod.GET)
    public String bookEdit() {
        return "admins/page/book/bookEdit";
    }

    @RequestMapping(value = "/del", method = RequestMethod.GET)
    @ResponseBody
    public void del(@RequestParam("ids") String ids) {
        String[] strs = ids.split("-");
        for (String str:strs) {
            if (!StringUtils.isEmpty(str))
                bookService.deleteByPrimaryKey(Long.valueOf(str));
        }
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list() {
        return "admins/page/book/bookList";
    }

    @RequestMapping(value = "/table-data", method = RequestMethod.GET)
    @ResponseBody
    public String listData(
            @RequestParam(value = "key", required = false) String keyword,
            @RequestParam("page") int page,
            @RequestParam("limit") int limit) {
        JSONObject jsonObject = new JSONObject();
        Map<String, Object> map = new HashMap<>();
        map.put("keyword", keyword);
        map.put("currentIndex", (page - 1) * page);
        map.put("pageSize", limit);
        List caList = bookService.listBooksByPage(map);
        jsonObject.put("code", 0);
        jsonObject.put("data", caList);
        jsonObject.put("count", caList.size());
        return jsonObject.toJSONString();
    }
}
