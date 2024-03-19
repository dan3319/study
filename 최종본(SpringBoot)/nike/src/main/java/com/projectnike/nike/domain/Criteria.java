package com.projectnike.nike.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Criteria {

    private String startDt;
    private String endDt;

    private String type;
    private String keyword;
    private  String search; // 검색값

    private int pageNum;
    private int amount;
    
    public Criteria() {
        this(1, 5);
    }

    public Criteria(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }


    public String[] getTypeArr(){
        return  type == null ? new String[]{} : type.split(""); //빈객체를 넣어줘야한다

    }

}
