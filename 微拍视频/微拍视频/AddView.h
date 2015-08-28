//
//  AddView.h
//  微拍视频
//
//  Created by 张宁浩 on 15/8/27.
//  Copyright (c) 2015年 Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^blocktextInfo)(NSString * title, NSString* url);
@interface AddView : UIView
@property (nonatomic, strong) UITextField * titleText;
@property (nonatomic, strong) UITextField * url;
@property (nonatomic, copy) NSString * imageName;
@property (nonatomic, strong) UIButton * sureBtn;
@property (nonatomic, strong) UIButton * canaelBtn;
@property (nonatomic, copy) blocktextInfo textInfo;
@end
