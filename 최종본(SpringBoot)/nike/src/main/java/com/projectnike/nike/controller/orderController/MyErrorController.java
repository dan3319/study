package com.projectnike.nike.controller.orderController;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MyErrorController implements ErrorController {
    @RequestMapping("/error") //"/error"는 Spring Framework의 기본 에러 핸들러가 동작하는 경로
    public String handleError(HttpServletRequest request) {
        return "404";
    }
}