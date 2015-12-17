//
//  XJPopupBaseViewController.h
//  Pods
//
//  Created by XJIMI on 2015/12/16.
//
//

#import <UIKit/UIKit.h>

typedef void(^XJPopupDismissedBlock)(void);

//只用於 XJPopWindow
typedef void(^XJPopupWindowDismissedBlock)(void);


@interface XJPopupBaseViewController : UIViewController

//讓 XJPopupWindow 判斷用 (只用於 XJPopupWindow)
@property (nonatomic, getter=isShowing) BOOL showing;

@property (nonatomic, getter=isDismissWhenTouchBackground) BOOL dismissWhenTouchBackground;

//Sample
+ (void)showPopupWithCompletion:(XJPopupDismissedBlock)completion;
- (void)showPopupWithCompletion:(XJPopupDismissedBlock)completion;

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
//只用於 XJPopupWindow
- (void)addPopupWindowDismissBlock:(XJPopupWindowDismissedBlock)block;

@end
