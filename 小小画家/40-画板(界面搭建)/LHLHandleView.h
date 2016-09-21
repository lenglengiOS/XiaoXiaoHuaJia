//
//  LHLHandleView.h
//  40-画板(界面搭建)
//
//  Created by admin on 16/9/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHLHandleView;
@protocol handleViewDelegate <NSObject>

- (void)handleViewDelegate:(LHLHandleView *)handle newImage:(UIImage *)newImage;

@end

@interface LHLHandleView : UIView

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, weak) id<handleViewDelegate> delegate;

@end
