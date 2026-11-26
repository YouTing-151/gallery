package com.gallery.gallerybackend.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 点赞表
 */
@Data
public class UserLike {

    private Long id;

    private Long userId;

    private Long workId;

    private LocalDateTime createTime;
}
