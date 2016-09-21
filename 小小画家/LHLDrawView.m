//
//  LHLDrawView.m
//  40-画板(界面搭建)
//
//  Created by admin on 16/9/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LHLDrawView.h"
#import "LHLBezierPath.h"

@interface LHLDrawView ()

@property (nonatomic, strong) LHLBezierPath *path;
@property (nonatomic, strong) NSMutableArray *pathDataArray;
/** 设置线宽 */
@property (nonatomic, assign) CGFloat width;
/** 设置颜色 */
@property (nonatomic, strong) UIColor *color;

@end

@implementation LHLDrawView

- (void)setImage:(UIImage *)image{
    _image = image;
    
    // 把图片添加到数组中
    [self.pathDataArray addObject:image];
    
    // 重绘
    [self setNeedsDisplay];
    
}

// 清屏
- (void)clean{
    
    [self.pathDataArray removeAllObjects];
    // 重绘
    [self setNeedsDisplay];
}
// 撤销
- (void)undo{
    [self.pathDataArray removeLastObject];
    [self setNeedsDisplay];
    
}

// 橡皮擦
- (void)erase{
    self.color = [UIColor whiteColor];
    
}

// 设置线宽
- (void)setLineWidth:(CGFloat)lineWith{
    
    self.width = lineWith;
    [self setNeedsDisplay];
    
}
// 设置颜色
- (void)setLineColor:(UIColor *)color{
    
    self.color = color;

}




- (NSMutableArray *)pathDataArray{
    if (_pathDataArray == nil) {
        _pathDataArray = [NSMutableArray array];
    }
    return _pathDataArray;
}


- (void)awakeFromNib{
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    // 初始化线宽
    self.width = 1;
    self.color = [UIColor blackColor];
    
    
    
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    
    // 获取当前点
    CGPoint point = [pan locationInView:self];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        LHLBezierPath *path = [[LHLBezierPath alloc] init];
        self.path = path;
        
        [path moveToPoint:point];
        
        // 设置线宽
        [path setLineWidth:self.width];
        // 设置边角样式
        [path setLineCapStyle:kCGLineCapRound];
        [path setLineJoinStyle:kCGLineJoinRound];
        // 设置线的颜色
        path.color = self.color;
        
        [self.pathDataArray addObject:path];
        
    }else if (pan.state == UIGestureRecognizerStateChanged){

        // 获取当前点
        
        [self.path addLineToPoint:point];
        // 重绘
        [self setNeedsDisplay];
        
    }
    
}


- (void)drawRect:(CGRect)rect {

    // 画线
    for (LHLBezierPath *path in self.pathDataArray) {
        
        if ([path isKindOfClass:[UIImage class]]) {
            
            UIImage *image = (UIImage *)path;
            [image drawInRect:rect];
        }else{
            
            [path.color set];
            [path stroke];
        }
        
    }
    
    
}


@end
