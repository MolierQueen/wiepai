//
//  MovieModel.h
//  微拍视频
//
//  Created by Oliver on 15/8/27.
//  Copyright (c) 2015年 Oliver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModel : NSObject
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * time;
@property (nonatomic, copy) NSString * pic;
@property (nonatomic, copy) NSString * url;

/**
 *创建model
 *@picName视频图片名
 *@picName视频标题
 *@picName视频创建时间
 *@picName视频地址
 */
- (id) initWithPic:(NSString *)picName
            andTitle:(NSString * )title
             andTime:(NSString *)time
         andVideoUrl:(NSString*)videoUrl;
@end
