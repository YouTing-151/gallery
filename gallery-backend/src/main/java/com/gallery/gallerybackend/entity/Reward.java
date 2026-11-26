package com.gallery.gallerybackend.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 打赏记录表
 */
@Data
public class Reward {

    private Long id;

    private Long userId;

    private Long bloggerId;

    /** 打赏金额 */
    private BigDecimal amount;

    private LocalDateTime createTime;
}
