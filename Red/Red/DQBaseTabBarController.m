//
//  DQBaseTabBarController.m
//  Red
//
//  Created by admin on 16/9/9.
//  Copyright © 2016年 Derrick_Qin. All rights reserved.
//

#import "DQBaseTabBarController.h"
#import "DQHomeViewController.h"
#import "DQBaseNavigationController.h"

@interface DQBaseTabBarController ()
@property (nonatomic, strong) NSArray *itemListArray;
@end

@implementation DQBaseTabBarController


//懒加载数据
-(NSArray *)itemListArray{
    //判断数组是否为空
    if (!_itemListArray) {
        
        _itemListArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TabBarList.plist" ofType:nil]];
        
    }
    
    return _itemListArray;
}

//重写初始化方法
-(instancetype)init{
    self = [super init];
    if (self) {
        self.tabBar.translucent = NO;
        [self setupControllers];
        [self setupTabBarItems];
    }
    return self;
}

//设置控制器
- (void)setupControllers{
    //主页VC
    DQHomeViewController *homeVC = [[DQHomeViewController alloc]init];
    //主页Navi
    DQBaseNavigationController *homeNavi = [[DQBaseNavigationController alloc]initWithRootViewController:homeVC];
    
    //待开发
    UIViewController *v2 = [[UIViewController alloc]init];
    UIViewController *v3 = [[UIViewController alloc]init];
    UIViewController *v4 = [[UIViewController alloc]init];
    UIViewController *v5 = [[UIViewController alloc]init];
    
    
    
    [self setViewControllers:@[homeNavi,v2,v3,v4,v5]];
    
}
//设置tababr按钮
-(void)setupTabBarItems{
   
    int i = 0;
    for (UIViewController *vc in self.viewControllers) {
        NSDictionary *dict = self.itemListArray[i];
        vc.tabBarItem.title = dict[@"title"];
        
        
        //设置图片
        UIImage *image = [UIImage imageNamed:dict[@"image"]];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.image = image;
        
        UIImage *selectedImage = [UIImage imageNamed:dict[@"imageSelected"]];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = selectedImage;
        
        //处理文字渲染
        NSDictionary *attributeDict = @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.9608 green:0.0039 blue:0.1961 alpha:1.0]};
        
        [vc.tabBarItem setTitleTextAttributes:attributeDict forState:UIControlStateSelected];
        i ++;
    }


}

@end
