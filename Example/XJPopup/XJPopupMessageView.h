//
//  XJPopupMessageView.h
//  XJPopup
//
//  Created by XJIMI on 2016/1/22.
//  Copyright © 2016年 XJIMI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJPopupBaseView.h"

#define PortraitW MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define PortraitH MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)

@interface XJPopupMessageView : XJPopupBaseView

+ (void)showMessageWithTitle:(NSString *)title
                    subtitle:(NSString *)subtitle
             backgroundStyle:(XJPopupBackgroundStyle)backgroundStyle
  dismissWhenTouchBackground:(BOOL)dismissWhenTouchBackground
                  showInView:(UIView *)view
                  completion:(void(^)(void))completion;

@end
