package com.bookstore.mapper;

import com.bookstore.bean.Customer;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
@Repository
public interface CustomerMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Customer record);

    int insertSelective(Customer record);

    Customer selectByPrimaryKey(Long id);

    Customer selectByName(String name);

    List<Customer> listCustomers();

    List<Customer> listCustomersByPage(Map<String, Object> map);

    int updateByPrimaryKeySelective(Customer record);

    int updateByPrimaryKey(Customer record);
}