package com.projectnike.nike.service.productService;

import com.projectnike.nike.domain.Criteria;
import com.projectnike.nike.domain.productDomain.ProductListVO;

import java.util.List;

public interface ProductListService {
    // 제품 리스트
    List<ProductListVO> getFreeProductList(Criteria cri);

    Integer getTotalCount(Criteria cri); // 주문목록 총 갯수
    List<ProductListVO> getOrderPageList(Criteria cri);

    // 제품 등록
    int insertProduct(int item_num,               // 제품 번호
                      String gender,          // 성별
                      String category,           // 카테고리
                      String item_type,         // 유형
                      String item_name,         // 제품 이름
                      String item_size,     // 사이즈
                      String color,     // 색상
                      int price);

    // 제품 삭제
    int deleteProduct(int num);


    List<ProductListVO> getListWithPaging(Criteria cri);

}

