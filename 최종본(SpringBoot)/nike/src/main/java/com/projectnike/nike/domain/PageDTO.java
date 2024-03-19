package com.projectnike.nike.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {

    private int startPage = 1;
    private int endPage;

    private int total;
    private Criteria cri;

    public PageDTO(Criteria cri, int total){
        this.cri = cri;
        this.total = total;

        this.endPage = (int)(Math.ceil(total / cri.getAmount()));

        int realEnd = (int)(Math.ceil((total * 1.0) / cri.getAmount()));

        if(realEnd > this.endPage){
            this.endPage = realEnd;
        }
    }
}
