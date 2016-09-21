//
//  ViewController.m
//  40-画板(界面搭建)
//
//  Created by admin on 16/9/9.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ViewController.h"
#import "LHLDrawView.h"
#import "LHLHandleView.h"


@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, handleViewDelegate>
@property (weak, nonatomic) IBOutlet LHLDrawView *drawView;

@end

@implementation ViewController
// 清屏
- (IBAction)clean:(id)sender {
    
    [self.drawView clean];
}
// 撤销
- (IBAction)undo:(id)sender {
    [self.drawView undo];
}
// 橡皮擦
- (IBAction)erase:(id)sender {
    
    [self.drawView erase];
}
// 设置线宽
- (IBAction)setLineWidth:(UISlider *)sender {
    
    [self.drawView setLineWidth:sender.value];
}

// 设置颜色
- (IBAction)setLineColor:(UIButton *)sender {
    
    [self.drawView setLineColor:sender.backgroundColor];
    
}


// 照片
- (IBAction)photo:(id)sender {
    
    // 从系统当中选择一张图片
    UIImagePickerController *pickVc = [[UIImagePickerController alloc] init];
    // 设置进入相册 类型
    pickVc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    // 设置代理
    pickVc.delegate = self;
    
    [self presentViewController:pickVc animated:YES completion:nil];
    
}


#pragma mark - 从系统当中选择一张图片 代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSLog(@"%@", info);
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    
    
    LHLHandleView *handleV = [[LHLHandleView alloc] init];
    handleV.frame = self.drawView.frame;
    handleV.image = image;
    handleV.backgroundColor =[UIColor clearColor];
    
    [self.view addSubview:handleV];
    
    handleV.delegate = self;
    
    
    // 取消弹出到相册
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)handleViewDelegate:(LHLHandleView *)handle newImage:(UIImage *)newImage{
    
    self.drawView.image = newImage;
    
}


// 保存
- (IBAction)save:(id)sender {
    
    // 开启一个位图上下文
    UIGraphicsBeginImageContext(self.drawView.bounds.size);
    
    // 把图片渲染到上下文
    
      // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.drawView.layer renderInContext:ctx];
    
    // 生成图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    // 把图片保存到相册
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"success");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)prefersStatusBarHidden{
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
