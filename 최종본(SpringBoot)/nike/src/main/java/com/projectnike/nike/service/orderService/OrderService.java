package com.projectnike.nike.service.orderService;

import com.projectnike.nike.domain.Criteria;
import com.projectnike.nike.domain.orderDomain.OrderVO;
import com.projectnike.nike.domain.orderDomain.ReplyVO;

import java.util.List;

public interface OrderService {
    List<OrderVO> getOrderList(Criteria cri);

    List<OrderVO> getOrderPageList(Criteria cri);

    Integer getTotalCount(Criteria cri); // 주문목록 총 갯수

    int deleteList(int num);

    OrderVO getOneList(int num);

    int insertList(
            String requester,
            String brand,
            String type,
            String place,
            String name,
            String size,
            int quantity,
            int chest, int front, int sleeve, int back, int arm,
            String requirements, String details, String filePath);

    int updateList(
            String requester,
            String brand,
            String type,
            String place,
            String name,
            String size,
            int quantity, int chest, int front,
            int sleeve, int back, int arm,
            String requirements, String details, String filePath, int num
    );

    //Reply section------------------------------------------------------------------
    List<ReplyVO> getReply();

    int insertReply(
            int num,
            String commenter,
            String content
    );
    int updateStatus(
            String status,
            int num
    );

}