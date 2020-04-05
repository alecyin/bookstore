package com.bookstore.service.impl;

import com.bookstore.bean.Admin;
import com.bookstore.bean.Category;
import com.bookstore.mapper.AdminMapper;
import com.bookstore.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import java.util.List;
import java.util.Map;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    AdminMapper adminMapper;

    @Override
    public int deleteByPrimaryKey(Long id) {
        return adminMapper.deleteByPrimaryKey(id);
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
        return adminMapper.selectByPrimaryKey(id);
    }

    @Override
    public Admin selectByName(String name) {
        return adminMapper.selectByName(name);
    }

    @Override
    public List<Admin> listAdmins() {
        return adminMapper.listAdmins();
    }

    @Override
    public List<Admin> listAdminsByPage(Map<String, Object> map) {
        return adminMapper.listAdminsByPage(map);
    }


    @Override
    public int updateByPrimaryKeySelective(Admin admin) {
        return adminMapper.updateByPrimaryKeySelective(admin);
    }

    @Override
    public int updateByPrimaryKey(Admin admin) {
        return 0;
    }
}
