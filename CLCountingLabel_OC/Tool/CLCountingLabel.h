//
//  CLCountingLabel.h
//  CLCountingLabel_OC
//  
//  ******************** ****************** ********************
//  ******************* ****** ______******* *******************
//  ****************** *_____ /      \ _____* ******************
//  ***************** *(_____(        )_____)* *****************
//  **************** *********\------/********* ****************
//  *************** *********/        \********* ***************
//  ************** *********/    __    \********* **************
//  ************* *********/   ((__))   \********* *************
//  ************ *********(              )********* ************
//  *********** ***********\   ______   /*********** ***********
//  ********** *************\_/| __ |\_/************* **********
//  ********* ****************|||  |||**************** *********
//  ******** ******************\|  |/****************** ********
//  ******* ********************|__|******************** *******
//   ____  __  __ __  __ __  __ __ __  __  ____      __  __ __ __  __ _____  ____
//  |  _  \| | | || \ | || \ | || || \ | |/ --||  _  | \ | || || | | |||---)|  _  \
//  | |_) /| | | ||  \| ||  \| || ||  \| | / __  (_) |  \| || || | | |||--| | |_) /
//  | | \ \| |_| || |\  || |\  || || |\  | \__||     | |\  || || |_| |||___ | | \ \
//  (_|  \ \\___/ |_| \_||_| \_||_||_| \_|\____|     |_| \_||_| \___/ \----)/ /  \_\
//        \_\                                                              /_/
//  JIANSHU  https://www.jianshu.com/u/3f19ff5cda57
//  GITHUB   https://github.com/Loverofcode
//  CSDN     https://blog.csdn.net/u013480070
//
//  Created by RUNNING-NIUER on 2018/11/23.
//  Copyright © 2018 RUNNING_NIUER. All rights reserved.
    

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CLCountingLabelStyle)
{
    CLCountingLabelStyleDefault = 0,
    CLCountingLabelStyleLinear = CLCountingLabelStyleDefault,
    CLCountingLabelStyleEsaeInOut,
    CLCountingLabelStyleEaseIn,
    CLCountingLabelStyleEaseOut,
    CLCountingLabelStyleEaseInBounce,
    CLCountingLabelStyleEaseOutBounce
};

typedef NSString *(^CLCountingLabelFormatBlock)(CGFloat value);

typedef NSAttributedString *(^CLCountingLabelAttributedFormatBlock)(CGFloat value);


NS_ASSUME_NONNULL_BEGIN

@interface CLCountingLabel : UILabel

/** label上面的字体格式*/
@property (nonatomic,strong) NSString* format;

/** 数字滚动的动画样式*/
@property (nonatomic,assign) CLCountingLabelStyle countingStyle;

/** 动画时长*/
@property (nonatomic,assign) NSTimeInterval animationDuration;

/** 设置普通字体格式的回调block*/
@property (nonatomic,copy) CLCountingLabelFormatBlock formatBlock;

/** 设置富文本字体格式的回调block*/
@property (nonatomic,copy) CLCountingLabelAttributedFormatBlock attributedFormatBlock;

/** 动画完成的回调block*/
@property (nonatomic,copy) void(^complitionBlock)(void);


-(void)countFrom:(CGFloat)starValue to:(CGFloat)endValue;
-(void)countFrom:(CGFloat)starValue to:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

-(void)countFromeCurrentValueTo:(CGFloat)endValue;
-(void)countFromeCurrentValueTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

-(void)countFromeZeroTo:(CGFloat)endValue;
-(void)countFromeZeroTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

-(CGFloat)currentValue;


@end

NS_ASSUME_NONNULL_END
