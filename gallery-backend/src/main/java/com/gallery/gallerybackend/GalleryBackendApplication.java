package com.gallery.gallerybackend;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.gallery.gallerybackend.mapper")
public class GalleryBackendApplication {

    public static void main(String[] args) {
        SpringApplication.run(GalleryBackendApplication.class, args);
    }

}
