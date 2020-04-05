package com.bookstore.service.impl;

import com.bookstore.bean.Customer;
import com.bookstore.mapper.CustomerMapper;
import com.bookstore.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import java.util.List;
import java.util.Map;

@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    CustomerMapper customerMapper;

    @Override
    public int deleteByPrimaryKey(Long id) {
        return customerMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(Customer customer) {
        customer.setPwd(DigestUtils.md5DigestAsHex(customer.getPwd().getBytes()));
        return customerMapper.insert(customer);
    }

    @Override
    public int insertSelective(Customer customer) {
        customer.setPwd(DigestUtils.md5DigestAsHex(customer.getPwd().getBytes()));
        return customerMapper.insertSelective(customer);
    }

    @Override
    public Customer selectByPrimaryKey(Long id) {
        return customerMapper.selectByPrimaryKey(id);
    }

    @Override
    public Customer selectByName(String name) {
        return customerMapper.selectByName(name);
    }

    @Override
    public List<Customer> listCustomers() {
        return customerMapper.listCustomers();
    }

    @Override
    public List<Customer> listCustomersByPage(Map<String, Object> map) {
        return customerMapper.listCustomersByPage(map);
    }

    @Override
    public int updateByPrimaryKeySelective(Customer record) {
        return 0;
    }

    @Override
    public int updateByPrimaryKey(Customer record) {
        return 0;
    }
}
