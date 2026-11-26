package com.gallery.gallerybackend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * 博主主页展示信息
 */
@Data
@AllArgsConstructor
public class ProfileVO {

    private Long bloggerId;

    private String nickname;

    private String avatar;

    private String backgroundImg;

    private String signature;
}
