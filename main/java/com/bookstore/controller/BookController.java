package com.bookstore.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bookstore.bean.Book;
import com.bookstore.bean.Category;
import com.bookstore.bean.Order;
import com.bookstore.service.BookService;
import com.bookstore.service.CategoryService;
import com.bookstore.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/books")
public class BookController {

    @Value("${photo.upload.path}")
    private String path;
    @Value("${photo.upload.suffix}")
    private String suffix;


    @Autowired
    BookService bookService;
    @Autowired
    CategoryService categoryService;
    @Autowired
    OrderService orderService;

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Map add(@RequestParam("file") MultipartFile file,
                   @RequestParam("name") String name,
                   @RequestParam("author") String author,
                   @RequestParam("category_id") Long categoryId,
                   @RequestParam("sketch") String sketch,
                   @RequestParam("isbn") String isbn,
                   @RequestParam("publish") String publish,
                   @RequestParam("price") BigDecimal price,
                   @RequestParam("pubdate") String pubdate,
                   HttpServletRequest request) throws IOException, ParseException {
        Book book = new Book();
        book.setName(name);
        book.setAuthor(author);
        book.setCategoryId(categoryId);
        book.setPrice(price);
        book.setIsbn(isbn);
        book.setPublish(publish);
        book.setPubdate(new SimpleDateFormat("yyyy-MM-dd").parse(pubdate));
        book.setSketch(sketch);
        Map<String, Object> map = new HashMap<>();
        String dFileName = UUID.randomUUID().toString()
                .replace("-", "");
        File uploadFile = new File(path + dFileName + suffix);
        file.transferTo(uploadFile);
        book.setThumbnail(dFileName);
        map.put("code", bookService.insertSelective(book));
        return map;
    }

    @RequestMapping(value = "/editPic", method = RequestMethod.POST)
    @ResponseBody
    public Map editPic(@RequestParam("file") MultipartFile file,
                   @RequestParam("id") Long id) throws IOException, ParseException {
        Map<String, Object> map = new HashMap<>();
        file.transferTo(new File(path
                + bookService.selectByPrimaryKey(id).getThumbnail() + suffix));
        map.put("code", 1);
        return map;
    }

    @RequestMapping(value = "/editInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map editInfo(@RequestBody Book book) {
        Map<String, Object> map = new HashMap<>();
        map.put("code", bookService.updateByPrimaryKeySelective(book));
        return map;
    }

    @RequestMapping(value = "/bookAdd", method = RequestMethod.GET)
    public ModelAndView bookAdd() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("admins/page/book/bookAdd");
        mv.addObject("categoryList", categoryService.listCategories());
        return mv;
    }

    @RequestMapping(value = "/bookEdit/{id}", method = RequestMethod.GET)
    public ModelAndView bookEdit(@PathVariable("id") Long id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("admins/page/book/bookEdit");
        mv.addObject("selected", bookService.selectByPrimaryKey(id).getCategoryId());
        mv.addObject("categoryList", categoryService.listCategories());
        return mv;
    }

    @RequestMapping(value = "/del", method = RequestMethod.GET)
    @ResponseBody
    public void del(@RequestParam("ids") String ids) {
        String[] strs = ids.split("-");
        for (String str:strs) {
            if (!StringUtils.isEmpty(str)) {
                new File(path + bookService.selectByPrimaryKey(Long.valueOf(str)).getThumbnail()
                    + suffix).delete();
                bookService.deleteByPrimaryKey(Long.valueOf(str));
            }
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
        map.put("currentIndex", (page - 1) * limit);
        map.put("pageSize", limit);
        JSONArray jsonArray = new JSONArray();
        for (Book book : bookService.listBooksByPage(map)) {
            JSONObject jsonObject1 = new JSONObject();
            jsonObject1.put("id", book.getId());
            jsonObject1.put("name", book.getName());
            jsonObject1.put("pubdate", book.getPubdate());
            jsonObject1.put("author", book.getAuthor());
            jsonObject1.put("sketch", book.getSketch());
            jsonObject1.put("thumbnail", book.getThumbnail());
            jsonObject1.put("categoryId", book.getCategoryId());
            jsonObject1.put("price", book.getPrice());
            jsonObject1.put("isbn", book.getIsbn());
            jsonObject1.put("sales", book.getSales());
            jsonObject1.put("publish", book.getPublish());
            jsonObject1.put("categoryName", categoryService.
                    selectByPrimaryKey(book.getCategoryId()).getName());
            jsonArray.add(jsonObject1);
        }
        jsonObject.put("code", 0);
        jsonObject.put("data", jsonArray);
        jsonObject.put("count", bookService.listBooks().size());
        return jsonObject.toJSONString();
    }

    @RequestMapping(value = "/sales", method = RequestMethod.GET)
    public String sales() {
        return "admins/page/sales/sales";
    }

    @RequestMapping(value = "/sales-count", method = RequestMethod.GET)
    @ResponseBody
    public String salesCount(@RequestParam(value = "key", required = false) String keyword,
                             @RequestParam(value = "month", required = false, defaultValue = "-1") String month,
                             @RequestParam(value = "year", required = false, defaultValue = "-1") String year,
                             @RequestParam("page") int page,
                             @RequestParam("limit") int limit) {
        HashMap<Long, JSONObject> weekMap = new HashMap<>();
        for (Order order: orderService.selectCurWeek()) {
            String[] bookStrs = order.getBooks().split("\\|");
            for (String str : bookStrs) {
                Long bookId = Long.valueOf(str.split("-")[0]);
                if (weekMap.get(bookId) == null) {
                    weekMap.put(bookId, new JSONObject());
                }
                JSONObject jsonObject = weekMap.get(bookId);
                Book book2 = bookService.selectByPrimaryKey(bookId);
                long weekAmount = Long.valueOf(str.split("-")[1]);
                jsonObject.put("weekAmount", Long.valueOf(String.valueOf(jsonObject.getOrDefault("weekAmount", 0)) ) + weekAmount);
                jsonObject.put("weekPrice", new BigDecimal(String.valueOf(jsonObject.getOrDefault("weekPrice", 0)))
                        .add(book2.getPrice().multiply(new BigDecimal(str.split("-")[1]))));
            }
        }

        Calendar cal = Calendar.getInstance();
        String month1 = String.format("%04d", cal.get(Calendar.YEAR)) + String.format("%02d", cal.get(Calendar.MONTH) + 1);
        if (!month.equals("-1")) {
            month1 = month.replaceAll("-", "");
        }
        HashMap<Long, JSONObject> monthMap = new HashMap<>();
        for (Order order: getMonth(month1)) {
            String[] bookStrs = order.getBooks().split("\\|");
            for (String str : bookStrs) {
                Long bookId = Long.valueOf(str.split("-")[0]);
                if (monthMap.get(bookId) == null) {
                    monthMap.put(bookId, new JSONObject());
                }
                JSONObject jsonObject = monthMap.get(bookId);
                Book book2 = bookService.selectByPrimaryKey(bookId);
                long monthAmount = Long.valueOf(str.split("-")[1]);
                jsonObject.put("monthAmount", Long.valueOf(String.valueOf(jsonObject.getOrDefault("monthAmount", 0)) ) + monthAmount);
                jsonObject.put("monthPrice", new BigDecimal(String.valueOf(jsonObject.getOrDefault("monthPrice", 0)))
                        .add(book2.getPrice().multiply(new BigDecimal(str.split("-")[1]))));
            }
        }

        HashMap<Long, JSONObject> yearMap = new HashMap<>();
        String year1 = String.format("%04d", cal.get(Calendar.YEAR));
        if (!year.equals("-1")) {
            year1 = year;
        }
        for (Order order: getYear(year1)) {
            String[] bookStrs = order.getBooks().split("\\|");
            for (String str : bookStrs) {
                Long bookId = Long.valueOf(str.split("-")[0]);
                if (yearMap.get(bookId) == null) {
                    yearMap.put(bookId, new JSONObject());
                }
                JSONObject jsonObject = yearMap.get(bookId);
                Book book2 = bookService.selectByPrimaryKey(bookId);
                long yearMount = Long.valueOf(str.split("-")[1]);
                jsonObject.put("yearMount", Long.valueOf(String.valueOf(jsonObject.getOrDefault("yearMount", 0)) ) + yearMount);
                jsonObject.put("yearPrice", new BigDecimal(String.valueOf(jsonObject.getOrDefault("yearPrice", 0)))
                        .add(book2.getPrice().multiply(new BigDecimal(str.split("-")[1]))));
            }
        }
        JSONObject jsonObject = new JSONObject();
        Map<String, Object> map = new HashMap<>();
        map.put("keyword", keyword);
        map.put("currentIndex", (page - 1) * limit);
        map.put("pageSize", limit);
        JSONArray jsonArray = new JSONArray();
        for (Book book : bookService.listBooksByPage(map)) {
            JSONObject jsonObject1 = new JSONObject();
            jsonObject1.put("id", book.getId());
            jsonObject1.put("name", book.getName());
            jsonObject1.put("price", book.getPrice());
            jsonObject1.put("sales", book.getSales());
            jsonObject1.put("categoryName", categoryService.
                    selectByPrimaryKey(book.getCategoryId()).getName());
            jsonObject1.put("weekAmount", weekMap.getOrDefault(book.getId(), new JSONObject()).getOrDefault("weekAmount",0));
            jsonObject1.put("weekPrice", weekMap.getOrDefault(book.getId(), new JSONObject()).getOrDefault("weekPrice",0));
            jsonObject1.put("monthAmount", monthMap.getOrDefault(book.getId(), new JSONObject()).getOrDefault("monthAmount",0));
            jsonObject1.put("monthPrice", monthMap.getOrDefault(book.getId(), new JSONObject()).getOrDefault("monthPrice",0));
            jsonObject1.put("yearAmount", yearMap.getOrDefault(book.getId(), new JSONObject()).getOrDefault("yearMount",0));
            jsonObject1.put("yearPrice", yearMap.getOrDefault(book.getId(), new JSONObject()).getOrDefault("yearPrice",0));
            jsonArray.add(jsonObject1);
        }
        jsonObject.put("code", 0);
        jsonObject.put("data", jsonArray);
        jsonObject.put("count", bookService.listBooks().size());
        return jsonObject.toJSONString();

    }

    public List<Order> getMonth(String ym) {
        List<Order> list = orderService.listOrders();
        List<Order> list2 = new ArrayList<>();
        for (Order order:list) {
            if (order.getFinish() == null) {
                continue;
            }
            DateFormat df= new SimpleDateFormat("yyyyMM");
            String str_time =df.format(order.getFinish());
            if (ym.equals(str_time)) {
                list2.add(order);
            }
        }
        return list2;
    }

    public List<Order> getYear(String y) {
        List<Order> list = orderService.listOrders();
        List<Order> list2 = new ArrayList<>();
        for (Order order:list) {
            if (order.getFinish() == null) {
                continue;
            }
            DateFormat df= new SimpleDateFormat("yyyy");
            String str_time =df.format(order.getFinish());
            if (y.equals(str_time)) {
                list2.add(order);
            }
        }
        return list2;
    }
}
