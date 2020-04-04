package com.bookstore.service.impl;

import com.bookstore.bean.Msg;
import com.bookstore.service.MsgService;
import org.springframework.stereotype.Service;

@Service
public class MsgServiceImpl implements MsgService {
    @Override
    public int deleteByPrimaryKey(Long id) {
        return 0;
    }

    @Override
    public int insert(Msg record) {
        return 0;
    }

    @Override
    public int insertSelective(Msg record) {
        return 0;
    }

    @Override
    public Msg selectByPrimaryKey(Long id) {
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(Msg record) {
        return 0;
    }

    @Override
    public int updateByPrimaryKeyWithBLOBs(Msg record) {
        return 0;
    }

    @Override
    public int updateByPrimaryKey(Msg record) {
        return 0;
    }
}
