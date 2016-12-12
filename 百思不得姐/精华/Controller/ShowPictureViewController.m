//
//  ShowPictureViewController.m
//  百思不得姐
//
//  Created by user on 16/8/30.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "ShowPictureViewController.h"
#import "ToPicModel.h"
#import <UIImageView+WebCache.h>
#import "SVProgressHUD.h"
#import "ProgressView.h"
@interface ShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *imageScreenView;
/** 图片imageView*/
@property(nonatomic,strong)UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet ProgressView *PregreeView;

@end

@implementation ShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat screenH=[UIScreen mainScreen].bounds.size.height;
    CGFloat screenW=[UIScreen mainScreen].bounds.size.width;
    
//    添加图片
    UIImageView *pictureView=[[UIImageView alloc]init];
    [self.imageScreenView addSubview:pictureView];
    
    pictureView.userInteractionEnabled=YES;
    [pictureView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(turnBackAction:)]];
    self.pictureView=pictureView;
//    图片尺寸
    CGFloat pictureW=screenW;
    CGFloat pictureH=pictureW*self.topic.height/self.topic.width;
    
    if (pictureH >screenH) {
        pictureView.frame=CGRectMake(0, 0, pictureW, pictureH);
        self.imageScreenView.contentSize=CGSizeMake(0, pictureH);
    }else
    {
        pictureView.size=CGSizeMake(pictureW, pictureH);
        pictureView.centerY=screenH*0.5;
    }
    self.PregreeView.roundedCorners=2.0;
    self.PregreeView.progressLabel.textColor=[UIColor whiteColor];
    [self.PregreeView setProgress:self.topic.pictureProgress animated:YES];
   
    
    [pictureView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.PregreeView.hidden=NO;
        
          [self.PregreeView setProgress:receivedSize/expectedSize*1.0 animated:YES];
       
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.PregreeView.hidden=YES;
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SaveAction:(id)sender {
    
    UIImageWriteToSavedPhotosAlbum(self.pictureView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
         [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else
    {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}
- (IBAction)ShareAction:(id)sender {
    
}

- (IBAction)turnBackAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
