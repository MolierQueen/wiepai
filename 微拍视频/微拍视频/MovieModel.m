//
//  MovieModel.m
//  微拍视频
//
//  Created by Oliver on 15/8/27.
//  Copyright (c) 2015年 Oliver. All rights reserved.
//

#import "MovieModel.h"

@implementation MovieModel
- (id) initWithPic:(NSString *)picName
     andTitle:(NSString * )title
      andTime:(NSString *)time
  andVideoUrl:(NSString*)videoUrl {
    if ([super init]) {
        _pic = picName;
        _title = title;
        _time = time;
        _url = videoUrl;
    }
    return self;
}

@end
