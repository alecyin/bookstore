package com.bookstore.service;

import com.bookstore.bean.Book;
import com.bookstore.bean.Customer;
import com.bookstore.bean.Order;

import java.util.List;
import java.util.Map;

public interface OrderService {
    int deleteByPrimaryKey(Long id);

    int insert(Order record);

    int insertSelective(Order record);

    Order selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Order record);

    List<Order> listOrdersByCustomerId(Long customerId);

    List<Order> listOrdersByPage(Map<String, Object> map);

    List<Order> listOrders();

    int updateByPrimaryKey(Order record);
}