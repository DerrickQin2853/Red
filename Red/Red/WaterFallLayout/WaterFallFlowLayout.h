//
//  WaterFallFlowLayout.h
//  Demo-WaterFall
//
//  Created by admin on 16/7/29.
//  Copyright © 2016年 Derrick_Qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFallFlowLayout;

@protocol WaterFallFlowLayoutDelegate <NSObject>

@required

- (CGFloat)getHeight:(WaterFallFlowLayout *)flowLayout andItemWidth:(CGFloat)width
                andIndexPath:(NSIndexPath *)indexPath;

@end

@interface WaterFallFlowLayout : UICollectionViewFlowLayout

@property(nonatomic, weak) id<WaterFallFlowLayoutDelegate> delegate;

//默认每行显示item个数
@property(nonatomic, assign) NSInteger defaultColCount;

@property (nonatomic, assign) NSInteger sectionCount;

@end
