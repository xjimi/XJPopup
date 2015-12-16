//
//  XJPopupWindow.h
//  Pods
//
//  Created by XJIMI on 2015/12/16.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h> 
#import "XJPopupBaseViewController.h"

#define PortraitW MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define PortraitH MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)

@interface XJPopupWindow : NSObject

+ (instancetype)sharedInstance;

- (void)addPopupViewController:(XJPopupBaseViewController *)viewController;

@end
