package com.gallery.gallerybackend.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 收藏表
 */
@Data
public class UserCollect {

    private Long id;

    private Long userId;

    private Long workId;

    private LocalDateTime createTime;
}
