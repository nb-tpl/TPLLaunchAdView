//
//  TPLLaunchAdView.m
//  duoweiNews
//
//  Created by tiperTan_HGST_7200_1T on 2017/5/26.
//  Copyright © 2017年 tiperTan_HGST_7200_1T. All rights reserved.
//

#import "TPLLaunchAdView.h"

#define FitValue(value) ([TPLLaunchAdView fitFloatValue:value])
#define fitiPhone472iPhone55 (414.0f/375.0f)
#define fitiPhone42iPhone47  (375.0f/320.f)

#define tempValue (414.0f/1080.0f)


@interface TPLLaunchAdView ()


@property(nonatomic,strong)UIImageView * adView;

@property(nonatomic,strong)UIButton * skipButton;

@property(nonatomic,strong)TPLLaunchAdViewConfig * config;

@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,assign)NSInteger tempTime;



@property(nonatomic,assign)BOOL hasShow;

@end

@implementation TPLLaunchAdView
//适配辅助
+(CGFloat)fitFloatValue:(CGFloat)floatValue
{
    
    //4寸
    CGFloat realPoint = floatValue * tempValue;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if ([UIScreen mainScreen].bounds.size.width < 375) {
        return ((realPoint/fitiPhone472iPhone55)/fitiPhone42iPhone47);
    }else if(screenWidth < 414)//4.7
    {
        return realPoint/fitiPhone472iPhone55;
    }else {//5.5
        
        return realPoint;
    }
}

#pragma mark -----viewLife
- (instancetype)initWithConfig:(TPLLaunchAdViewConfig *)config
{
    self = [super initWithFrame:config.bottomView.bounds];
    if (self) {
        self.image = config.defaultImage;
        self.userInteractionEnabled = YES;
        self.config = config;
        self.tempTime = config.dataWaitDuration;
        self.hasShow = NO;
        [self loadSubViews];
    }
    return self;
}


- (void)loadSubViews
{
    self.adView = [[UIImageView alloc] initWithFrame:CGRectIsNull(self.config.frame) || CGRectIsEmpty(self.config.frame) ? self.config.bottomView.bounds : self.config.frame];
    self.adView.userInteractionEnabled = YES;
    [self addSubview:self.adView];
    //点击事件
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adTap)];
    tap.numberOfTapsRequired = 1;
    [self.adView addGestureRecognizer:tap];
}

- (void)loadSkipButton
{
    //跳过按钮
    self.skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat width = self.config.enbleSkip ? FitValue(200) : FitValue(90);
    CGFloat height = FitValue(90);
    self.skipButton.titleLabel.font = [UIFont systemFontOfSize:FitValue(40)];
    
    self.skipButton.frame = CGRectMake(self.bounds.size.width - width - FitValue(60),FitValue(100),width, height);
    
    self.skipButton.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    self.skipButton.layer.cornerRadius =  self.config.enbleSkip ? FitValue(30.f) : FitValue(90)/2.0f;
    
    
    [self.skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    
    [self.skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if (self.config.enbleSkip) {
        [self.skipButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    [self addSubview:self.skipButton];
}

- (void)show
{
    if (self.config.bottomView) {
        [self.config.bottomView addSubview:self];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(skipTimer:) userInfo:nil repeats:YES];
        [self.timer fire];
        
        //如果请求网络
        if(self.config.imageURLString) {
            typeof(self) __weak weak_self = self;
            
            [self setImageView:self.adView withURL:[NSURL URLWithString:[self.config.imageURLString stringByReplacingOccurrencesOfString:@" " withString:@""]] holdImage:self.config.defaultImage completed:^(UIImage *image, NSError *error) {
                weak_self.hasShow = YES;
                [weak_self addSubview:weak_self.adView];
                
                if(weak_self.config.duration > 0){
                    [weak_self loadSkipButton];
                }
                weak_self.tempTime = weak_self.config.duration == 0 ? 4 : weak_self.config.duration;

            }];
        }

    }
}


#pragma mark --- event ---
- (void)skipTimer:(NSTimer *)timer
{
    if(self.skipButton) {
        [self.skipButton setTitle:[NSString stringWithFormat:@"%@%ld",self.config.enbleSkip ? [NSString stringWithFormat:@"%@ ",@"跳过"] : @"",self.tempTime] forState:UIControlStateNormal];
    }
    self.tempTime = self.tempTime - 1;
    if (self.tempTime < 0) {
        [self close];
    }
}

- (void)adTap
{
    if (self.config.adClicked && self.config.outADUrl && ![self.config.outADUrl isEqualToString:@""]) {
        typeof(self.config) __weak weak_config = self.config;
        self.config.adClicked(weak_config);
        //消失
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
    }
}

- (void)close
{
    [self.timer invalidate];
    self.timer = nil;
    [self removeFromSuperview];
}

#pragma mark ------help
- (void)setImageView:(UIImageView *)imageView withURL:(NSURL *)imageURL holdImage:(UIImage *)holdImage completed:(void(^)(UIImage *image, NSError *error))completed
{
    imageView.image = holdImage;
    
    NSURLRequest * request = [NSURLRequest requestWithURL:imageURL];
    NSURLSession * urlSession = [NSURLSession sharedSession];
    NSURLSessionDataTask * dataTask = [urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage * image = [UIImage imageWithData:data];
        dispatch_sync(dispatch_get_main_queue(), ^{
            imageView.image = image;
            completed(image,error);
        });
    }];
    [dataTask resume];
    
}

@end
