//
//  XJPopupBaseView.m
//  XJPopup
//
//  Created by XJIMI on 2016/1/22.
//  Copyright © 2016年 XJIMI. All rights reserved.
//

#import "XJPopupBaseView.h"

#define PortraitW MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define PortraitH MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)

@interface XJPopupBaseView ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, copy) XJPopupDismissedBlock popupDismissedBlock;
@property (nonatomic, copy) XJPopupBaseViewDismissedBlock popupBaseViewDismissedBlock;

@end

@implementation XJPopupBaseView

- (void)showPopupWithCompletion:(XJPopupDismissedBlock)completion
{
    self.popupDismissedBlock = completion;
    [self.view.popupQueue addObject:self];
    [self showPopup];
}

- (UIView *)bgView
{
    if (!_bgView)
    {
        UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
        bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.8];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action_dismiss)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        [bgView addGestureRecognizer:tapGestureRecognizer];
        _bgView = bgView;
    }
    return _bgView;
}

- (void)addBackgroundView {
    
    [self insertSubview:self.bgView atIndex:0];
}

- (void)addBlurBackgroundView
{
    [self addBackgroundView];
    
    CGRect captureFrame = self.bgView.frame;
    UIWindow *screenWindow = [UIApplication sharedApplication].windows.firstObject;
    UIGraphicsBeginImageContext(captureFrame.size);
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:screenImage];
    imageView.frame = captureFrame;
    [self.bgView addSubview:imageView];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = captureFrame;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    blurEffectView.userInteractionEnabled = NO;
    [self.bgView addSubview:blurEffectView];
}

- (void)addPopupBaseViewDismissBlock:(XJPopupBaseViewDismissedBlock)block
{
    self.popupBaseViewDismissedBlock = block;
}

- (void)showPopup
{
    if (!self.view.popupQueue.count) return;
    for (XJPopupBaseView *v in self.view.popupQueue) {
        if (v.isShowing) return;
    }

    XJPopupBaseView *popupView = self.view.popupQueue.firstObject;
    popupView.showing = YES;
    popupView.frame = self.view.frame;
    if (self.backgroundStyle == XJPopupBackgroundStyleBlur) {
        [popupView addBlurBackgroundView];
    } else if (self.backgroundStyle == XJPopupBackgroundStyleBlack) {
        [popupView addBackgroundView];
    } else if (self.backgroundStyle == XJPopupBackgroundStyleNone) {
        [popupView addBackgroundView];
        self.bgView.backgroundColor = [UIColor clearColor];
    }
    
    [self.view addSubview:popupView];
    
    __weak typeof(self)weakSelf = self;
    [popupView addPopupBaseViewDismissBlock:^{
        [weakSelf dismissPopup];
    }];
    
    [popupView show];
}

- (void)show
{
    [self showAnimateWithDuration:0.4f options:(7 << 16) animations:^{
    } completion:^{
    }];
}

- (void)showAnimateWithDuration:(NSTimeInterval)duration
                        options:(UIViewAnimationOptions)options
                     animations:(void (^)(void))animations
                     completion:(void (^)(void))completion
{
    self.view.userInteractionEnabled = NO;
    self.bgView.alpha = 0.0f;
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        
        self.bgView.alpha = 1.0f;
        if (animations) animations();
        
    } completion:^(BOOL finished) {
        
        if (completion) completion();
        self.view.userInteractionEnabled = YES;
        
    }];
}

- (void)hide
{
    [self hideAnimateWithDuration:0.04f options:(7 << 16) animations:^{
    } completion:^{
    }];
}

- (void)hideAnimateWithDuration:(NSTimeInterval)duration
                        options:(UIViewAnimationOptions)options
                     animations:(void (^)(void))animations
                     completion:(void (^)(void))completion
{
    self.view.userInteractionEnabled = NO;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        
        self.bgView.alpha = 0.0f;
        if (animations) animations();
        
    } completion:^(BOOL finished) {
        
        if (completion) completion();
        
        if (weakSelf.popupDismissedBlock) weakSelf.popupDismissedBlock();
        
        if (weakSelf.popupBaseViewDismissedBlock) weakSelf.popupBaseViewDismissedBlock();
        
        self.view.userInteractionEnabled = YES;

    }];
}

- (void)dismissPopup
{
    for (XJPopupBaseView *popupView in self.view.popupQueue)
    {
        if (popupView.isShowing)
        {
            [popupView removeFromSuperview];
            [self.view.popupQueue removeObject:popupView];
            break;
        }
    }
    
    NSInteger count = self.view.popupQueue.count;
    if (count) [self showPopup];
    else [self removeAllObjects];
}

- (void)removeAllObjects
{
    [self.view.popupQueue removeAllObjects];
}

- (void)action_dismiss
{
    if (self.dismissWhenTouchBackground) [self hide];
}

@end
