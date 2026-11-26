package com.gallery.gallerybackend.service;

import com.gallery.gallerybackend.dto.LoginRequest;
import com.gallery.gallerybackend.dto.LoginResponse;

/**
 * 用户业务接口
 */
public interface UserService {

    /**
     * 登录：校验账号密码，并校验所选身份与账号绑定角色一致
     */
    LoginResponse login(LoginRequest request);
}
