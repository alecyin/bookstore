package com.bookstore.service;

import com.bookstore.bean.Category;
import com.bookstore.bean.Customer;

import java.util.List;
import java.util.Map;

public interface CategoryService {
    int deleteByPrimaryKey(Long id);

    int insert(Category record);

    int insertSelective(Category record);

    Category selectByPrimaryKey(Long id);

    List<Category> listCategories();

    List<Category> listCategoriesByPage(Map<String, Object> map);

    int updateByPrimaryKeySelective(Category record);

    int updateByPrimaryKey(Category record);
}