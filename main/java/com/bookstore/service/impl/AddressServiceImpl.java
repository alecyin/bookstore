package com.bookstore.service.impl;

import com.bookstore.bean.Address;
import com.bookstore.mapper.AddressMapper;
import com.bookstore.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AddressServiceImpl implements AddressService {
    @Autowired
    AddressMapper addressMapper;
    @Override
    public int deleteByPrimaryKey(Long id) {
        return 0;
    }

    @Override
    public int insert(Address record) {
        return 0;
    }

    @Override
    public int insertSelective(Address record) {
        return 0;
    }

    @Override
    public Address selectByPrimaryKey(Long id) {
        return null;
    }

    @Override
    public List<Address> listAddressByCustomerId(Long id) {
        return addressMapper.listAddressByCustomerId(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Address record) {
        return 0;
    }

    @Override
    public int updateByPrimaryKey(Address record) {
        return 0;
    }
}
