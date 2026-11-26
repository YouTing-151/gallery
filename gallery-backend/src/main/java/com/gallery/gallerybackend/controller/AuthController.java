package com.gallery.gallerybackend.controller;

import com.gallery.gallerybackend.common.Result;
import com.gallery.gallerybackend.dto.LoginRequest;
import com.gallery.gallerybackend.dto.LoginResponse;
import com.gallery.gallerybackend.service.UserService;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 登录认证接口
 */
@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    /**
     * 登录：账号 + 密码 + 所选身份
     */
    @PostMapping("/login")
    public Result<LoginResponse> login(@Valid @RequestBody LoginRequest request) {
        return Result.success(userService.login(request));
    }
}
