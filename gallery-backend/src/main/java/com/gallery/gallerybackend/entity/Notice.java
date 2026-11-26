package com.gallery.gallerybackend.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 站点通知表（管理员发布）
 */
@Data
public class Notice {

    private Long id;

    /** 通知标题 */
    private String title;

    /** 通知内容 */
    private String content;

    /** 发布管理员ID */
    private Long adminId;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}
