package com.projectnike.nike.mapper;

import com.projectnike.nike.config.DBConfig;
import com.projectnike.nike.domain.mainDomain.Paging;
import com.projectnike.nike.domain.mainDomain.ProductsVO;
import com.projectnike.nike.mapper.mainMapper.InventoryMapper;
import com.projectnike.nike.mapper.mainMapper.StoreMapper;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

@RunWith(SpringRunner.class)
@ContextConfiguration(classes = {DBConfig.class})
@Log4j
public class StoreMapperTests {
    @Autowired
    private StoreMapper mapper;
    @Autowired
    private InventoryMapper inventoryMapper;

    @Test
    public void searchTest(){
        String search="";
        Paging pg = new Paging();
        List<ProductsVO> vo = mapper.searchItems(pg);
    }

    @Test
    public void searchTest2(){
        ProductsVO text = new ProductsVO();
        text.setCategory("");
        text.setItem_name("");
        text.setItem_size("");
        Paging pg = new Paging();
        pg.setPageNum(1);
        pg.setPageSize(3);

        List<ProductsVO> vo = inventoryMapper.managementList(text,pg);
    }
}
