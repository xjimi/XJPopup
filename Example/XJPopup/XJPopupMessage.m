//
//  XJPopupMessage.m
//  XJPopup
//
//  Created by XJIMI on 2015/12/16.
//  Copyright © 2015年 XJIMI. All rights reserved.
//

#import "XJPopupMessage.h"

@implementation XJPopupMessage

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

+ (void)showMessageWithTitle:(NSString *)title
                    subtitle:(NSString *)subtitle
                  completion:(void(^)(void))completion
{
    XJPopupMessage *popupMessage = [XJPopupMessage new];
    [popupMessage addBackgroundView];
    [popupMessage showPopupCompletion:completion];
}

- (void)showAnimations
{
    NSLog(@"show animations---");
}

- (void)hideAnimations
{
    NSLog(@"---- hide animations---");
}

@end
