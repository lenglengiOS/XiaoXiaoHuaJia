//
//  LHLDrawView.h
//  40-画板(界面搭建)
//
//  Created by admin on 16/9/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHLDrawView : UIView


// 清屏
- (void)clean;
// 撤销
- (void)undo;
// 橡皮擦
- (void)erase;
// 设置线宽
- (void)setLineWidth:(CGFloat)lineWith;
// 设置颜色
- (void)setLineColor:(UIColor *)color;
/** 获取到系统相册图片 */
@property (nonatomic, strong) UIImage *image;

@end






