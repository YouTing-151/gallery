package com.gallery.gallerybackend.service.impl;

import com.gallery.gallerybackend.common.BusinessException;
import com.gallery.gallerybackend.common.ResultCode;
import com.gallery.gallerybackend.common.constant.RoleConstant;
import com.gallery.gallerybackend.dto.ProfileUpdateRequest;
import com.gallery.gallerybackend.dto.ProfileVO;
import com.gallery.gallerybackend.entity.BlogProfile;
import com.gallery.gallerybackend.entity.User;
import com.gallery.gallerybackend.mapper.BlogProfileMapper;
import com.gallery.gallerybackend.mapper.UserMapper;
import com.gallery.gallerybackend.service.BlogProfileService;
import org.springframework.stereotype.Service;

/**
 * 博主主页业务实现
 */
@Service
public class BlogProfileServiceImpl implements BlogProfileService {

    private final BlogProfileMapper profileMapper;
    private final UserMapper userMapper;

    public BlogProfileServiceImpl(BlogProfileMapper profileMapper, UserMapper userMapper) {
        this.profileMapper = profileMapper;
        this.userMapper = userMapper;
    }

    @Override
    public ProfileVO getProfile() {
        User blogger = userMapper.selectByRole(RoleConstant.BLOGGER);
        if (blogger == null) {
            throw new BusinessException(ResultCode.NOT_FOUND, "博主账号不存在");
        }
        BlogProfile profile = profileMapper.selectByBloggerId(blogger.getId());
        String avatar = profile != null && profile.getAvatar() != null ? profile.getAvatar() : blogger.getAvatar();
        String backgroundImg = profile == null ? null : profile.getBackgroundImg();
        String signature = profile == null ? null : profile.getSignature();
        return new ProfileVO(blogger.getId(), blogger.getNickname(), avatar, backgroundImg, signature);
    }

    @Override
    public void updateProfile(ProfileUpdateRequest request) {
        User blogger = userMapper.selectByRole(RoleConstant.BLOGGER);
        if (blogger == null) {
            throw new BusinessException(ResultCode.NOT_FOUND, "博主账号不存在");
        }
        BlogProfile profile = profileMapper.selectByBloggerId(blogger.getId());
        if (profile == null) {
            BlogProfile newProfile = new BlogProfile();
            newProfile.setBloggerId(blogger.getId());
            newProfile.setAvatar(request.getAvatar());
            newProfile.setBackgroundImg(request.getBackgroundImg());
            newProfile.setSignature(request.getSignature());
            profileMapper.insertProfile(newProfile);
        } else {
            profile.setAvatar(request.getAvatar());
            profile.setBackgroundImg(request.getBackgroundImg());
            profile.setSignature(request.getSignature());
            profileMapper.updateProfile(profile);
        }
    }
}
