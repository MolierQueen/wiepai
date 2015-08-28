//
//  AddView.m
//  微拍视频
//
//  Created by 张宁浩 on 15/8/27.
//  Copyright (c) 2015年 Oliver. All rights reserved.
//

#import "AddView.h"
#import "SVProgressHUD.h"
@implementation AddView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUIWithFrame:frame];
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    }
    return self;
}

#pragma mark - 初始化视图
- (void) initUIWithFrame:(CGRect)frame
{
    _titleText = [self createTextFieldWithPlaceHolder:@"请输入标题"
                                             andFrame:CGRectMake(0,0,frame.size.width / 2,30)
                                            andCenter:CGPointMake(frame.size.width/2, 150)];
    
    _url = [self createTextFieldWithPlaceHolder:@"请输入网址"
                                                           andFrame:CGRectMake(0,0,frame.size.width / 2,30)
                                                          andCenter:CGPointMake(frame.size.width/2, 220)];
    
    _sureBtn = [self createButtonWithTitle:@"确定添加"
                                                   andFrame:CGRectMake(0, 0, frame.size.width/ 2, 30)
                                                  andCenter:CGPointMake(frame.size.width / 2, 290)
                                                  andAction:@selector(buttonAction:)];
    
    _canaelBtn = [self createButtonWithTitle:@"取   消"
                                  andFrame:CGRectMake(0, 0, frame.size.width / 2, 30)
                                 andCenter:CGPointMake(frame.size.width / 2, 360)
                                 andAction:@selector(buttonAction:)];
    
}

#pragma  mark - 创建TExtField
- (UITextField *) createTextFieldWithPlaceHolder:(NSString *) placeHolder
                                                                 andFrame:(CGRect) frame
                                                                andCenter:(CGPoint)center
{
    UITextField * text = [[UITextField alloc] initWithFrame:frame];
    [text setCenter:center];
    [text setPlaceholder:placeHolder];
    [text setBackgroundColor:[UIColor whiteColor]];
    [text setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:text];
    return  text;
}

#pragma  mark - 创建UIButton
-(UIButton *)createButtonWithTitle:(NSString*)title
                                          andFrame:(CGRect)frame
                                         andCenter:(CGPoint)center
                                         andAction:(SEL)buttonAction
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setCenter:center];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:buttonAction forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button.layer setBorderWidth:1];
    [button.layer setBorderColor:[UIColor whiteColor].CGColor];
    [button.layer setCornerRadius:5];
    [button setClipsToBounds:YES];
    [self addSubview:button];
    return button;
}

#pragma mark - 点击事件
- (void) buttonAction:(UIButton *) sender
{
    if ([sender.currentTitle isEqualToString:@"确定添加"]) {
        if ([_titleText.text isEqualToString:@""] || [_url.text isEqualToString:@""]) {
            [SVProgressHUD showErrorWithStatus:@"信息不完整" duration:1];
        } else {
            NSLog(@"确定");
         self.textInfo(_titleText.text, _url.text);
            [self customRemoveFromSuperview];
        }
    } else {
        NSLog(@"取消");
        [self customRemoveFromSuperview];
    }
}

#pragma mark - 收回
- (void) customRemoveFromSuperview
{
    [UIView animateWithDuration:0.3 animations:^{
        [self setAlpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
