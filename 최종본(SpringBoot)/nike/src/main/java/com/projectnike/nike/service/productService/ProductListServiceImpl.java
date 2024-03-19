package com.projectnike.nike.service.productService;

import com.projectnike.nike.domain.Criteria;
import com.projectnike.nike.domain.productDomain.ProductListVO;
import com.projectnike.nike.mapper.productMapper.ProductListMapper;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
public class ProductListServiceImpl implements ProductListService {
    @Autowired
    private ProductListMapper productListMapper;


    @Override
    public List<ProductListVO> getFreeProductList(Criteria cri) {
        return productListMapper.getFreeProductList(cri);
    }

    @Override
    public Integer getTotalCount(Criteria cri) {
        Integer totalListOrderVO = productListMapper.getOrderTotal(cri);
        return totalListOrderVO;
    }

    @Override
    public List<ProductListVO> getOrderPageList(Criteria cri) {
        List<ProductListVO> listPageOrderVO = productListMapper.getListWithPaging(cri);
        return listPageOrderVO;
    }

    @Override
    public List<ProductListVO> getListWithPaging(Criteria cri) {
        List<ProductListVO> listPageOrderVO = productListMapper.getListWithPaging(cri);
        return listPageOrderVO;
    }

    // 제품 등록
    @Override
    public int insertProduct(
            int item_num,               // 제품 번호
            String gender,          // 성별
            String category,           // 카테고리
            String item_type,         // 유형
            String item_name,         // 제품 이름
            String item_size,     // 사이즈
            String color,     // 색상
            int price
    ) {
        ProductListVO productListVO = new ProductListVO();
        productListVO.setItem_num(item_num);
        productListVO.setItem_name(item_name);
        productListVO.setCategory(category);
        productListVO.setColor(color);
        productListVO.setItem_size(item_size);
        productListVO.setPrice(price);
        productListVO.setGender(gender);
        productListVO.setItem_type(item_type);

        int rtn = productListMapper.addProduct(productListVO);
        return rtn;
    }

    // 제품 삭제
    @Override
    public int deleteProduct(int num) {
        return productListMapper.delProduct(num);
    }
}
