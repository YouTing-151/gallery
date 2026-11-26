package com.gallery.gallerybackend.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

/**
 * 登录请求：账号 + 密码 + 用户选择的身份
 */
@Data
public class LoginRequest {

    @NotBlank(message = "账号不能为空")
    private String account;

    @NotBlank(message = "密码不能为空")
    private String password;

    /** 用户选择登录的身份：blogger/admin/service/user */
    @NotBlank(message = "请选择登录身份")
    private String role;
}
