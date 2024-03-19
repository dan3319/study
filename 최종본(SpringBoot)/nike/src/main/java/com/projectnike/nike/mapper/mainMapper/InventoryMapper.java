package com.projectnike.nike.mapper.mainMapper;

import com.projectnike.nike.domain.mainDomain.ImportVO;
import com.projectnike.nike.domain.mainDomain.Paging;
import com.projectnike.nike.domain.mainDomain.ProductsVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface InventoryMapper {
    public List<String> getSize();

    public List<ProductsVO> managementList(
            @Param("pd") ProductsVO pd,
            @Param("pg")Paging pg
    );

    public List<ImportVO> dateSelectList(@Param("ip") ImportVO ip,
                                         @Param("pg")Paging pg);
    public int dateSelectCount(@Param("ip") ImportVO ip,
                               @Param("pg")Paging pg);
}
