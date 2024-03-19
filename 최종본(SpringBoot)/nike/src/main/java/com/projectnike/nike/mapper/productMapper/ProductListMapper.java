package com.projectnike.nike.mapper.productMapper;

import com.projectnike.nike.domain.Criteria;
import com.projectnike.nike.domain.productDomain.ProductListVO;

import java.util.List;

public interface ProductListMapper {
    // 제품 리스트
    List<ProductListVO> getFreeProductList(Criteria cri);

    List<ProductListVO> getListWithPaging(Criteria cri);
    Integer getOrderTotal(Criteria cri); // 주문목록 총 갯수

    // 제품 등록
    int addProduct(ProductListVO productListVO);  // return값은 삽입한 행수
    // 제품 삭제
    int delProduct(int num);      // return값은 삭제한 행수
}