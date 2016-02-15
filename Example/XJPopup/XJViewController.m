//
//  XJViewController.m
//  XJPopup
//
//  Created by XJIMI on 12/16/2015.
//  Copyright (c) 2015 XJIMI. All rights reserved.
//

#import "XJViewController.h"
#import "XJPopupMessage.h"
#import "XJPopupBaseView.h"
#import "XJPopupMessageView.h"

@interface XJViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation XJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImage *image = [UIImage imageNamed:@"iPhone-6-Plus-Wallpaper-Paris-1.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    
    CGRect imageFrame = self.view.bounds;
    imageFrame.size.height = imageFrame.size.width * (9.0f / 16.0f);
    imageView.frame = imageFrame;
    
    [self.view addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    tap.numberOfTapsRequired = 1;
    [imageView addGestureRecognizer:tap];

    self.imageView = imageView;
}



- (void)singleTap:(UIGestureRecognizer *)recognizer
{
    [XJPopupMessageView showMessageWithTitle:@"title"
                                    subtitle:@"subtitle"
                             backgroundStyle:XJPopupBackgroundStyleBlack
                  dismissWhenTouchBackground:YES
                                  showInView:self.imageView
                                  completion:^{
        
    }];
     

    /*
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
     */
}


@end
