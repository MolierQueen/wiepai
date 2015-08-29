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
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property (nonatomic, strong) NSMutableArray * mainArr;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (nonatomic, strong) MPMoviePlayerViewController * moviePlayer;
@property (nonatomic, strong) MPMoviePlayerController * littleMoviePlayer;

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
    [cell.titleLabel setText:[[_mainArr objectAtIndex:indexPath.section] objectForKey:@"title"]];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self createMoviePlaverWithURL:[[_mainArr objectAtIndex:indexPath.section] objectForKey:@"url"]];
//    [self createMoviePlaverWithURL:@"http://pl.youku.com/playlist/m3u8?vid=314349673&type=mp4&ts=1440641398&keyframe=0&ep=cyaQGk%2BJV80J7SHajT8bMinhd3QPXP0L8hyBiNRlA9QtQey6&sid=144064139825512e53330&token=9945&ctype=12&ev=1&oip=1919920105"];
NSLog(@"%@",[[_mainArr objectAtIndex:indexPath.section] objectForKey:@"url"]);
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    CATransform3D rotation;
//    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
//    rotation.m34 = 1.0/ -600;
//    
//    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
//    cell.layer.shadowOffset = CGSizeMake(10, 10);
//    cell.alpha = 0;
//    cell.layer.transform = rotation;
//    cell.layer.anchorPoint = CGPointMake(0, 0.5);
//    
//    
//    [UIView beginAnimations:@"rotation" context:NULL];
//    [UIView setAnimationDuration:0.8];
//    cell.layer.transform = CATransform3DIdentity;
//    cell.alpha = 1;
//    cell.layer.shadowOffset = CGSizeMake(0, 0);
//    [UIView commitAnimations];
//}


#pragma mark -从本地取出数据
- (NSArray *) getData
{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[userDefault objectForKey:@"info"]);
    return [userDefault objectForKey:@"info"];
}

#pragma mark - 添加电影
- (IBAction)addMovieAction:(id)sender {
    [_addButton setEnabled:NO];
//    http://pl.youku.com/playlist/m3u8?vid=314349673&type=mp4&ts=1440641398&keyframe=0&ep=cyaQGk%2BJV80J7SHajT8bMinhd3QPXP0L8hyBiNRlA9QtQey6&sid=144064139825512e53330&token=9945&ctype=12&ev=1&oip=1919920105
    AddView * view = [[AddView alloc] initWithFrame:self.view.frame];
    view.textInfo = ^(NSString* title, NSString * url) {
        if (![title isEqualToString:@""]) {
            NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
            NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:title, @"title",
                                 [self getCurrentTime], @"time",
                                 url, @"url",
                                 @"", @"pic", nil];
            
            [_mainArr addObject:dic];
            [userDefault setObject:_mainArr forKey:@"info"];
            [self.mainTable reloadData];
        }
        [_addButton setEnabled:YES];
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
    
    [dateformatter setDateFormat:@"于yyyy年MM月dd日hh点mm分ss秒创建的视频"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    return locationString;
    
}

#pragma mark - 根据URL创建播放器
-(void)createMoviePlaverWithURL:(NSString *)url
{
    NSURL * movieURL = [NSURL URLWithString:url];
    if (!_littleMoviePlayer) {
        _littleMoviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(movieDown)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:nil];
        [_littleMoviePlayer.view setFrame:self.view.frame];
        [_littleMoviePlayer.view setAlpha:0];
        UIButton * backButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setFrame:CGRectMake(20, 20, 32, 32)];
        [backButton addTarget:self action:@selector(movieDown) forControlEvents:UIControlEventTouchUpInside];
        [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_littleMoviePlayer.view addSubview:backButton];
        
        UIButton * winButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [winButton setFrame:CGRectMake(70, 20, 32, 32)];
        [winButton addTarget:self action:@selector(windowModel) forControlEvents:UIControlEventTouchUpInside];
        [winButton setBackgroundImage:[UIImage imageNamed:@"window"] forState:UIControlStateNormal];
        [_littleMoviePlayer.view addSubview:winButton];
        
        [self.view addSubview:_littleMoviePlayer.view];
        
        [UIView animateWithDuration:0.5 animations:^{
            [_littleMoviePlayer.view setAlpha:1];
        } completion:^(BOOL finished) {
            [self.navigationController.navigationBar setHidden:YES];
        }];
        [_littleMoviePlayer play];
    }
}

#pragma mark -完成播放
-(void)movieDown
{
    [UIView animateWithDuration:0.5 animations:^{
        [_littleMoviePlayer stop];
        [_littleMoviePlayer.view setAlpha:0];
    } completion:^(BOOL finished) {
        [_littleMoviePlayer.view removeFromSuperview];
        _littleMoviePlayer = nil;
        [self.navigationController.navigationBar setHidden:NO];
    }];
}

#pragma mark -窗口播放
-(void)windowModel
{
    [_littleMoviePlayer setControlStyle:MPMovieControlStyleNone];
    [UIView animateWithDuration:0.5 animations:^{
        [self.navigationController.navigationBar setHidden:NO];
        [_littleMoviePlayer.view setFrame:CGRectMake(0, 64, self.view.frame.size.width / 3, self.view.frame.size.width / 3)];
        NSMutableArray * arr = [NSMutableArray arrayWithArray:[_littleMoviePlayer.view subviews]];
        [arr  removeAllObjects];
    } completion:^(BOOL finished) {
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
