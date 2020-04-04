package com.bookstore.service.impl;

import com.bookstore.bean.Admin;
import com.bookstore.mapper.AdminMapper;
import com.bookstore.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    AdminMapper adminMapper;

    @Override
    public int deleteByPrimaryKey(Long id) {
        return 0;
    }

    @Override
    public int insert(Admin admin) {
        admin.setPwd(DigestUtils.md5DigestAsHex(admin.getPwd().getBytes()));
        return adminMapper.insert(admin);
    }

    @Override
    public int insertSelective(Admin admin) {
        admin.setPwd(DigestUtils.md5DigestAsHex(admin.getPwd().getBytes()));
        return adminMapper.insertSelective(admin);
    }

    @Override
    public Admin selectByPrimaryKey(Long id) {
        return null;
    }

    @Override
    public Admin selectByName(String name) {
        return adminMapper.selectByName(name);
    }

    @Override
    public int updateByPrimaryKeySelective(Admin record) {
        return 0;
    }

    @Override
    public int updateByPrimaryKey(Admin record) {
        return 0;
    }
}
