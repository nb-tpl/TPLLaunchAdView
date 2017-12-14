//
//  TPLLaunchAdViewConfig.h
//  duoweiNews
//
//  Created by tiperTan_HGST_7200_1T on 2017/5/26.
//  Copyright © 2017年 tiperTan_HGST_7200_1T. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TPLLaunchAdViewConfig : NSObject






//用于被覆盖的View
@property(nonatomic,weak)UIView * bottomView;

/**
 *  设置广告的frame(default bottomView.bounds)
 */
@property (nonatomic,assign) CGRect frame;



//image
@property(nonatomic,strong)UIImage * defaultImage;
//网络image
@property(nonatomic,strong)NSString * imageURLString;

//外链
@property(nonatomic,strong)NSString * outADUrl;


/**
 *  停留时间(default 5)
 */
@property(nonatomic,assign)NSInteger duration;
/**
 *  数据请求等待时间(default 3)
 */
@property(nonatomic,assign)NSInteger dataWaitDuration;

//是否允许跳过
@property(nonatomic,assign)BOOL enbleSkip;







//点击的Block
@property(nonatomic,copy)void (^adClicked)(TPLLaunchAdViewConfig * config);
//携带的广告信息，用于点击使用
@property(nonatomic,strong)NSDictionary * params;


@end
