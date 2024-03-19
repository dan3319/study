package com.projectnike.nike.controller.loginController;

import com.projectnike.nike.domain.loginDomain.UserVO;
import com.projectnike.nike.service.loginService.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
@RequestMapping(value="user")
public class UserController {
    private UserService userService;

    @ResponseBody
    @GetMapping("/idCheck")
    public int checkDuplicateId(@RequestParam String id) {
        return userService.checkDuplicateId(id);
    }

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/registerResult")
    public String showResult(Model model, String message, String redirectUrl) {
        model.addAttribute("message", message);
        model.addAttribute("redirectUrl", redirectUrl);
        return "/loginPage/registerResult";
    }

    @GetMapping("/index")
    public String index() {
        return "/loginPage/index";
    }

    @GetMapping("/sign_up_form")
    public String signup() {
        return "/loginPage/sign_up";
    }

    @PostMapping("/sign_up")
    public String signUp(@RequestParam String id,
                         @RequestParam String pw,
                         @RequestParam String name,
                         @RequestParam String phone,
                         @RequestParam String email,
                         Model model) {

        try {
            UserVO userVO = new UserVO();
            userVO.setId(id);
            userVO.setPw(pw);
            userVO.setName(name);
            userVO.setPhone(phone);
            userVO.setEmail(email);

            userService.registerUser(userVO);
            model.addAttribute("message", "가입 완료되었습니다.");
            model.addAttribute("join", "/user/index");
        } catch (Exception e) {
            model.addAttribute("message", "가입 실패하였습니다.");
            model.addAttribute("join", "/user/sign_up_form");
        }
        return "/loginPage/registerResult";
    }

    @PostMapping("/login")
    public String login(HttpServletRequest request, UserVO userVO, Model model) {
        String result = userService.login(userVO);
        if (result.equals("success")) {
            HttpSession session = request.getSession();
            session.setAttribute("id", userVO.getId());
            session.setAttribute("name", userVO.getName());
            session.setAttribute("email", userVO.getEmail());
            session.setAttribute("phone", userVO.getPhone());

            session.setAttribute("successMessage", userVO.getId() + "님 로그인에 성공했습니다.");
            return "redirect:/main";
        } else {
            request.setAttribute("errorMessage", "아이디 또는 비밀번호가 잘못되었습니다.");
            return "/loginPage/index";
        }
    }

    @GetMapping("/manageredit")
    public String manageredit() {
        return "/loginPage/manageredit";
    }

    @PostMapping("/update_profile")
    public String update_profile() {
        return "/loginPage/update_profile";
    }

    @GetMapping("/main")
    public String main() {
        return "main";
    }

    @GetMapping("/find_id_pw")
    public String find_id_pw() {
        return "/loginPage/find_id_pw";
    }

    @PostMapping("/find_id_process")
    public String find_id_process() {
        return "/loginPage/find_id_process";
    }

    @PostMapping("/find_pw_process")
    public String find_pw_process() {
        return "/loginPage/find_pw_process";
    }

    @GetMapping("/logout")
    public String logout() {
        return "/loginPage/logout";
    }

    @GetMapping("/menu")
    public String menu() {
        return "/loginPage/menu";
    }

    @PostMapping("/sign_up_insert")
    public String sign_up_insert (UserVO user){
        userService.registerUser(user);
        return "redirect:/user/index";
    }

}
