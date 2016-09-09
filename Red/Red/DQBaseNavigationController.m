//
//  DQBaseNavigationController.m
//  Red
//
//  Created by admin on 16/9/9.
//  Copyright © 2016年 Derrick_Qin. All rights reserved.
//

#import "DQBaseNavigationController.h"

@interface DQBaseNavigationController ()

@end

@implementation DQBaseNavigationController

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    
    self = [super initWithRootViewController:rootViewController];
    
    if (self) {
        //关高斯模糊
        self.navigationBar.translucent = NO;
        //渲染颜色
        self.navigationBar.barTintColor = [UIColor colorWithRed:1.0 green:0.0786 blue:0.2518 alpha:1.0];
        
    }
    return self;
}


//亮色状态栏
-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

@end
