//
//  LaunchViewController.m
//  BreadTripWXQ
//
//  Created by 王小琪 on 16/12/26.
//  Copyright © 2016年 王小琪. All rights reserved.
//

#import "LaunchViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PremViewController.h"
#import "AppDelegate.h"
@interface LaunchViewController ()
{
    AVPlayerItem *playerItem;
    AVPlayerLayer *avPlayerLayer;
    AVPlayer *avPlayer;
}
@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setLaunchMeida];
}
// 视频播放
- (void)setLaunchMeida {
    // 在视图上添加播放器
    playerItem = [[AVPlayerItem alloc] initWithURL:self.url];
    avPlayer = [AVPlayer playerWithPlayerItem:playerItem];
    //必须添加到 layer 上
    avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
    [self.view.layer addSublayer:avPlayerLayer];
    
    // 设置播放页面大小
    avPlayerLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    // 在视图上添加播放器
    [self.view.layer addSublayer:avPlayerLayer];
    
    // 添加一个过渡的效果
    self.view.alpha = 0.3;
    [UIView animateWithDuration:2 animations:^{
        self.view.alpha = 1;
        // 开始播放
        [avPlayer play];
    }];
    
    // 添加通知
    [self addNotification];
    
    // 添加按钮
    [self setupLoginView];
    
}
-(void)addNotification{
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:avPlayer.currentItem];
}
/**
 *  播放完成通知
 *
 *  @param notification 通知对象
 */
-(void)playbackFinished:(NSNotification *)notification{
    NSLog(@"视频播放完成");
    // 播放完成后重复播放
    // 跳到最新的时间点开始播放
    [avPlayer seekToTime:CMTimeMake(0, 1)];
    // 添加一个过渡的效果
    self.view.alpha = 0.3;
    [UIView animateWithDuration:2 animations:^{
        self.view.alpha = 1;
        // 开始播放
        [avPlayer play];
    }];

}
- (void)dealloc {
    [self removeNotification];
}
// 暂时不调用该移除方法 （移除之后会导致视频不循环）
-(void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupLoginView {
    //进入按钮
    UIButton *enterMainButton = [[UIButton alloc] init];
    enterMainButton.frame = CGRectMake(24, [UIScreen mainScreen].bounds.size.height - 32 - 48, [UIScreen mainScreen].bounds.size.width - 48, 48);
    enterMainButton.layer.borderWidth = 1;
    enterMainButton.layer.cornerRadius = 24;
    enterMainButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [enterMainButton setTitle:@"开启面包之旅" forState:UIControlStateNormal];
    enterMainButton.alpha = 0;
    [self.view addSubview:enterMainButton];
    [enterMainButton addTarget:self action:@selector(enterMainAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView animateWithDuration:1.0 animations:^{
        enterMainButton.alpha = 1.0;
    }];
}

// 进入应用
- (void)enterMainAction:(UIButton *)btn {
    NSLog(@"进入应用");
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[PremViewController alloc] init]];
    app.window.backgroundColor = [UIColor colorWithRed:255/250.0 green:250/250.0 blue:240/250.0 alpha:1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
