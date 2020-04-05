package com.bookstore.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bookstore.bean.Address;
import com.bookstore.bean.Category;
import com.bookstore.service.AddressService;
import com.bookstore.service.CategoryService;
import com.bookstore.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/categories")
public class CategoryController {
    @Autowired
    CategoryService categoryService;

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Map add(@RequestBody Category category) {
        Map<String, Object> map = new HashMap<>();
        map.put("code", categoryService.insertSelective(category));
        return map;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ResponseBody
    public Map edit(@RequestBody Category category) {
        Map<String, Object> map = new HashMap<>();
        map.put("code", categoryService.updateByPrimaryKeySelective(category));
        return map;
    }

    @RequestMapping(value = "/categoryAdd", method = RequestMethod.GET)
    public String categoryAdd() {
        return "admins/page/category/categoryAdd";
    }

    @RequestMapping(value = "/categoryEdit", method = RequestMethod.GET)
    public String categoryEdit() {
        return "admins/page/category/categoryEdit";
    }

    @RequestMapping(value = "/del", method = RequestMethod.GET)
    @ResponseBody
    public void del(@RequestParam("ids") String ids) {
        String[] strs = ids.split("-");
        for (String str:strs) {
            if (!StringUtils.isEmpty(str))
                categoryService.deleteByPrimaryKey(Long.valueOf(str));
        }
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list() {
        return "admins/page/category/categoryList";
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
        List caList = categoryService.listCategoriesByPage(map);
        jsonObject.put("code", 0);
        jsonObject.put("data", caList);
        jsonObject.put("count", categoryService.listCategories().size());
        return jsonObject.toJSONString();
    }
}
