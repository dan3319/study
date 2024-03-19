package com.projectnike.nike.service.mainService;

import com.projectnike.nike.domain.mainDomain.ImportVO;
import com.projectnike.nike.domain.mainDomain.Paging;
import com.projectnike.nike.domain.mainDomain.ProductsVO;

import java.util.List;

public interface StoreService {
    public List<ProductsVO> getList(Paging pg);
    public int maxCount(String search);

    public int importInsert(ImportVO im);

    public int exportInsert(ImportVO im);

    public List<Integer> importGroup();
    public List<Integer> managementGroup();

    public void newManagement(int item_num);

    public void updateManagement(int updateNum, int quantity);

    public void totalManagement(int item_num, int quantity);

    public String maxQuantity(int item_num,String division);
}
