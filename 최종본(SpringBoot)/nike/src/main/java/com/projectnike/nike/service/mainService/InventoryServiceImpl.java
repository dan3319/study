package com.projectnike.nike.service.mainService;

import com.projectnike.nike.domain.mainDomain.ImportVO;
import com.projectnike.nike.domain.mainDomain.Paging;
import com.projectnike.nike.domain.mainDomain.ProductsVO;
import com.projectnike.nike.mapper.mainMapper.InventoryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InventoryServiceImpl implements InventoryService{
    @Autowired
    private InventoryMapper mapper;

    @Override
    public List<String> getSize(){
        return mapper.getSize();
    }

    @Override
    public List<ProductsVO> getList(ProductsVO pd, Paging pg){
        return mapper.managementList(pd,pg);
    }

    public List<ImportVO> getDateList(ImportVO ip, Paging pg){
        return mapper.dateSelectList(ip, pg);
    }

    public int selectCount(ImportVO ip, Paging pg){
        return mapper.dateSelectCount(ip, pg);
    }
}
