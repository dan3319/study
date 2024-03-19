package com.projectnike.nike.controller;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Log4j
@Controller
@AllArgsConstructor
public class BoardController {
    @GetMapping("header")
    public String header(){
        log.info("header 호출");
        return "/includes/header";
    }
}
