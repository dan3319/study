package com.projectnike.nike.mapper.mainMapper;

import com.projectnike.nike.domain.mainDomain.ImportVO;

import java.util.List;

public interface MainMapper {
    public String getYear();
    public List<ImportVO> getSalesSum(String year);
}
