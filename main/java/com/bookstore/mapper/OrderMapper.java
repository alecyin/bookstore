package com.bookstore.mapper;

import com.bookstore.bean.Order;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
@Repository
public interface OrderMapper {
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