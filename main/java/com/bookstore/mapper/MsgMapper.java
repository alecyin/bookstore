package com.bookstore.mapper;

import com.bookstore.bean.Msg;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
@Repository
public interface MsgMapper {
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