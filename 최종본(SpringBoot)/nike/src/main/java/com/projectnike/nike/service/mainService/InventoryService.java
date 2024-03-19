package com.projectnike.nike.service.mainService;

import com.projectnike.nike.domain.mainDomain.ImportVO;
import com.projectnike.nike.domain.mainDomain.Paging;
import com.projectnike.nike.domain.mainDomain.ProductsVO;

import java.util.List;

public interface InventoryService {
    public List<String> getSize();

    public List<ProductsVO> getList(ProductsVO pd, Paging pg);

    public List<ImportVO> getDateList(ImportVO ip, Paging pg);

    public int selectCount(ImportVO ip, Paging pg);
}
