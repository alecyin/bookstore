package com.bookstore.service;

import com.bookstore.bean.Book;
import com.bookstore.bean.Category;

import java.util.List;
import java.util.Map;

public interface BookService {
    int deleteByPrimaryKey(Long id);

    int insert(Book record);

    int insertSelective(Book record);

    Book selectByPrimaryKey(Long id);

    List<Book> listBooksByPage(Map<String, Object> map);

    List<Book> listBooks();

    int updateByPrimaryKeySelective(Book book);

    int updateByPrimaryKey(Book record);
}