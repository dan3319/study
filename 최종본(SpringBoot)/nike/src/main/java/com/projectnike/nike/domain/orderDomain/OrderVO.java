package com.projectnike.nike.domain.orderDomain;

import lombok.Data;

@Data
public class OrderVO {

    private int num;
    private String date;
    private String requester;
    private String brand;
    private String type;
    private String place;
    private String name;
    private String size;
    private int quantity;
    private int chest;
    private int front;
    private int sleeve;
    private int back;

    private int arm;
    private String requirements;
    private String details;
    private String filePath;
    private String status;


}
