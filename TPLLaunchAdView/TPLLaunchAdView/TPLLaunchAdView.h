//
//  TPLLaunchAdView.h
//  duoweiNews
//
//  Created by tiperTan_HGST_7200_1T on 2017/5/26.
//  Copyright © 2017年 tiperTan_HGST_7200_1T. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TPLLaunchAdViewConfig.h"
@interface TPLLaunchAdView : UIImageView


- (instancetype)initWithConfig:(TPLLaunchAdViewConfig *)config;

- (void)show;
@end
