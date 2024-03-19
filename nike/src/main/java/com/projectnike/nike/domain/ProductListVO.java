package com.projectnike.nike.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductListVO {
    private int item_num;                // 제품 번호
    private String gender;          // 성별
    private String category;           // 카테고리
    private String item_type;         // 유형
    private String item_name;         // 제품 이름
    private String item_size;     // 사이즈
    private String color;     // 색상
    private int price;  // 가격
    private int rownum;   // 목차 번호
}
