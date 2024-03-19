package com.projectnike.nike.service.mainService;

import com.projectnike.nike.domain.mainDomain.ImportVO;

import java.util.List;

public interface MainService {
    public String mainyear();

    public List<ImportVO> monthSum(String year);
}
