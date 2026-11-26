package com.gallery.gallerybackend.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 订单表（orders 规避 MySQL 保留字 order）
 */
@Data
public class Orders {

    private Long id;

    /** 订单号 */
    private String orderNo;

    private Long userId;

    private Long goodsId;

    /** 购买数量 */
    private Integer quantity;

    /** 订单总金额 */
    private BigDecimal totalAmount;

    private String receiver;

    private String phone;

    private String address;

    /** pending/paid/shipped/done/cancelled */
    private String status;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}
