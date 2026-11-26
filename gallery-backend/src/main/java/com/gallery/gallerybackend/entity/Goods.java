package com.gallery.gallerybackend.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 商品表（小店）
 */
@Data
public class Goods {

    private Long id;

    /** 商品名称 */
    private String name;

    /** 商品封面图URL */
    private String cover;

    /** 商品描述 */
    private String description;

    /** 单价 */
    private BigDecimal price;

    /** 库存 */
    private Integer stock;

    /** 状态：1上架 0下架 */
    private Integer status;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}
