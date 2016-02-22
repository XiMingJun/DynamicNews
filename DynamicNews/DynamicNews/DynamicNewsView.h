//
//  DynamicNewsView.h
//  DynamicNews
//
//  Created by wangjian on 15/8/6.
//  Copyright (c) 2015年 qhfax. All rights reserved.
//
//展示动态消息
#import <UIKit/UIKit.h>

@interface DynamicNewsView : UIView
@property(nonatomic,copy)void(^dynamicBlock) (long index);//传值 -1 查看更多  >0 动态新闻数组索引
/**
 *  初始化
 *
 *  @param frame
 *
 *  @return 对象
 */
- (instancetype)initWithFrame:(CGRect)frame;
/**
 *  使timer失效
 */
- (void)invalidateTimer;
@end
