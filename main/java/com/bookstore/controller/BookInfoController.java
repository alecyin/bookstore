package com.bookstore.controller;

import com.bookstore.bean.Book;
import com.bookstore.bean.Category;
import com.bookstore.service.BookService;
import com.bookstore.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
    @RequestMapping(value = "/info/{bookId}", method = RequestMethod.GET)
    public ModelAndView info(@PathVariable("bookId") Long bookId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("customers/Home/bookInfo");
        Book book = bookService.selectByPrimaryKey(bookId);
        mv.addObject("book", book);
        return mv;
    }
}
