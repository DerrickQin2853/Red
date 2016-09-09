//
//  WaterFallFlowLayout.m
//  Demo-WaterFall
//
//  Created by admin on 16/7/29.
//  Copyright © 2016年 Derrick_Qin. All rights reserved.
//

#import "WaterFallFlowLayout.h"

@interface WaterFallFlowLayout ()

@property(nonatomic, strong) NSMutableArray *changeAtttributeArray;

@property(nonatomic, assign) NSInteger index;

@property(nonatomic, assign) CGFloat currentMinY;

@property(nonatomic, assign) CGFloat currentMaxY;

@property(nonatomic, strong) NSMutableArray *currentYArray;

@end

@implementation WaterFallFlowLayout

//设置默认每行显示的item为3个
- (NSInteger)defaultColCount {

  if (_defaultColCount == 0) {

    _defaultColCount = 2;
  }

  return _defaultColCount;
}

-(NSInteger)sectionCount{
    
    if (_sectionCount == 0) {
        
        _sectionCount = 1;
    }
    
    return _sectionCount;
}

//准备输出layout
- (void)prepareLayout {

  self.changeAtttributeArray = nil;
  self.currentYArray = nil;
  
    
  //获取Item总数
  NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];

  //遍历获取每个Item

  for (int i = 0; i < itemCount; i++) {

    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];

    //获取改变后的属性
    UICollectionViewLayoutAttributes *layoutAttribute =
        [self layoutAttributesForItemAtIndexPath:indexPath];

    [self.changeAtttributeArray addObject:layoutAttribute];
      
  }
    
    self.footerReferenceSize = CGSizeMake(375, 10);
    
    //设置Footer的layout属性
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    UICollectionViewLayoutAttributes *footerViewAttribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:indexPath];
    
    footerViewAttribute.frame = CGRectMake(0, self.currentMaxY + self.sectionInset.bottom, self.collectionView.bounds.size.width, self.footerReferenceSize.height);
    
    [self.changeAtttributeArray addObject:footerViewAttribute];
    
}

/**
 *  返回当前区域内可见item的属性
 *
 *  @param rect
 *
 *  @return
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)
layoutAttributesForElementsInRect:(CGRect)rect {
    
  return self.changeAtttributeArray;

}

/**
 *  这个方法把每个item做改变后,就可以得到想要的界面
 *
 *  @param indexPath
 *
 *  @return
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:
    (NSIndexPath *)indexPath {
  //获取原始状态的layout属性
  UICollectionViewLayoutAttributes *originLayoutAttributes =
      [super layoutAttributesForItemAtIndexPath:indexPath];

  //宽= 屏幕的宽度 - sectionInsetLeft-sectionInsetRight - （控件的数量 -1
  //）*间距的宽度 /控件的数量 ;
  CGFloat itemAttributeWidth =
      (self.collectionView.bounds.size.width - self.sectionInset.left -
       self.sectionInset.right -
       (self.defaultColCount - 1) * self.minimumInteritemSpacing) /
      self.defaultColCount;
  
    
    CGFloat itemAttributeHeight = [self.delegate getHeight:self andItemWidth:itemAttributeWidth andIndexPath:indexPath];

  //计算Y  从数组中获取最小的Y + 行间距

  CGFloat itemAttributeY = self.currentMinY + self.minimumLineSpacing;

  //计算x   间距 + 索引 * （间距 + 控件的宽）

  CGFloat itemAttributeX =
      self.sectionInset.left +
      self.index * (self.minimumInteritemSpacing + itemAttributeWidth);

  //给数组中对应的Y做个更新

  self.currentYArray[self.index] = @(itemAttributeHeight + itemAttributeY);

  //更新frame

  originLayoutAttributes.frame = CGRectMake(
      itemAttributeX, itemAttributeY, itemAttributeWidth, itemAttributeHeight);

  return originLayoutAttributes;
}

//设置collection View的滑动区域
- (CGSize)collectionViewContentSize {

  return CGSizeMake(self.sectionCount * [UIScreen mainScreen].bounds.size.width, self.currentMaxY + self.sectionInset.bottom +
                           self.footerReferenceSize.height);
}

//懒加载
- (NSMutableArray *)changeAtttributeArray {

  if (_changeAtttributeArray == nil) {

    _changeAtttributeArray = [NSMutableArray array];
  }

  return _changeAtttributeArray;
}

- (NSMutableArray *)currentYArray {

  if (_currentYArray == nil) {
    _currentYArray = [NSMutableArray array];

    for (int i = 0; i < self.defaultColCount; i++) {

      [_currentYArray addObject:@"0"];
    }
  }

  return _currentYArray;
}

//重写get方法获得当前存放Y属性的数组中 最大的Y
- (CGFloat)currentMaxY {

  _currentMaxY = 0;

  for (int i = 0; i < self.defaultColCount; i++) {

    CGFloat currentY = [self.currentYArray[i] doubleValue];

    if (currentY > _currentMaxY) {

      _currentMaxY = currentY;
    }
  }

  return _currentMaxY;
}

//重写get方法获得当前存放Y属性的数组中 最小的Y
- (CGFloat)currentMinY {

  _currentMinY = CGFLOAT_MAX;

  for (int i = 0; i < self.defaultColCount; i++) {

    CGFloat currentY = [self.currentYArray[i] doubleValue];

    if (currentY < _currentMinY) {

      _currentMinY = currentY;
      _index = i;
    }
  }
  return _currentMinY;
}





@end
