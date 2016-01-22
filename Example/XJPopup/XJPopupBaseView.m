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
    self.userInteractionEnabled = NO;    
    self.popupDismissedBlock = completion;
    [self.view.popupQueue addObject:self];
    [self showPopup];
}

- (UIView *)bgView
{
    if (!_bgView)
    {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, PortraitW, PortraitH)];
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
    
    UIWindow *screenWindow = [UIApplication sharedApplication].windows.firstObject;
    UIGraphicsBeginImageContext(screenWindow.frame.size);
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:screenImage];
    imageView.frame = self.bgView.bounds;
    [self.bgView addSubview:imageView];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.bgView.bounds;
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
    [popupView addBlurBackgroundView];

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
    self.bgView.alpha = 0.0f;
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        
        self.bgView.alpha = 1.0f;
        if (animations) animations();
        
    } completion:^(BOOL finished) {
        
        self.userInteractionEnabled = YES;
        if (completion) completion();
        
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
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        
        self.bgView.alpha = 0.0f;
        if (animations) animations();
        
    } completion:^(BOOL finished) {
        
        if (completion) completion();
        
        if (weakSelf.popupDismissedBlock) {
            weakSelf.popupDismissedBlock();
        }
        
        if (weakSelf.popupBaseViewDismissedBlock) {
            weakSelf.popupBaseViewDismissedBlock();
        }
        
    }];
}

- (void)dismissPopup
{
    [self.view.popupQueue removeObjectAtIndex:0];
    NSInteger count = self.view.popupQueue.count;
    if (count) [self showPopup];
    else [self removeAllObjects];
}

- (void)removeAllObjects
{
    NSLog(@"%@", self.view.popupQueue);
    [self.view.popupQueue removeAllObjects];
}

- (void)action_dismiss
{
    if (self.dismissWhenTouchBackground) [self hide];
}


@end
