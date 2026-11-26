package com.gallery.gallerybackend.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 收货地址表
 */
@Data
public class Address {

    private Long id;

    private Long userId;

    /** 收货人姓名 */
    private String receiver;

    /** 联系电话 */
    private String phone;

    /** 详细收货地址 */
    private String detailAddress;

    /** 是否默认地址：1是 0否 */
    private Integer isDefault;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}
