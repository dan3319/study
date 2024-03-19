package com.projectnike.nike.domain.mainDomain;

import lombok.Data;

@Data
public class ProductsVO {
    private int item_num;//--
    private String gender;
    private String category;//--
    private String item_type;//
    private String item_name;//--
    private String item_size;//--
    private String color;
    private int price;
    private int quantity;//--
}