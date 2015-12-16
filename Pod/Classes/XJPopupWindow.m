//
//  XJPopupWindow.m
//  Pods
//
//  Created by XJIMI on 2015/12/16.
//
//

#import "XJPopupWindow.h"

@interface XJPopupWindow ()

@property (nonatomic, strong) UIWindow *presentWindow;
@property (nonatomic, weak)   UIWindow *mainWindow;
@property (nonatomic, strong) NSMutableArray *queue;

@end

@implementation XJPopupWindow

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static XJPopupWindow *instance;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (UIWindow *)presentWindow
{
    if (!_presentWindow) {
        _presentWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _presentWindow.windowLevel = UIWindowLevelStatusBar + 1;
    }
    return _presentWindow;
}

- (NSMutableArray *)queue
{
    if (!_queue) {
        _queue = [NSMutableArray array];
    }
    return _queue;
}

- (void)addPopupViewController:(XJPopupBaseViewController *)viewController
{
    [[XJPopupWindow sharedInstance].queue addObject:viewController];
    [self showPopup];
}

- (void)showPopup
{
    if (![XJPopupWindow sharedInstance].queue.count) return;
    for (XJPopupBaseViewController *vc in [XJPopupWindow sharedInstance].queue) {
        if (vc.isShowing) return;
    }
    
    XJPopupBaseViewController *popupVC = [XJPopupWindow sharedInstance].queue.firstObject;
    popupVC.showing = YES;
    
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    if (keywindow != [XJPopupWindow sharedInstance].presentWindow) {
        [XJPopupWindow sharedInstance].mainWindow = keywindow;
    }
    
    [XJPopupWindow sharedInstance].presentWindow.frame = CGRectMake(0, 0, PortraitW, PortraitH);
    [[XJPopupWindow sharedInstance].presentWindow makeKeyAndVisible];
    [XJPopupWindow sharedInstance].presentWindow.rootViewController = popupVC;
    
    __weak typeof(self)weakSelf = self;
    [popupVC addPopupWindowDismissBlock:^{
        [weakSelf dismissPopup];
    }];
    
    [popupVC show];
}

- (void)dismissPopup
{
    [[XJPopupWindow sharedInstance].queue removeObject:[XJPopupWindow sharedInstance].presentWindow.rootViewController];
    NSInteger count = [XJPopupWindow sharedInstance].queue.count;
    if (count) [self showPopup];
    else [self toggleMainWindow];
}

- (void)toggleMainWindow
{
    [[XJPopupWindow sharedInstance].mainWindow makeKeyAndVisible];
    [XJPopupWindow sharedInstance].presentWindow.rootViewController = nil;
    [XJPopupWindow sharedInstance].presentWindow.frame = CGRectZero;
}

@end
