package com.projectnike.nike.mapper.UserMapper;

import com.projectnike.nike.domain.loginDomain.UserVO;

public interface UserMapper {
    void insertUser(UserVO user);

    int checkDuplicateId(String id);

    UserVO getUser(UserVO userVO);
}