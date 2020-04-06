package com.bookstore.service.impl;

import com.bookstore.bean.Msg;
import com.bookstore.mapper.MsgMapper;
import com.bookstore.service.MsgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class MsgServiceImpl implements MsgService {
    @Autowired
    MsgMapper msgMapper;
    @Override
    public int deleteByPrimaryKey(Long id) {
        Msg msg = selectByPrimaryKey(id);
        msg.setIsDeleted(true);
        return msgMapper.updateByPrimaryKeySelective(msg);
    }

    @Override
    public int insert(Msg record) {
        return 0;
    }

    @Override
    public int insertSelective(Msg msg) {
        return msgMapper.insertSelective(msg);
    }

    @Override
    public Msg selectByPrimaryKey(Long id) {
        return msgMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Msg> listMsgsByPage(Map<String, Object> map) {
        return msgMapper.listMsgsByPage(map);
    }

    @Override
    public List<Msg> listMsgsByBookId(Long bookId) {
        return msgMapper.listMsgsByBookId(bookId);
    }

    @Override
    public List<Msg> listMsgs() {
        return msgMapper.listMsgs();
    }

    @Override
    public int updateByPrimaryKeySelective(Msg msg) {
        return 0;
    }

    @Override
    public int updateByPrimaryKeyWithBLOBs(Msg msg) {
        return 0;
    }

    @Override
    public int updateByPrimaryKey(Msg msg) {
        return 0;
    }
}
