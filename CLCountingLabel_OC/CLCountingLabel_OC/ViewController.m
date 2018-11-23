//
//  ViewController.m
//  CLCountingLabel_OC
//  
//  ************************************************************
//  ************************** ______***************************
//  ********************_____ /      \ _____********************
//  *******************(_____(        )_____)*******************
//  **************************\------/**************************
//  *************************/        \*************************
//  ************************/    __    \************************
//  ***********************/   ((__))   \***********************
//  **********************(              )**********************
//  ***********************\   ______   /***********************
//  ************************\_/| __ |\_/************************
//  **************************|||  |||**************************
//  ***************************\|  |/***************************
//  ****************************|__|****************************
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
    

#import "ViewController.h"
#import "CLCountingLabel.h"

@interface ViewController ()
/** 数字滑动label*/
@property (nonatomic,strong) CLCountingLabel* countLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.countLabel.countingStyle = CLCountingLabelStyleEaseIn;
    self.countLabel.format = @"%d";
    [self.countLabel countFrom:1 to:1000 withDuration:1];
}

-(CLCountingLabel *)countLabel {
    if (nil == _countLabel) {
        _countLabel = [[CLCountingLabel alloc] initWithFrame:CGRectMake(100, 100, 150, 30)];
        _countLabel.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:_countLabel];
    }
    return _countLabel;
}


@end
