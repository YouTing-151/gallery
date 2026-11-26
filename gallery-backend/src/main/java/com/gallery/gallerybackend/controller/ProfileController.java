package com.gallery.gallerybackend.controller;

import com.gallery.gallerybackend.common.Result;
import com.gallery.gallerybackend.dto.ProfileUpdateRequest;
import com.gallery.gallerybackend.dto.ProfileVO;
import com.gallery.gallerybackend.service.BlogProfileService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 博主主页接口
 */
@RestController
@RequestMapping("/api/profile")
public class ProfileController {

    private final BlogProfileService profileService;

    public ProfileController(BlogProfileService profileService) {
        this.profileService = profileService;
    }

    /**
     * 查询博主主页
     */
    @GetMapping
    public Result<ProfileVO> getProfile() {
        return Result.success(profileService.getProfile());
    }

    /**
     * 修改博主主页（头像、背景图、签名）
     */
    @PutMapping
    public Result<Void> updateProfile(@RequestBody ProfileUpdateRequest request) {
        profileService.updateProfile(request);
        return Result.success();
    }
}
