package com.bookstore.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bookstore.bean.Book;
import com.bookstore.bean.Category;
import com.bookstore.bean.Msg;
import com.bookstore.service.BookService;
import com.bookstore.service.CategoryService;
import com.bookstore.service.CustomerService;
import com.bookstore.service.MsgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

@Controller
public class BookInfoController {
    @Autowired
    BookService bookService;
    @Autowired
    CategoryService categoryService;
    @Autowired
    MsgService msgService;
    @Autowired
    CustomerService customerService;

    @RequestMapping(value = "/info/{bookId}", method = RequestMethod.GET)
    public ModelAndView info(@PathVariable("bookId") Long bookId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("customers/Home/bookInfo");
        Book book = bookService.selectByPrimaryKey(bookId);
        mv.addObject("book", book);
        List<Msg> mList = msgService.listMsgsByBookId(bookId);
        JSONObject jsonObject = new JSONObject();
        JSONArray jsonArray = new JSONArray();
        JSONArray p1 = new JSONArray();
        for (Msg msg : mList) {
            if (msg.getIsDeleted()) {
                msg.setContent("该条内容已被删除");
            }
            if (StringUtils.isEmpty(msg.getReplyMsgId())) {
                JSONObject jsonObject1 = new JSONObject();
                jsonObject1.put("content", msg.getContent());
                jsonObject1.put("id", msg.getId());
                jsonObject1.put("customerName",
                        customerService.selectByPrimaryKey(msg.getCustomerId()).getName());
                p1.add(jsonObject1);
            }
        }
        for (Object object : p1) {
            JSONObject jsonObject1 = (JSONObject) object;
            JSONArray jsonArray1 = new JSONArray();
            for (Msg msg:mList) {
                Long pId = jsonObject1.getLong("id");
                if (msg.getReplyMsgId() != null && msg.getReplyMsgId().compareTo(pId) == 0) {
                    JSONObject jsonObject2 = new JSONObject();
                    jsonObject2.put("content", msg.getContent());
                    jsonObject2.put("id", msg.getId());
                    jsonObject2.put("customerName",
                            customerService.selectByPrimaryKey(msg.getCustomerId()).getName());
                    jsonArray1.add(jsonObject2);
                }
            }
            jsonObject1.put("child", jsonArray1);
            jsonArray.add(jsonObject1);
        }
        mv.addObject("msgs", jsonArray);
        return mv;
    }
}
