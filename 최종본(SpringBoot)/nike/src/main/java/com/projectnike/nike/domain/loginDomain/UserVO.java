package com.projectnike.nike.domain.loginDomain;

import lombok.Data;

import java.util.Date;

@Data
public class UserVO {
    private String id;
    private String pw;
    private String name;
    private String phone;
    private String email;
    private Date join_date;
}
