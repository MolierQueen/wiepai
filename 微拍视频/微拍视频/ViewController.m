//
//  ViewController.m
//  微拍视频
//
//  Created by Oliver on 15/8/27.
//  Copyright (c) 2015年 Oliver. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"
#import "MovieModel.h"
#import "AddView.h"

static BOOL mark = YES;
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property (nonatomic, strong) NSMutableArray * mainArr;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _mainArr = [[NSMutableArray alloc] initWithArray:[self getData]];
    [self.view setBackgroundColor:[UIColor blueColor]];
}


#pragma mark - 代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell"];
    }
    [cell.timeLabel setText:[[_mainArr objectAtIndex:indexPath.section] objectForKey:@"title"]];
    [cell.timeLabel setText:[[_mainArr objectAtIndex:indexPath.section] objectForKey:@"time"]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_mainArr count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 153;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_mainArr removeObjectAtIndex:indexPath.section];
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:_mainArr forKey:@"info"];
    [self.mainTable reloadData];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除该电影";
}

#pragma mark -从本地取出数据
- (NSArray *) getData
{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[userDefault objectForKey:@"info"]);
    return [userDefault objectForKey:@"info"];
}

#pragma mark - 添加电影
- (IBAction)addMovieAction:(id)sender {
    if (mark) {
        [_addButton setEnabled:NO];
        mark = NO;
    } else {
        [_addButton setEnabled:YES];
        mark = YES;
    }
//    http://pl.youku.com/playlist/m3u8?vid=314349673&type=mp4&ts=1440641398&keyframe=0&ep=cyaQGk%2BJV80J7SHajT8bMinhd3QPXP0L8hyBiNRlA9QtQey6&sid=144064139825512e53330&token=9945&ctype=12&ev=1&oip=1919920105
    AddView * view = [[AddView alloc] initWithFrame:self.view.frame];
    view.textInfo = ^(NSString* title, NSString * url) {
        NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
        NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:title, @"title",
                             [self getCurrentTime], @"time",
                             url, @"url",
                             @"", @"pic", nil];

        [_mainArr addObject:dic];
        [userDefault setObject:_mainArr forKey:@"info"];
        [self.mainTable reloadData];
    };
    
    [self.view addSubview:view];
}

#pragma mark - 搜索电影
- (IBAction)searchMovieAction:(id)sender {
}

#pragma mark - scrollView代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:1 animations:^{
        [self.mainImage setAlpha:scrollView.contentOffset.y / 1000];
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - 获取当前时间
- (NSString*)getCurrentTime
{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"于yyyy年MM月dd日hh点创建的视频"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    return locationString;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
