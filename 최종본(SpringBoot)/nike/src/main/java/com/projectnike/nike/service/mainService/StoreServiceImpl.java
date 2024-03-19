package com.projectnike.nike.service.mainService;

import com.projectnike.nike.domain.mainDomain.ImportVO;
import com.projectnike.nike.domain.mainDomain.Paging;
import com.projectnike.nike.domain.mainDomain.ProductsVO;
import com.projectnike.nike.mapper.mainMapper.StoreMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StoreServiceImpl implements StoreService{
    @Autowired
    private StoreMapper mapper;

    @Override
    public List<ProductsVO> getList(Paging pg){
        return mapper.searchItems(pg);
    }

    @Override
    public int maxCount(String search){
        return mapper.searchCount(search);
    }

    @Override
    public List<Integer> importGroup(){
        return mapper.importGroup();
    }

    @Override
    public List<Integer> managementGroup(){
        return mapper.managementGroup();
    }

    @Override
    public void newManagement(int item_num){
        mapper.newManagement(item_num);
    }

    @Override
    public void updateManagement(int updateNum, int quantity){
        mapper.updateManagement(updateNum, quantity);
    }

    @Override
    public String maxQuantity(int item_num, String division){
        return mapper.maxQuantity(item_num, division);
    }

    @Override
    public void totalManagement(int item_num, int quantity){
        mapper.totalManagement(item_num, quantity);
    }

    @Override
    public int importInsert(ImportVO im){
        return mapper.importInsert(im);
    }
    @Override
    public int exportInsert(ImportVO im){
        return mapper.exportInsert(im);
    }
}
