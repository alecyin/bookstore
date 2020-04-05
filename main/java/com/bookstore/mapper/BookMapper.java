package com.bookstore.mapper;

import com.bookstore.bean.Book;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
@Repository
public interface BookMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Book record);

    int insertSelective(Book record);

    Book selectByPrimaryKey(Long id);

    List<Book> listBooksByPage(Map<String, Object> map);

    List<Book> listBooksByCategory(Long categoryId);

    List<Book> listBooks();

    int updateByPrimaryKeySelective(Book book);

    int updateByPrimaryKey(Book record);
}