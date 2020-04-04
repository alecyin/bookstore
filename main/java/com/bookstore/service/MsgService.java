package com.bookstore.service;

import com.bookstore.bean.Msg;

public interface MsgService {
    int deleteByPrimaryKey(Long id);

    int insert(Msg record);

    int insertSelective(Msg record);

    Msg selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Msg record);

    int updateByPrimaryKeyWithBLOBs(Msg record);

    int updateByPrimaryKey(Msg record);
}