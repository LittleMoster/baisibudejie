//
//  loginRegisterViewController.m
//  百思不得姐
//
//  Created by user on 16/8/4.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "loginRegisterViewController.h"

@interface loginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LoginLeftLoyout;
@property (weak, nonatomic) IBOutlet UIImageView *BgViewImage;

@end

@implementation loginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      [self.view insertSubview:self.BgViewImage atIndex:0];
}
- (IBAction)backaction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)ZhuCeShowAction:(UIButton *)sender {
    NSLog(@"fdjkdshklshd");
     NSLog(@"fdjkdshklshd");

    //退出键盘
    [self.view endEditing:YES];
    
    if (self.LoginLeftLoyout.constant==0) {
        self.LoginLeftLoyout.constant=-self.view.width;
        [sender setTitle:@"已有账号?" forState:UIControlStateNormal
         ];
    }else
    {
         self.LoginLeftLoyout.constant=0;
        [sender setTitle:@"注册账号" forState:UIControlStateNormal
         ];
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 让当前控制器对应的状态栏是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
