package com.bookstore.service.impl;

import com.bookstore.bean.Book;
import com.bookstore.mapper.BookMapper;
import com.bookstore.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class BookServiceImpl implements BookService {
    @Autowired
    BookMapper bookMapper;
    @Override
    public int deleteByPrimaryKey(Long id) {
        return bookMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(Book book) {
        return 0;
    }

    @Override
    public int insertSelective(Book book) {
        return bookMapper.insertSelective(book);
    }

    @Override
    public Book selectByPrimaryKey(Long id) {
        return bookMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Book> listBooksByPage(Map<String, Object> map) {
        return bookMapper.listBooksByPage(map);
    }

    @Override
    public List<Book> listBooks() {
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(Book book) {
        return bookMapper.updateByPrimaryKeySelective(book);
    }

    @Override
    public int updateByPrimaryKey(Book book) {
        return 0;
    }
}
