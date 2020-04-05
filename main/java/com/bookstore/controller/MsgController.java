package com.bookstore.controller;

import com.bookstore.bean.Customer;
import com.bookstore.bean.Msg;
import com.bookstore.service.MsgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/messages")
public class MsgController {

    @Autowired
    MsgService msgService;

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
}
