package com.projectnike.nike.controller.orderController;

import com.projectnike.nike.domain.Criteria;
import com.projectnike.nike.domain.orderDomain.OrderVO;
import com.projectnike.nike.domain.PageDTO;
import com.projectnike.nike.domain.orderDomain.ReplyVO;
import com.projectnike.nike.service.orderService.OrderService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.util.List;

@Controller
@Log4j
@AllArgsConstructor
public class OrderProductController {

    @Autowired
    private OrderService orderService;

    @GetMapping("/orderList")
    public String orderList(Criteria cri, Model model) {
        log.info("list");

        List<OrderVO> orderVOList = orderService.getOrderPageList(cri);
        model.addAttribute("orderVOList", orderVOList);
        model.addAttribute("criteria", cri);

        PageDTO pageDTO = new PageDTO(cri, orderService.getTotalCount(cri));
        model.addAttribute("pageMaker", pageDTO);
        model.addAttribute("criteria", cri);

        List<ReplyVO> replyVOList = orderService.getReply();
        model.addAttribute("replyVOList", replyVOList);

        return "/orderPage/orderList";
    }

    @PostMapping("/orderProductDelete")
    public String orderProductDelete(@RequestParam("num") int num, RedirectAttributes rttr){

        int rtn = orderService.deleteList(num);
        rttr.addFlashAttribute("deleteSuccessCount", rtn);

        return "redirect:/orderList";
    }


    @GetMapping("/orderProductInsertForm")
    public String orderProductInsertForm(){
        return "/orderPage/orderProductInsertForm";
    }



    @GetMapping("/orderProductUpdateForm")
    public String orderProductUpdateForm(@RequestParam("num") int num, Model model){
        OrderVO orderVO = orderService.getOneList(num);
        model.addAttribute("order", orderVO);

        return "/orderPage/orderProductUpdateForm";
    }

    @PostMapping("/orderProductInsert")
    public String orderProductInsert(
            @RequestParam("fileContent") MultipartFile fileContent,
            @RequestParam("requester") String requester,
            @RequestParam("brand") String brand,
            @RequestParam("type") String type,
            @RequestParam("place") String place,
            @RequestParam("name") String name,
            @RequestParam("size") String size,
            @RequestParam("quantity") int quantity,
            @RequestParam(value = "chest", defaultValue = "0") int chest,
            @RequestParam(value = "front", defaultValue = "0") int front,
            @RequestParam(value = "sleeve", defaultValue = "0") int sleeve,
            @RequestParam(value = "back", defaultValue = "0") int back,
            @RequestParam(value = "arm", defaultValue = "0") int arm,
            @RequestParam("requirements") String requirements,
            @RequestParam("details") String details,
            RedirectAttributes rttr
    ) {
        String uploadFolder = "C:\\SpringBoot\\project-spring\\src\\main\\resources\\static\\upload-files";

        String fileName = "";
        if (fileContent != null && !fileContent.isEmpty()) { // 파일이 존재하고 비어 있지 않은지 확인합니다.
            log.info("--------");
            log.info("Upload file name: " + fileContent.getOriginalFilename());
            log.info("Upload file size: " + fileContent.getSize());

            fileName = fileContent.getOriginalFilename(); // 파일 이름을 가져와 변수에 저장합니다.

            File saveFile = new File(uploadFolder, fileName);
            try {
                fileContent.transferTo(saveFile); // 파일을 저장합니다.
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }

        int rtn = orderService.insertList(requester, brand, type, place, name, size, quantity, chest, front, sleeve, back, arm, requirements, details, fileName);
        rttr.addFlashAttribute("insertSuccessCount", rtn);
        return "redirect:/orderList";
    }

    @PostMapping("/orderProductUpdate")
    public String orderProductUpdate(
            @RequestParam("requester") String requester,
            @RequestParam("brand") String brand,
            @RequestParam("type") String type,
            @RequestParam("place") String place,
            @RequestParam("name") String name,
            @RequestParam("size") String size,
            @RequestParam("quantity") int quantity,
            @RequestParam(value = "chest", defaultValue = "0") int chest,
            @RequestParam(value = "front", defaultValue = "0") int front,
            @RequestParam(value = "sleeve", defaultValue = "0") int sleeve,
            @RequestParam(value = "back", defaultValue = "0") int back,
            @RequestParam(value = "arm", defaultValue = "0") int arm,
            @RequestParam("requirements") String requirements,
            @RequestParam("details") String details,
            @RequestParam("fileContent") MultipartFile fileContent,
            @RequestParam("num") int num,
            RedirectAttributes rttr
    ){

        int rtn = orderService.updateList(
                requester, brand, type, place, name, size,
                quantity, chest, front, sleeve, back, arm, requirements, details,
                fileContent.getOriginalFilename(), num);

        rttr.addFlashAttribute("updateSuccessCount", rtn);
        return "redirect:/orderList";

    }


    @PostMapping("/commentInsert")
    public String commentInsert(
            @RequestParam("num") int num,
            @RequestParam("commenter") String commenter,
            @RequestParam("content") String content,
            RedirectAttributes rttr

    ){
        int rtn = orderService.insertReply(num, commenter, content);
        rttr.addFlashAttribute("insertSuccessCount", rtn);
        return "redirect:/orderList";
    }

    @PostMapping("/updateStatus")
    public String updateStatus(
            @RequestParam("status") String status,
            @RequestParam("num") int num,
            RedirectAttributes rttr
    ){
        int rtn = orderService.updateStatus(status, num);
        rttr.addFlashAttribute("updateSuccessCount", rtn);
        return "redirect:/orderList";
    }

}