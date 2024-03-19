package com.projectnike.nike.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Criteria {
    private String type;    // 옵션
    private  String search; // 검색값
    private int pageNum;        // 페이지 수
    private int amount;         // 한 페이지에 보여질 게시글

    public Criteria() {
        this(1, 10);
    }

    public Criteria(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }

    public String[] getTypeArr() { return type == null ? new String[] {} : type.split("");}
}
