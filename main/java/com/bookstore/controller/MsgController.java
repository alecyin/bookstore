package com.bookstore.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bookstore.bean.Address;
import com.bookstore.bean.Customer;
import com.bookstore.bean.Msg;
import com.bookstore.service.BookService;
import com.bookstore.service.CustomerService;
import com.bookstore.service.MsgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/messages")
public class MsgController {

    @Autowired
    MsgService msgService;
    @Autowired
    CustomerService customerService;
    @Autowired
    BookService bookService;

    @RequestMapping(value = "/send/{bookId}", method = RequestMethod.POST)
    @ResponseBody
    public void sendMsg(@RequestBody Msg msg,
                       @PathVariable("bookId") Long bookId,
                              HttpServletRequest request) {
        HttpSession session = request.getSession();
        msg.setBookId(bookId);
        msg.setCustomerId((Long) session.getAttribute("userId"));
        msg.setIsDeleted(false);
        msgService.insertSelective(msg);
    }

    @RequestMapping(value = "/del", method = RequestMethod.GET)
    @ResponseBody
    public void del(@RequestParam("ids") String ids) {
        String[] strs = ids.split("-");
        for (String str:strs) {
            if (!StringUtils.isEmpty(str))
                msgService.deleteByPrimaryKey(Long.valueOf(str));
        }
    }

    @RequestMapping(value = "/reply/{msgId}", method = RequestMethod.POST)
    @ResponseBody
    public void replyMsg(@RequestBody Msg msg,
                        @PathVariable("msgId") Long msgId,
                        HttpServletRequest request) {
        Msg replyMsg = msgService.selectByPrimaryKey(msgId);
        HttpSession session = request.getSession();
        msg.setBookId(replyMsg.getBookId());
        msg.setReplyMsgId(replyMsg.getId());
        msg.setCustomerId((Long) session.getAttribute("userId"));
        msg.setIsDeleted(false);
        msgService.insertSelective(msg);
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list() {
        return "admins/page/msg/msgList";
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
        map.put("currentIndex", (page - 1) * limit);
        map.put("pageSize", limit);
        for (Msg msg: msgService.listMsgsByPage(map)) {
            JSONObject jsonObject1 = new JSONObject();
            jsonObject1.put("customerName", customerService.selectByPrimaryKey(msg.getCustomerId()).getName());
            jsonObject1.put("bookName", bookService.selectByPrimaryKey(msg.getBookId()).getName());
            jsonObject1.put("id", msg.getId());
            jsonObject1.put("content", msg.getContent());
            jsonArray.add(jsonObject1);
        }
        jsonObject.put("code", 0);
        jsonObject.put("data", jsonArray);
        jsonObject.put("count", msgService.listMsgs().size());
        return jsonObject.toJSONString();
    }
}
