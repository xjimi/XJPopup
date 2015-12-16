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

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"TOUCHED!!");
    [XJPopupMessage showMessageWithTitle:@"title"
                                subtitle:@"subtitle"
                              completion:^
    {
        NSLog(@"showMessageWithTitle");
    }];
}


@end
