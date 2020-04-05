package com.bookstore.service;

import com.bookstore.bean.Book;
import com.bookstore.bean.Msg;

import java.util.List;
import java.util.Map;

public interface MsgService {
    int deleteByPrimaryKey(Long id);

    int insert(Msg record);

    int insertSelective(Msg record);

    Msg selectByPrimaryKey(Long id);

    List<Msg> listMsgsByPage(Map<String, Object> map);

    List<Msg> listMsgsByBookId(Long bookId);

    List<Msg> listMsgs();

    int updateByPrimaryKeySelective(Msg record);

    int updateByPrimaryKeyWithBLOBs(Msg record);

    int updateByPrimaryKey(Msg record);
}