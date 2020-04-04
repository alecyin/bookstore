package com.bookstore.service;

import com.bookstore.bean.Customer;

import java.util.List;
import java.util.Map;

public interface CustomerService {
    int deleteByPrimaryKey(Long id);

    int insert(Customer customer);

    int insertSelective(Customer customer);

    Customer selectByPrimaryKey(Long id);

    Customer selectByName(String name);

    List<Customer> listCustomers();

    List<Customer> listCustomersByPage(Map<String, Object> map);

    int updateByPrimaryKeySelective(Customer customer);

    int updateByPrimaryKey(Customer customer);
}