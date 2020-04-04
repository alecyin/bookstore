package com.bookstore.service.impl;

import com.bookstore.bean.Category;
import com.bookstore.mapper.CategoryMapper;
import com.bookstore.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CategoryServiceImpl implements CategoryService {
    @Autowired
    CategoryMapper categoryMapper;
    @Override
    public int deleteByPrimaryKey(Long id) {
        return categoryMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(Category record) {
        return 0;
    }

    @Override
    public int insertSelective(Category category) {
        return categoryMapper.insertSelective(category);
    }

    @Override
    public Category selectByPrimaryKey(Long id) {
        return categoryMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Category> listCategories() {
        return categoryMapper.listCategories();
    }

    @Override
    public List<Category> listCategoriesByPage(Map<String, Object> map) {
        return categoryMapper.listCategoriesByPage(map);
    }

    @Override
    public int updateByPrimaryKeySelective(Category category) {
        return categoryMapper.updateByPrimaryKeySelective(category);
    }

    @Override
    public int updateByPrimaryKey(Category category) {
        return 0;
    }
}
