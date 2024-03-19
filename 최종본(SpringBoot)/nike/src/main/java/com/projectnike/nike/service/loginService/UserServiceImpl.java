package com.projectnike.nike.service.loginService;

import com.projectnike.nike.domain.loginDomain.UserVO;
import com.projectnike.nike.mapper.UserMapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    @Autowired
    public UserServiceImpl(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    @Override
    public void registerUser(UserVO user) {
        try {
            userMapper.insertUser(user);
            // 가입 성공 시 처리할 로직
        } catch (Exception e) {
            // 가입 실패 시 처리할 로직
            e.printStackTrace(); // 에러 로그 출력
        }
    }

    @Override
    public String login(UserVO userVO) {
        UserVO user = userMapper.getUser(userVO);

        if (user != null) {
            userVO.setName(user.getName());
            userVO.setEmail(user.getEmail());
            userVO.setPhone(user.getPhone());
            return "success";
        } else {
            return "아이디 또는 비밀번호가 잘못되었습니다.";
        }
    }

    @Override
    public int checkDuplicateId(String id) {
        return userMapper.checkDuplicateId(id);
    }
}
