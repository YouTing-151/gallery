package com.gallery.gallerybackend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * 登录成功返回的用户信息（不含密码）
 */
@Data
@AllArgsConstructor
public class LoginResponse {

    private Long id;

    private String account;

    private String nickname;

    private String userCode;

    private String role;

    private String avatar;
}
