package com.projectnike.nike.service;

import com.projectnike.nike.config.DBConfig;
import com.projectnike.nike.domain.mainDomain.Paging;
import com.projectnike.nike.service.mainService.StoreService;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {DBConfig.class})
@Log4j
public class StoreServiceTests {
    @Autowired
    private StoreService service;

    @Test
    public void testSearch(){
        Paging pg = new Paging();
        log.info(service.getList(pg));
    }
}
