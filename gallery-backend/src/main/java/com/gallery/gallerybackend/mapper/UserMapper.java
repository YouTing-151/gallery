package com.gallery.gallerybackend.mapper;

import com.gallery.gallerybackend.entity.User;
import org.apache.ibatis.annotations.Param;

/**
 * 用户表 Mapper
 */
public interface UserMapper {

    /**
     * 按登录账号查询用户
     */
    User selectByAccount(@Param("account") String account);

    /**
     * 按主键查询用户
     */
    User selectById(@Param("id") Long id);

    /**
     * 按角色查询用户（单博主站点取唯一博主账号）
     */
    User selectByRole(@Param("role") String role);
}
