package com.gallery.gallerybackend.mapper;

import com.gallery.gallerybackend.entity.BlogProfile;
import org.apache.ibatis.annotations.Param;

/**
 * 博主主页 Mapper
 */
public interface BlogProfileMapper {

    /**
     * 按博主ID查询主页信息
     */
    BlogProfile selectByBloggerId(@Param("bloggerId") Long bloggerId);

    /**
     * 更新主页信息（头像、背景图、签名）
     */
    int updateProfile(BlogProfile profile);

    /**
     * 新增主页信息
     */
    int insertProfile(BlogProfile profile);
}
