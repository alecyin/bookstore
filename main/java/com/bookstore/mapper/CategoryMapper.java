package com.bookstore.mapper;

import com.bookstore.bean.Category;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
@Repository
public interface CategoryMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Category record);

    int insertSelective(Category record);

    Category selectByPrimaryKey(Long id);

    List<Category> listCategories();

    List<Category> listCategoriesByPage(Map<String, Object> map);

    int updateByPrimaryKeySelective(Category record);

    int updateByPrimaryKey(Category record);
}