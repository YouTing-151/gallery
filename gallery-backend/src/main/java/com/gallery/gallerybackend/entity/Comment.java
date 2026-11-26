package com.gallery.gallerybackend.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 评论表
 */
@Data
public class Comment {

    private Long id;

    /** 所属作品ID */
    private Long workId;

    /** 评论用户ID */
    private Long userId;

    /** 评论内容 */
    private String content;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}
