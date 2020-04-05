package com.bookstore.service.impl;

import com.bookstore.bean.Order;
import com.bookstore.mapper.OrderMapper;
import com.bookstore.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    OrderMapper orderMapper;
    @Override
    public int deleteByPrimaryKey(Long id) {
        return orderMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(Order order) {
        return 0;
    }

    @Override
    public int insertSelective(Order order) {
        return orderMapper.insertSelective(order);
    }

    @Override
    public Order selectByPrimaryKey(Long id) {
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(Order order) {
        return 0;
    }

    @Override
    public int updateByPrimaryKey(Order record) {
        return 0;
    }
}
