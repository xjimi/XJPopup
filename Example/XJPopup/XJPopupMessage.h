//
//  XJPopupMessage.h
//  XJPopup
//
//  Created by XJIMI on 2015/12/16.
//  Copyright © 2015年 XJIMI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJPopupBaseViewController.h"

@interface XJPopupMessage : XJPopupBaseViewController

+ (void)showMessageWithTitle:(NSString *)title
                    subtitle:(NSString *)subtitle
                  completion:(void(^)(void))completion;

@end
