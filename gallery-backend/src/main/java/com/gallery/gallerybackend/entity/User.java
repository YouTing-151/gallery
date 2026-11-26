package com.gallery.gallerybackend.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 用户表：账号唯一，昵称可重复；role 绑定账号角色
 */
@Data
public class User {

    /** 主键ID */
    private Long id;

    /** 登录账号（唯一） */
    private String account;

    /** 登录密码（加密存储，接口返回时忽略） */
    @JsonIgnore
    private String password;

    /** 昵称（允许重名） */
    private String nickname;

    /** 身份编号，如 BG10001 */
    private String userCode;

    /** 角色：blogger/admin/service/user */
    private String role;

    /** 头像URL */
    private String avatar;

    /** 状态：1正常 0已拉黑 */
    private Integer status;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}
