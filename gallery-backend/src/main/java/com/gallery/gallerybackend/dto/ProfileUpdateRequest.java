package com.gallery.gallerybackend.dto;

import lombok.Data;

/**
 * 修改博主主页请求
 */
@Data
public class ProfileUpdateRequest {

    /** 主页头像URL */
    private String avatar;

    /** 主页背景图URL */
    private String backgroundImg;

    /** 博主签名 / 简介 */
    private String signature;
}
