package com.projectnike.nike.service.loginService;

import com.projectnike.nike.domain.loginDomain.UserVO;

public interface UserService {
    public void registerUser(UserVO user);

    int checkDuplicateId(String id);

    String login(UserVO userVO);
}