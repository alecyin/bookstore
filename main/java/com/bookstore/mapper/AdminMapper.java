package com.bookstore.mapper;

import com.bookstore.bean.Admin;
import com.bookstore.bean.Category;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
@Repository
public interface AdminMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Admin record);

    int insertSelective(Admin record);

    Admin selectByPrimaryKey(Long id);

    Admin selectByName(String name);

    List<Admin> listAdmins();

    List<Admin> listAdminsByPage(Map<String, Object> map);

    int updateByPrimaryKeySelective(Admin record);

    int updateByPrimaryKey(Admin record);
}