package com.projectnike.nike.mapper.mainMapper;

import com.projectnike.nike.domain.mainDomain.ImportVO;
import com.projectnike.nike.domain.mainDomain.Paging;
import com.projectnike.nike.domain.mainDomain.ProductsVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StoreMapper {
    public List<ProductsVO> searchItems(@Param("pg") Paging pg);
    public int searchCount(String search);

    public int importInsert(@Param("im")ImportVO im);

    public int exportInsert(@Param("im")ImportVO im);

    public List<Integer> importGroup();
    public List<Integer> managementGroup();
    public void newManagement(int item_num);

    public void updateManagement(@Param("updateNum") int updateNum, @Param("quantity")int quantity);

    public void totalManagement(@Param("item_num")int item_num, @Param("quantity")int quantity);

    public String maxQuantity(@Param("item_num") int item_num,@Param("division") String division);
}
