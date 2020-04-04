package com.bookstore.service;

import com.bookstore.bean.Admin;

public interface AdminService {
    int deleteByPrimaryKey(Long id);

    int insert(Admin admin);

    int insertSelective(Admin admin);

    Admin selectByPrimaryKey(Long id);

    Admin selectByName(String name);

    int updateByPrimaryKeySelective(Admin admin);

    int updateByPrimaryKey(Admin admin);
}
