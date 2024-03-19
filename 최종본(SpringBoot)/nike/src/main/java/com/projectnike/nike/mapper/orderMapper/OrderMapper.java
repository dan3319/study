package com.projectnike.nike.mapper.orderMapper;

import com.projectnike.nike.domain.Criteria;
import com.projectnike.nike.domain.orderDomain.OrderVO;
import com.projectnike.nike.domain.orderDomain.ReplyVO;

import java.util.List;

public interface OrderMapper {

    List<OrderVO> getOrderList(Criteria cri);
    OrderVO getListOne(int num);

    List<OrderVO> getListWithPaging(Criteria cri);

    Integer getOrderTotal(Criteria cri); // 주문목록 총 갯수

    int removeList(int num);

    int addList(OrderVO orderVO);

    int modifyList(OrderVO orderVO);



    List<ReplyVO> getReply();
    int addReply(ReplyVO replyVO);
    int modifyStatus(OrderVO orderVO);

}