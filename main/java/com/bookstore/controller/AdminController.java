package com.bookstore.controller;

import com.alibaba.fastjson.JSONObject;
import com.bookstore.bean.Admin;
import com.bookstore.bean.Admin;
import com.bookstore.bean.Customer;
import com.bookstore.bean.Msg;
import com.bookstore.service.AdminService;
import com.bookstore.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admins")
public class AdminController {
    @Autowired
    AdminService adminService;
    @Autowired
    CustomerService customerService;

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Map add(@RequestBody Admin admin) {
        Map<String, Object> map = new HashMap<>();
        map.put("code", adminService.insertSelective(admin));
        return map;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ResponseBody
    public Map edit(@RequestBody Admin admin) {
        Map<String, Object> map = new HashMap<>();
        map.put("code", adminService.updateByPrimaryKeySelective(admin));
        return map;
    }

    @RequestMapping(value = "/adminAdd", method = RequestMethod.GET)
    public String adminAdd() {
        return "admins/page/admin/adminAdd";
    }

    @RequestMapping(value = "/adminEdit", method = RequestMethod.GET)
    public String adminEdit() {
        return "admins/page/admin/adminEdit";
    }

    @RequestMapping(value = "/del", method = RequestMethod.GET)
    @ResponseBody
    public void del(@RequestParam("ids") String ids) {
        String[] strs = ids.split("-");
        for (String str:strs) {
            if (!StringUtils.isEmpty(str))
                adminService.deleteByPrimaryKey(Long.valueOf(str));
        }
    }

    @RequestMapping(value = "/resetPass", method = RequestMethod.GET)
    @ResponseBody
    public void resetPass(@RequestParam("id") Long id) {
        Admin admin = adminService.selectByPrimaryKey(id);
        admin.setPwd(DigestUtils.md5DigestAsHex("123456".getBytes()));
        adminService.updateByPrimaryKeySelective(admin);
    }

    @RequestMapping(value = "/changePass", method = RequestMethod.GET)
    @ResponseBody
    public ModelAndView changePass(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("admins/page/user/changePwd");
        mv.addObject("user",
                adminService.selectByPrimaryKey((Long) request.getSession().getAttribute("userId")));
        return mv;
    }

    @RequestMapping(value = "/changePwd", method = RequestMethod.POST)
    @ResponseBody
    public Map changePwd(@RequestBody Map map1, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();
        Admin admin = adminService
                .selectByPrimaryKey((Long) request.getSession().getAttribute("userId"));
        if (!admin.getPwd().equals(DigestUtils.md5DigestAsHex(((String)map1.get("oldPass")).getBytes()))) {
            map.put("code", 0);
        } else {
            admin.setPwd(DigestUtils.md5DigestAsHex(
                    ((String)map1.get("newPass")).getBytes()
            ));
            map.put("code", adminService.updateByPrimaryKeySelective(admin));
        }
        return map;
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list() {
        return "admins/page/admin/adminList";
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
        map.put("currentIndex", (page - 1) * limit);
        map.put("pageSize", limit);
        List caList = adminService.listAdminsByPage(map);
        jsonObject.put("code", 0);
        jsonObject.put("data", caList);
        jsonObject.put("count", adminService.listAdmins().size());
        return jsonObject.toJSONString();
    }
}
