package com.projectnike.nike.controller.mainController;

import com.projectnike.nike.domain.mainDomain.ImportVO;
import com.projectnike.nike.domain.mainDomain.Paging;
import com.projectnike.nike.domain.mainDomain.ProductsVO;
import com.projectnike.nike.service.mainService.StoreService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@AllArgsConstructor
public class StoreController {
    private StoreService service;

    @GetMapping(value="/board/{search}/pageNum/{pageNum}/pageSize/{pageSize}", produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<List<ProductsVO>>getList(
                                            @PathVariable("search")String search,
                                            @PathVariable("pageNum")int pageNum,
                                            @PathVariable("pageSize")int pageSize
                                            ){
        if(search.equals("010")){
            search="";
        }
        int count = service.maxCount(search);
        int totalPage = (int)(Math.ceil((double)count/pageSize));
        if(pageNum>totalPage){
            pageNum=totalPage;
        }
        if(pageNum<=0){
            pageNum=1;
        }

        Paging pg = new Paging(search,pageNum,pageSize);
        return new ResponseEntity<>(service.getList(pg), HttpStatus.OK);
    }

    @GetMapping(value="/{search}/pageSize/{pageSize}", produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<Integer>maxPage(@PathVariable("search")String search,
                                          @PathVariable("pageSize")int pageSize){
        if(search.equals("010")){
            search="";
        }
        int count = service.maxCount(search);
        int totalPage = (int)(Math.ceil((double)count/pageSize));

        return new ResponseEntity<>(totalPage, HttpStatus.OK);
    }

    @PostMapping(value = "/new", consumes = "application/json",produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<String> create(@RequestBody ImportVO im){
        int insertCount=0;
        if(im.getDivision().equals("입고")){
            insertCount = service.importInsert(im);
        } else if(im.getDivision().equals("출고")){
            insertCount = service.exportInsert(im);
        }

        return insertCount==1? new ResponseEntity<>("성공",HttpStatus.OK):
                                new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping(value = "/group", produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<Integer>group(){
        List<Integer> importGroup = service.importGroup();
        List<Integer> managementGroup = service.managementGroup();
        List<Integer> update = new ArrayList<>();

        for(int i=0;i<importGroup.size();i++){
            for (int j=0;j<managementGroup.size();j++){
                if(importGroup.get(i).equals(managementGroup.get(j))){
                    update.add(importGroup.get(i));
                    importGroup.set(i,0);
                }
            }
        }
        for(int i=0;i<importGroup.size();i++){
            if(importGroup.get(i)!=0){
                service.newManagement(importGroup.get(i));
            }
        }
        String quantity="";
        for(int i=0;i<update.size();i++){
            quantity = service.maxQuantity(update.get(i),"import");
            if(quantity==null){
                quantity="0";
            }
            service.updateManagement(update.get(i),Integer.parseInt(quantity));
        }

        for(int i=0;i<managementGroup.size();i++){
            quantity = service.maxQuantity(managementGroup.get(i),"export");
            if(quantity==null){
                quantity="0";
            }
            System.out.println("출고"+quantity);
            service.totalManagement(managementGroup.get(i),Integer.parseInt(quantity));
        }

        return new ResponseEntity<>(1,HttpStatus.OK);
    }
}