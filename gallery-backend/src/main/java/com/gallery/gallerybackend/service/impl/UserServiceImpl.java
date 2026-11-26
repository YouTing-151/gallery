package com.gallery.gallerybackend.service.impl;

import com.gallery.gallerybackend.common.BusinessException;
import com.gallery.gallerybackend.common.ResultCode;
import com.gallery.gallerybackend.dto.LoginRequest;
import com.gallery.gallerybackend.dto.LoginResponse;
import com.gallery.gallerybackend.entity.User;
import com.gallery.gallerybackend.mapper.UserMapper;
import com.gallery.gallerybackend.service.UserService;
import com.gallery.gallerybackend.util.PasswordUtil;
import org.springframework.stereotype.Service;

/**
 * 用户业务实现
 */
@Service
public class UserServiceImpl implements UserService {

    private final UserMapper userMapper;

    public UserServiceImpl(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    @Override
    public LoginResponse login(LoginRequest request) {
        // 1. 按账号查询用户
        User user = userMapper.selectByAccount(request.getAccount());
        if (user == null) {
            throw new BusinessException(ResultCode.UNAUTHORIZED, "账号或密码错误");
        }

        // 2. 校验密码（BCrypt）
        if (!PasswordUtil.matches(request.getPassword(), user.getPassword())) {
            throw new BusinessException(ResultCode.UNAUTHORIZED, "账号或密码错误");
        }

        // 3. 校验账号状态（是否被拉黑）
        if (user.getStatus() == null || user.getStatus() == 0) {
            throw new BusinessException(ResultCode.FORBIDDEN, "账号已被拉黑，无法登录");
        }

        // 4. 身份一致性校验：所选身份必须与账号绑定角色一致
        if (!user.getRole().equals(request.getRole())) {
            throw new BusinessException(ResultCode.UNAUTHORIZED, "选择的身份与账号不符");
        }

        return new LoginResponse(
                user.getId(),
                user.getAccount(),
                user.getNickname(),
                user.getUserCode(),
                user.getRole(),
                user.getAvatar()
        );
    }
}
