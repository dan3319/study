package com.projectnike.nike.service.orderService;

import com.projectnike.nike.domain.Criteria;
import com.projectnike.nike.domain.orderDomain.OrderVO;
import com.projectnike.nike.domain.orderDomain.ReplyVO;
import com.projectnike.nike.mapper.orderMapper.OrderMapper;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
public class OrderServiceImpl implements OrderService{

    @Autowired
    private OrderMapper orderMapper;


    @Override
    public List<OrderVO> getOrderList(Criteria cri) {
        return orderMapper.getOrderList(cri);
    }

    @Override
    public List<OrderVO> getOrderPageList(Criteria cri) {
        log.info("get List with Criteria: " + cri);
        List<OrderVO> listPageOrderVO = orderMapper.getListWithPaging(cri);
        return listPageOrderVO;
    }

    @Override
    public Integer getTotalCount(Criteria cri) {
        Integer totalListOrderVO = orderMapper.getOrderTotal(cri);
        return totalListOrderVO;
    }

    @Override
    public int deleteList(int num) {
        return orderMapper.removeList(num);
    }

    @Override
    public OrderVO getOneList(int num) {
        return orderMapper.getListOne(num);
    }

    @Override
    public int insertList(
            String requester,
            String brand,
            String type,
            String place,
            String name,
            String size,
            int quantity, int chest, int front, int sleeve, int back, int arm,
            String requirements, String details, String filePath
    ){
        OrderVO orderVO = new OrderVO();
        orderVO.setRequester(requester);
        orderVO.setBrand(brand);
        orderVO.setType(type);
        orderVO.setPlace(place);
        orderVO.setName(name);
        orderVO.setSize(size);
        orderVO.setQuantity(quantity);
        orderVO.setChest(chest);
        orderVO.setFront(front);
        orderVO.setSleeve(sleeve);
        orderVO.setBack(back);
        orderVO.setArm(arm);
        orderVO.setRequirements(requirements);
        orderVO.setDetails(details);
        orderVO.setFilePath(filePath);
        int rtn = orderMapper.addList(orderVO);
        return rtn;
    }

    @Override
    public int updateList(
            String requester,
            String brand,
            String type,
            String place,
            String name,
            String size,
            int quantity, int chest, int front, int sleeve, int back, int arm,
            String requirements, String details, String filePath, int num
    ){
        OrderVO orderVO = new OrderVO();
        orderVO.setNum(num);
        orderVO.setRequester(requester);
        orderVO.setBrand(brand);
        orderVO.setType(type);
        orderVO.setPlace(place);
        orderVO.setName(name);
        orderVO.setSize(size);
        orderVO.setQuantity(quantity);
        orderVO.setChest(chest);
        orderVO.setFront(front);
        orderVO.setSleeve(sleeve);
        orderVO.setBack(back);
        orderVO.setArm(arm);
        orderVO.setRequirements(requirements);
        orderVO.setDetails(details);
        orderVO.setFilePath(filePath);

        return orderMapper.modifyList(orderVO);
    }


    //Reply section--------------------------------------------
    @Override
    public List<ReplyVO> getReply(){
        return orderMapper.getReply();
    }

    @Override
    public int insertReply(int num, String commenter, String content
    ) {
        ReplyVO replyVo = new ReplyVO();

        replyVo.setNum(num);
        replyVo.setCommenter(commenter);
        replyVo.setContent(content);

        return orderMapper.addReply(replyVo);
    }

    @Override
    public int updateStatus(String status, int num){

        OrderVO orderVO = new OrderVO();
        orderVO.setStatus(status);
        orderVO.setNum(num);

        return orderMapper.modifyStatus(orderVO);
    }
}
