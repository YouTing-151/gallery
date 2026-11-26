package com.gallery.gallerybackend.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 作品表：图文 image / 视频 video / 音频 audio
 */
@Data
public class Work {

    private Long id;

    /** 所属合集ID */
    private Long collectionId;

    /** 作品标题 */
    private String title;

    /** 作品简介 / 正文 */
    private String content;

    /** 作品类型：image/video/audio */
    private String type;

    /** 封面图URL */
    private String coverUrl;

    /** 作品资源文件URL */
    private String resourceUrl;

    /** 点赞数 */
    private Integer likeCount;

    /** 收藏数 */
    private Integer collectCount;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}
