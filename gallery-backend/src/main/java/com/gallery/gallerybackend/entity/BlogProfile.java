package com.gallery.gallerybackend.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 博主主页信息表
 */
@Data
public class BlogProfile {

    private Long id;

    /** 关联用户表ID */
    private Long bloggerId;

    /** 主页头像URL */
    private String avatar;

    /** 主页背景图URL */
    private String backgroundImg;

    /** 博主签名 / 简介 */
    private String signature;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}
