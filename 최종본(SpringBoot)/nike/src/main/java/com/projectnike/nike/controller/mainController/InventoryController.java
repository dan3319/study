package com.projectnike.nike.controller.mainController;

import com.projectnike.nike.service.mainService.InventoryService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
@AllArgsConstructor
@Log4j
public class InventoryController {
    private InventoryService service;

    @GetMapping("inventory")
    public String inventory(Model model){
        List<String> size = service.getSize();
        model.addAttribute("size",size);
        return "/page/inventory";
    }

    @GetMapping("inventory2")
    public String inventory2(Model model){
        return "/page/inventory2";
    }
}
