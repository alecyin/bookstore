package com.bookstore.service;

import com.bookstore.bean.Admin;
import com.bookstore.bean.Category;

import java.util.List;
import java.util.Map;

public interface AdminService {
    int deleteByPrimaryKey(Long id);

    int insert(Admin admin);

    int insertSelective(Admin admin);

    Admin selectByPrimaryKey(Long id);

    Admin selectByName(String name);

    List<Admin> listAdmins();

    List<Admin> listAdminsByPage(Map<String, Object> map);

    int updateByPrimaryKeySelective(Admin admin);

    int updateByPrimaryKey(Admin admin);
}
