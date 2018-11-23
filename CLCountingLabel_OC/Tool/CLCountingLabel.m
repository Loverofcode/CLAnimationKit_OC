//
//  CLCountingLabel.m
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
    

#import "CLCountingLabel.h"

#ifndef kCLLabelCounterRate
#define kCLLabelCounterRate  3.0
#endif


@protocol CLLabelCounterProtocol <NSObject>

-(CGFloat)update:(CGFloat)t;

@end


@interface CLLabelCounterLinear : NSObject<CLLabelCounterProtocol>

@end

@interface CLLabelCounterEaseIn : NSObject<CLLabelCounterProtocol>

@end

@interface CLLabelCounterEaseOut : NSObject<CLLabelCounterProtocol>

@end

@interface CLLabelCounterEaseInOut : NSObject<CLLabelCounterProtocol>

@end

@interface CLLabelCounterEaseInBounce : NSObject<CLLabelCounterProtocol>

@end

@interface CLLabelCounterEaseOutBounce : NSObject<CLLabelCounterProtocol>

@end


@implementation CLLabelCounterLinear
-(CGFloat)update:(CGFloat)t {
    return t;
}
@end

@implementation CLLabelCounterEaseIn
-(CGFloat)update:(CGFloat)t {
    return powf(t, kCLLabelCounterRate);
}
@end

@implementation CLLabelCounterEaseOut
-(CGFloat)update:(CGFloat)t {
    return 1.0 - powf((1.0-t), kCLLabelCounterRate);
}
@end

@implementation CLLabelCounterEaseInOut
-(CGFloat)update:(CGFloat)t {
    t *= 2;
    if (t < 1) {
        return 0.5f * powf(t, kCLLabelCounterRate);
    }
    else {
        return 0.5f * (2.0f - powf(2.0 - t, kCLLabelCounterRate));
    }
}
@end

@implementation CLLabelCounterEaseInBounce
-(CGFloat)update:(CGFloat)t {
    if (t < 4.0/11.0) {
        return 1.0 - (powf(11.0/4.0, 2) * powf(t, 2)) - t;
    }
    else if(t < 8.0/11.0) {
        return 1.0 - (3.0/4.0 + powf(11.0/4.0, 2) * powf(t - 6.0/11.0, 2)) - t;
    }
    else if(t < 10.0/11.0) {
        return 1.0 - (15.0/16.0 + powf(11.0/4/0, 2) * powf(t - 9.0/11.0, 2)) - t;
    }
    else {
        return 1.0 - (63.0/64.0 + powf(11.0/4.0, 2) * powf(t - 21.0/22.0, 2)) - t;
    }
}
@end

@implementation CLLabelCounterEaseOutBounce
-(CGFloat)update:(CGFloat)t {
    if (t < 4.0/11.0) {
        return powf(11.0/4.0, 2) * powf(t, 2);
    }
    else if(t < 8.0/11.0) {
        return 3.0/4.0 + powf(11.0/4.0, 2) * powf(t - 6.0/11.0, 2);
    }
    else if(t < 10.0/11.0) {
        return 15.0/16.0 + powf(11.0/4/0, 2) * powf(t - 9.0/11.0, 2);
    }
    else {
        return 63.0/64.0 + powf(11.0/4.0, 2) * powf(t - 21.0/22.0, 2);
    }
}
@end





@interface CLCountingLabel ()

@property CGFloat startingValue;
@property CGFloat endValue;
@property NSTimeInterval progress;
@property NSTimeInterval lastUpdate;
@property NSTimeInterval totalTime;
@property CGFloat easingRate;

/** 动画计时器*/
@property (nonatomic,strong) CADisplayLink* timer;

/** <#属性描述#>*/
@property (nonatomic,strong) id<CLLabelCounterProtocol> counter;

@end

@implementation CLCountingLabel

-(void)countFrom:(CGFloat)starValue to:(CGFloat)endValue {
    if (self.animationDuration == 0.0f) {
        self.animationDuration = 2.0f;
    }
    [self countFrom:starValue to:endValue withDuration:self.animationDuration];
}

/*~~~~~~~~~~$$$🃏$$$*/
-(void)countFrom:(CGFloat)starValue to:(CGFloat)endValue withDuration:(NSTimeInterval)duration {
    self.startingValue = starValue;
    self.endValue = endValue;
    
    //移除之前的任何计时器
    [self.timer invalidate];
    self.timer = nil;
    
    if (self.format == nil) {
        self.format  = @"%f";
    }
    if (duration == 0.0) {
        //不进行动画
        [self setTextValue:endValue];
        [self runCompletionBlock];
        return;
    }
    
    self.easingRate = 3.0f;
    self.progress = 0;
    self.totalTime = duration;
    self.lastUpdate = [NSDate timeIntervalSinceReferenceDate];//记录本次更新的时间
    
    switch (self.countingStyle) {
        case CLCountingLabelStyleLinear:
            self.counter = [[CLLabelCounterLinear alloc] init];
            break;
        case CLCountingLabelStyleEaseIn:
            self.counter = [[CLLabelCounterEaseIn alloc] init];
            break;
        case CLCountingLabelStyleEaseOut:
            self.counter = [[CLLabelCounterEaseOut alloc] init];
            break;
        case CLCountingLabelStyleEsaeInOut:
            self.counter = [[CLLabelCounterEaseInOut alloc] init];
            break;
        case CLCountingLabelStyleEaseInBounce:
            self.counter = [[CLLabelCounterEaseInBounce alloc] init];
            break;
        case CLCountingLabelStyleEaseOutBounce:
            self.counter = [[CLLabelCounterEaseOutBounce alloc] init];
            break;
            
    }
    
    CADisplayLink *timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateValue:)];
    timer.preferredFramesPerSecond = 100;
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:(NSDefaultRunLoopMode)];
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:(UITrackingRunLoopMode)];
    self.timer = timer;
}
/*$$$🃏$$$~~~~~~~~~~*/

-(void)countFromeCurrentValueTo:(CGFloat)endValue {
    [self countFrom:[self currentValue] to:endValue];
}
-(void)countFromeCurrentValueTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration {
    [self countFrom:[self currentValue] to:endValue withDuration:duration];
}

-(void)countFromeZeroTo:(CGFloat)endValue {
    [self countFrom:0.0f to:endValue];
}
-(void)countFromeZeroTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration {
    [self countFrom:0.0 to:endValue withDuration:duration];
}

-(CGFloat)currentValue {
    if (self.progress >= self.totalTime) {
        return self.endValue;
    }
    
    CGFloat percent = self.progress / self.totalTime;
    CGFloat updateVal = [self.counter update:percent];
    return self.startingValue + (updateVal * (self.endValue - self.startingValue));
}

-(void)setTextValue:(CGFloat)value {
    if (nil != self.attributedFormatBlock) {
        self.attributedText = self.attributedFormatBlock(value);
    }
    else if (nil != self.formatBlock) {
        self.text = self.formatBlock(value);
    }
    else {
        //check if counting with ints - cast to int
        if (NSNotFound != [self.format rangeOfString:@"%(.*)d" options:NSRegularExpressionSearch].location || NSNotFound != [self.format rangeOfString:@"%(.*)i"].location) {
            self.text = [NSString stringWithFormat:self.format, (int)value];
        }
        else {
            self.text = [NSString stringWithFormat:self.format, value];
        }
    }
}

-(void)runCompletionBlock {
    if (self.complitionBlock) {
        self.complitionBlock();
        self.complitionBlock = nil;
    }
}

-(void)updateValue:(NSTimer *)timer {
    //update progress 更新动画进度
    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    self.progress += now - self.lastUpdate;
    self.lastUpdate = now;
    
    if (self.progress >= self.totalTime) {
        [self.timer invalidate];
        self.timer = nil;
        self.progress = self.totalTime;
    }
    
    [self setTextValue:[self currentValue]];
    if (self.progress == self.totalTime) {
        [self runCompletionBlock];
    }
}

@end
