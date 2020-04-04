package com.bookstore.service;

import com.bookstore.bean.Address;

import java.util.List;

public interface AddressService {
    int deleteByPrimaryKey(Long id);

    int insert(Address record);

    int insertSelective(Address record);

    Address selectByPrimaryKey(Long id);

    List<Address> listAddressByCustomerId(Long id);

    int updateByPrimaryKeySelective(Address record);

    int updateByPrimaryKey(Address record);
}