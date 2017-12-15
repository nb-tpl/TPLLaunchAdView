//
//  ViewController.m
//  TPLLaunchAdView
//
//  Created by tiperTan on 2017/12/11.
//  Copyright © 2017年 tiperTan. All rights reserved.
//

#import "ViewController.h"

#import "TPLLaunchAdView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadLaunchAdView];
}


//开屏广告
- (void)loadLaunchAdView
{
    //此处同步请求广告
    
    TPLLaunchAdViewConfig * config = [[TPLLaunchAdViewConfig alloc] init];
    config.bottomView = self.view;
    config.frame = CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height);
    //                config.imageURLString = [dataDict objectForKey:@"ad_pic_url"];
    config.imageURLString = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1513243429326&di=80eb5baba46a34fd6c9ea1fcd2e1a5d5&imgtype=0&src=http%3A%2F%2Fi1.hdslb.com%2Fbfs%2Farchive%2F3b0b3fcd0a5b599d5e50915e8c6e25b501d4befd.jpg";
    config.duration = 20;//[[dataDict objectForKey:@"play_times"] integerValue];
    
    config.enbleSkip = NO;//[[dataDict objectForKey:@"ad_allow_skip"] boolValue];
    config.defaultImage = [UIImage imageNamed:@"default_Ad.png"];
    //                config.outADUrl = dataDict[@"ad_outside_url"];
    config.outADUrl = @"www.baidu.com";
    //广告数据请求超时时间
    config.dataWaitDuration = 5;
    config.adClicked = ^(TPLLaunchAdViewConfig * config) {
        
        
        NSLog(@"广告点击了");
        
//        if(dataDict[@"ad_outside_url"] == nil || [dataDict[@"ad_outside_url"] isEqualToString:@""])
//        {
//            return;
//        }
        
    };
    
  TPLLaunchAdView * launchAdView = [[TPLLaunchAdView alloc] initWithConfig:config];

    //如果有广告
    if(launchAdView){
        [launchAdView show];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
