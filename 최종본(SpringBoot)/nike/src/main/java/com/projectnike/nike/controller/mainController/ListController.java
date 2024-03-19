package com.projectnike.nike.controller.mainController;

import com.projectnike.nike.domain.mainDomain.ImportVO;
import com.projectnike.nike.domain.mainDomain.Paging;
import com.projectnike.nike.domain.mainDomain.ProductsVO;
import com.projectnike.nike.service.mainService.InventoryService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@AllArgsConstructor
public class ListController {
    private InventoryService service;

    @GetMapping(value = "/search/{category}/{itemname}/{itemsize}/page/{page}/pagesize/{pagesize}"
            ,produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<List<ProductsVO>> getList(@PathVariable("page")int page,
                                                    @PathVariable("pagesize")int pagesize,
                                                    @PathVariable("category")String category,
                                                    @PathVariable("itemname")String itemName,
                                                    @PathVariable("itemsize")String itemSize){
        if(category.equals("010")){
            category="";
        }
        if(itemName.equals("010")){
            itemName="";
        }
        if(itemSize.equals("010")){
            itemSize="";
        }
        ProductsVO pd = new ProductsVO();
        pd.setCategory(category);
        pd.setItem_name(itemName);
        pd.setItem_size(itemSize);
        Paging pg = new Paging();
        pg.setPageNum(page);
        pg.setPageSize(pagesize);

        return new ResponseEntity<>(service.getList(pd,pg), HttpStatus.OK);
    }

    @GetMapping(value = "/search2/{category}/{itemname}/{division}/page/{page}/{pagesize}/date/{startDate}/{endDate}"
            ,produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<List<ImportVO>> getList2(@PathVariable("page")int page,
                                                  @PathVariable("pagesize")int pagesize,
                                                  @PathVariable("category")String category,
                                                  @PathVariable("itemname")String itemName,
                                                  @PathVariable("division")String division,
                                                  @PathVariable("startDate")String startDate,
                                                  @PathVariable("endDate")String endDate){
        if(category.equals("010")){
            category="";
        }
        if(itemName.equals("010")){
            itemName="";
        }
        if(division.equals("010")){
            division="";
        }
        if(startDate.equals("010")){
            startDate=null;
        }
        if(endDate.equals("010")){
            endDate=null;
        }

        ImportVO ip = new ImportVO();
        ip.setCategory(category);
        ip.setItem_name(itemName);
        ip.setDivision(division);
        Paging pg = new Paging();
        pg.setPageNum(page);
        pg.setPageSize(pagesize);
        pg.setStartDate(startDate);
        pg.setEndDate(endDate);

        return new ResponseEntity<>(service.getDateList(ip,pg), HttpStatus.OK);
    }

    @GetMapping(value = "/searchcount/{category}/{itemname}/{division}/date/{startDate}/{endDate}"
            ,produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<Integer> getListCount(
                                                   @PathVariable("category")String category,
                                                   @PathVariable("itemname")String itemName,
                                                   @PathVariable("division")String division,
                                                   @PathVariable("startDate")String startDate,
                                                   @PathVariable("endDate")String endDate){
        if(category.equals("010")){
            category="";
        }
        if(itemName.equals("010")){
            itemName="";
        }
        if(division.equals("010")){
            division="";
        }
        if(startDate.equals("010")){
            startDate=null;
        }
        if(endDate.equals("010")){
            endDate=null;
        }

        ImportVO ip = new ImportVO();
        ip.setCategory(category);
        ip.setItem_name(itemName);
        ip.setDivision(division);
        Paging pg = new Paging();
        pg.setStartDate(startDate);
        pg.setEndDate(endDate);

        return new ResponseEntity<>(service.selectCount(ip,pg), HttpStatus.OK);
    }
}
