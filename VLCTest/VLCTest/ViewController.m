//
//  ViewController.m
//  VLCTest
//
//  Created by junfeng wang on 2018/5/7.
//  Copyright © 2018年 rswen. All rights reserved.
//

#define rtspUrl @"http://192.168.1.168/0.ts"
#import "ViewController.h"
#import <MobileVLCKit/MobileVLCKit.h>

@interface ViewController ()
@property(nonatomic,strong)UIView * videoView;
@property(nonatomic,strong)VLCMediaPlayer * player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.view addSubview:self.videoView];
    
     [self.player play];
}

-(UIView *)videoView{
    if (!_videoView) {
        _videoView = [[UIView alloc] initWithFrame:self.view.frame];
    }
    return _videoView;
}

-(VLCMediaPlayer *)player{
    if (!_player) {
        //缓存策略设置
        NSDictionary * dict=@{@"network-caching":@"100"};
        VLCMedia * media=[VLCMedia mediaWithURL:[NSURL URLWithString:rtspUrl]];
        media.delegate = self;
        [media addOptions:dict];
       _player = [[VLCMediaPlayer alloc] init];
        //设置硬件解码
        [_player setDeinterlaceFilter:@"blend"];
        _player.media=media;
       _player.drawable = self.videoView;
        _player.media.delegate=self;
    }

    return _player;
}


@end
