package com.projectnike.nike.controller.productController;

import com.projectnike.nike.domain.Criteria;
import com.projectnike.nike.domain.PageDTO;
import com.projectnike.nike.domain.productDomain.ProductListVO;
import com.projectnike.nike.service.productService.ProductListService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Log4j
@Controller
@AllArgsConstructor
public class ProductListController {
    // 공지사항 리스트
    @Autowired
    private ProductListService productListService;

    @GetMapping("/productList")
    public String productList(Criteria cri, Model model) {
        List<ProductListVO> productListVOList = productListService.getListWithPaging(cri);

        model.addAttribute("productListVOList", productListVOList);

        PageDTO pageDTO = new PageDTO(cri,productListService.getTotalCount(cri) );
        model.addAttribute("pageMaker", pageDTO);
        model.addAttribute("criteria", cri);

        return "/productPage/productList";
    }

    // 글 작성란
    @GetMapping("/productInsertForm")
    public String productInsertForm() {
        return "/productPage/productInsertForm";
    }

    // 글 작성 DB로 보내기
    @PostMapping("/productInsert")
    public String productInsert(
            @RequestParam("item_num") int item_num,
            @RequestParam("gender") String gender,
            @RequestParam("category") String category,
            @RequestParam("item_type") String item_type,
            @RequestParam("item_name") String item_name,
            @RequestParam("item_size") String item_size,
            @RequestParam("color") String color,
            @RequestParam("price") int price,
            RedirectAttributes rttr
    ) {
        // 실제 DB에 텍스트 데이터 저장
        int rtn = productListService.insertProduct(item_num, gender, category, item_type, item_name, item_size, color, price);
        rttr.addFlashAttribute("insertSuccessCount", rtn);

        return "redirect:/productList";
    }
    // 글 삭제
    @PostMapping("/productDelete")
    public String productDelete(@RequestParam("num") int num, RedirectAttributes rttr) {
        int rtn = productListService.deleteProduct(num);
        rttr.addFlashAttribute("deleteSuccessCount", rtn);

        return "redirect:/productList";
    }
}