//
//  CustomTableViewCell.h
//  微拍视频
//
//  Created by Oliver on 15/8/27.
//  Copyright (c) 2015年 Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;



@end
