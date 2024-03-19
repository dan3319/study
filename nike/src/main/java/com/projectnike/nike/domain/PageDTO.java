package com.humanedu.firstproject.domain;

import com.projectnike.nike.domain.Criteria;
import lombok.Getter;
import lombok.ToString;

import java.util.Map;

@Getter
@ToString
public class PageDTO {

    private int startPage = 1;          // 시작 페이지
    private int endPage;                // 끝 페이지

    private int total;                  // 총 게시글 수
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
