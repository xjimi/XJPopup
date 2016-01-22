//
//  XJPopupBaseView.h
//  XJPopup
//
//  Created by XJIMI on 2016/1/22.
//  Copyright © 2016年 XJIMI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+XJPopupBaseView.h"

typedef enum : NSUInteger {
    XJPopupBackgroundStyleBlack,
    XJPopupBackgroundStyleBlur,
} XJPopupBackgroundStyle;


typedef void(^XJPopupDismissedBlock)(void);

typedef void(^XJPopupBaseViewDismissedBlock)(void);

@interface XJPopupBaseView : UIView

@property (nonatomic, assign) UIView *view;

@property (nonatomic, getter=isFullScreen) BOOL fullScreen;

@property (nonatomic, assign) BOOL needBackground;

@property (nonatomic, assign) BOOL needBlurBackground;

@property (nonatomic, getter=isShowing) BOOL showing;

@property (nonatomic, getter=isDismissWhenTouchBackground) BOOL dismissWhenTouchBackground;

- (void)showPopupWithCompletion:(XJPopupDismissedBlock)completion;

- (void)showPopup;

- (void)dismissPopup;

- (void)addPopupBaseViewDismissBlock:(XJPopupBaseViewDismissedBlock)block;

- (void)addBackgroundView;
- (void)addBlurBackgroundView;


- (void)show;
- (void)showAnimateWithDuration:(NSTimeInterval)duration
                        options:(UIViewAnimationOptions)options
                     animations:(void (^)(void))animations
                     completion:(void (^)(void))completion;

- (void)hide;
- (void)hideAnimateWithDuration:(NSTimeInterval)duration
                        options:(UIViewAnimationOptions)options
                     animations:(void (^)(void))animations
                     completion:(void (^)(void))completion;

@end
