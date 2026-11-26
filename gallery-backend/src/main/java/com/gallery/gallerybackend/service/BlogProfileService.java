package com.gallery.gallerybackend.service;

import com.gallery.gallerybackend.dto.ProfileUpdateRequest;
import com.gallery.gallerybackend.dto.ProfileVO;

/**
 * 博主主页业务接口
 */
public interface BlogProfileService {

    /**
     * 查询博主主页信息
     */
    ProfileVO getProfile();

    /**
     * 修改博主主页信息（头像、背景图、签名）
     */
    void updateProfile(ProfileUpdateRequest request);
}
