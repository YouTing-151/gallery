package com.gallery.gallerybackend.entity;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 合集表：parentId 自关联，支持无限嵌套
 */
@Data
public class Collection {

    private Long id;

    /** 合集名称 */
    private String name;

    /** 父合集ID，0 为一级合集 */
    private Long parentId;

    /** 排序号，越小越靠前 */
    private Integer sort;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    /** 子合集列表（树形结构组装时使用，不映射数据库字段） */
    private List<Collection> children;
}
