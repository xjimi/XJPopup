//
//  XJViewController.m
//  XJPopup
//
//  Created by XJIMI on 12/16/2015.
//  Copyright (c) 2015 XJIMI. All rights reserved.
//

#import "XJViewController.h"
#import "XJPopupMessage.h"

@interface XJViewController ()

@end

@implementation XJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImage *image = [UIImage imageNamed:@"iPhone-6-Plus-Wallpaper-Paris-1.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [XJPopupMessage showMessageWithTitle:@"錯誤"
                                subtitle:@"帳號或密碼錯誤帳號或密碼錯誤帳號或密碼錯誤帳號或密碼錯誤帳號或密碼錯誤帳號或密碼錯誤帳號或密碼錯誤帳號或密碼錯誤帳號或密碼錯"
                              completion:^
     {

     }];
    
    [XJPopupMessage showMessageWithTitle:@"title 2"
                                subtitle:@"subtitle 2"
                              completion:^
     {

     }];

}


@end
